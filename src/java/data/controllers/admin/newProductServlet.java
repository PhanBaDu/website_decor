package data.controllers.admin;

import data.models.User;
import data.models.Category;
import data.dao.CategoryDao;
import data.dao.Database;
import data.impl.CategoryImpl;
import data.dao.ProductDao;
import data.impl.ProductImpl;
import data.models.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.List;
import java.io.File;
import java.util.UUID;

@WebServlet(name = "newProductServlet", urlPatterns = {"/admin/newproduct"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class newProductServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        List<Category> categories = Database.getCategoriesDao().findAll();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/views/admin/newproduct.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String categoryInput = request.getParameter("idCategory");
            String newCategoryName = request.getParameter("newCategoryName");
            
            int idCategory;
            
            if (newCategoryName != null && !newCategoryName.trim().isEmpty()) {
                // Check if category name already exists (case-insensitive)
                CategoryDao categoryDao = new CategoryImpl();
                if (categoryDao.existsByName(newCategoryName.trim())) {
                    request.setAttribute("error", "Danh mục '" + newCategoryName.trim() + "' đã tồn tại. Vui lòng chọn tên khác.");
                    doGet(request, response);
                    return;
                }
                
                // Create new category
                Category newCategory = new Category();
                newCategory.setName(newCategoryName.trim());
                
                boolean categoryCreated = categoryDao.create(newCategory);
                
                if (categoryCreated) {
                    List<Category> categories = categoryDao.findAll();
                    idCategory = categories.stream()
                        .filter(cat -> cat.getName().equals(newCategoryName.trim()))
                        .findFirst()
                        .map(Category::getId)
                        .orElse(1);
                } else {
                    request.setAttribute("error", "Không thể tạo danh mục mới");
                    doGet(request, response);
                    return;
                }
            } else if (categoryInput != null && !categoryInput.trim().isEmpty()) {
                idCategory = Integer.parseInt(categoryInput);
            } else {
                request.setAttribute("error", "Vui lòng chọn danh mục hoặc tạo danh mục mới");
                doGet(request, response);
                return;
            }
            
            boolean status = "1".equals(request.getParameter("status"));
            
            Part filePart = request.getPart("image");
            String fileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                // Get file extension
                String submittedFileName = filePart.getSubmittedFileName();
                String fileExtension = "";
                if (submittedFileName != null && submittedFileName.contains(".")) {
                    fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                }
                
                // Generate unique filename
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                
                // Save to web/uploads directory (not build directory)
                String webRootPath = getServletContext().getRealPath("/");
                String uploadPath;
                
                // Try to find the project root by looking for 'web' directory
                if (webRootPath.contains("build")) {
                    // We're in build directory, go up to project root
                    String projectRootPath = webRootPath.substring(0, webRootPath.indexOf("build"));
                    uploadPath = projectRootPath + "web" + File.separator + "uploads";
                } else {
                    // We're already in project root or different environment
                    // Use relative path from current working directory
                    uploadPath = "web" + File.separator + "uploads";
                }
                
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Debug logging
                System.out.println("DEBUG - webRootPath: " + webRootPath);
                System.out.println("DEBUG - uploadPath: " + uploadPath);
                System.out.println("DEBUG - uploadDir.exists(): " + uploadDir.exists());
                
                // Save file
                String filePath = uploadPath + File.separator + uniqueFileName;
                filePart.write(filePath);
                
                // Store relative path for database
                fileName = "uploads/" + uniqueFileName;
            } else {
                request.setAttribute("error", "Vui lòng chọn hình ảnh sản phẩm");
                doGet(request, response);
                return;
            }
            
            // Create product object
            Product product = new Product();
            product.setName(name);
            product.setImage(fileName);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setIdCategory(idCategory);
            
            // Save product
            ProductDao productDao = new ProductImpl();
            boolean success = productDao.create(product);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/allproduct");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi tạo sản phẩm");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "New Product Servlet";
    }
}
