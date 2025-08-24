package data.controllers.admin;

import data.models.User;
import data.models.Category;
import data.dao.CategoryDao;
import data.impl.CategoryImpl;
import data.dao.ProductDao;
import data.impl.ProductImpl;
import data.models.Product;
import java.io.IOException;
import java.io.PrintWriter;
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
import java.nio.file.Paths;
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
        
        // Fetch categories for the form
        CategoryDao categoryDao = new CategoryImpl();
        List<Category> categories = categoryDao.findAll();
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
            // Get form data
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Handle category creation or selection
            String categoryInput = request.getParameter("idCategory");
            String newCategoryName = request.getParameter("newCategoryName");
            
            // Debug logging
            System.out.println("DEBUG - categoryInput: " + categoryInput);
            System.out.println("DEBUG - newCategoryName: " + newCategoryName);
            
            int idCategory;
            
            // Check if user wants to create new category
            if (newCategoryName != null && !newCategoryName.trim().isEmpty()) {
                // Create new category
                Category newCategory = new Category();
                newCategory.setName(newCategoryName.trim());
                
                CategoryDao categoryDao = new CategoryImpl();
                boolean categoryCreated = categoryDao.create(newCategory);
                
                if (categoryCreated) {
                    // Get the newly created category ID
                    List<Category> categories = categoryDao.findAll();
                    idCategory = categories.stream()
                        .filter(cat -> cat.getName().equals(newCategoryName.trim()))
                        .findFirst()
                        .map(Category::getId)
                        .orElse(1); // fallback to first category if not found
                } else {
                    request.setAttribute("error", "Không thể tạo danh mục mới");
                    doGet(request, response);
                    return;
                }
            } else if (categoryInput != null && !categoryInput.trim().isEmpty()) {
                // Use existing category
                idCategory = Integer.parseInt(categoryInput);
            } else {
                request.setAttribute("error", "Vui lòng chọn danh mục hoặc tạo danh mục mới");
                doGet(request, response);
                return;
            }
            
            boolean status = "1".equals(request.getParameter("status"));
            
            // Handle file upload
            Part filePart = request.getPart("image");
            String fileName = null;
            
            System.err.println("name: " + name);
            System.err.println("price: " + price);
            System.err.println("quantity: " + quantity);
            System.err.println("categoryInput: " + categoryInput);
            System.err.println("newCategoryName: " + newCategoryName);
            System.err.println("status: " + status);
            System.err.println("filePart: " + filePart);

            if (filePart != null && filePart.getSize() > 0) {
                // Get file extension
                String submittedFileName = filePart.getSubmittedFileName();
                String fileExtension = "";
                if (submittedFileName != null && submittedFileName.contains(".")) {
                    fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                }
                
                // Generate unique filename
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                
                // Create uploads directory if it doesn't exist
                String uploadPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
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
