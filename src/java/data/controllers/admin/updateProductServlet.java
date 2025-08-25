package data.controllers.admin;

import data.models.User;
import data.models.Product;
import data.models.Category;
import data.dao.Database;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.UUID;

@WebServlet(name = "updateProductServlet", urlPatterns = {"/admin/updateproduct"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class updateProductServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền admin
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Lấy ID sản phẩm từ parameter
        String productId = request.getParameter("id");
        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/allproduct");
            return;
        }
        
        try {
            int id = Integer.parseInt(productId);
            
            // Lấy thông tin sản phẩm cần update
            Product product = Database.getProductsDao().findById(id);
            if (product == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                response.sendRedirect(request.getContextPath() + "/admin/allproduct");
                return;
            }
            
            // Lấy danh sách categories để hiển thị trong form
            List<Category> categories = Database.getCategoriesDao().findAll();
            
            // Set attributes để truyền sang JSP
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            
            // Forward đến trang update
            request.getRequestDispatcher("/views/admin/updateproduct.jsp").include(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sản phẩm không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/allproduct");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền admin
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Lấy thông tin sản phẩm từ form modal
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int idCategory = Integer.parseInt(request.getParameter("idCategory"));
            boolean status = "1".equals(request.getParameter("status"));
            
            // Lấy sản phẩm hiện tại từ database
            Product currentProduct = Database.getProductsDao().findById(productId);
            if (currentProduct == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                response.sendRedirect(request.getContextPath() + "/admin/allproduct");
                return;
            }
            
            // Xử lý upload hình ảnh mới (nếu có)
            Part filePart = request.getPart("image");
            String imagePath = currentProduct.getImage(); // Giữ nguyên ảnh cũ nếu không upload mới
            
            if (filePart != null && filePart.getSize() > 0) {
                // Có upload ảnh mới
                String submittedFileName = filePart.getSubmittedFileName();
                String fileExtension = "";
                if (submittedFileName != null && submittedFileName.contains(".")) {
                    fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                }
                
                // Tạo tên file mới
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                
                // Lưu file vào thư mục uploads
                String webRootPath = getServletContext().getRealPath("/");
                String uploadPath;
                
                if (webRootPath.contains("build")) {
                    String projectRootPath = webRootPath.substring(0, webRootPath.indexOf("build"));
                    uploadPath = projectRootPath + "web" + File.separator + "uploads";
                } else {
                    uploadPath = "web" + File.separator + "uploads";
                }
                
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Lưu file mới
                String filePath = uploadPath + File.separator + uniqueFileName;
                filePart.write(filePath);
                
                // Cập nhật đường dẫn ảnh
                imagePath = "uploads/" + uniqueFileName;
            }
            
            // Cập nhật thông tin sản phẩm
            currentProduct.setName(name);
            currentProduct.setImage(imagePath);
            currentProduct.setPrice(price);
            currentProduct.setQuantity(quantity);
            currentProduct.setStatus(status);
            currentProduct.setIdCategory(idCategory);
            
            // Lưu vào database
            boolean success = Database.getProductsDao().update(currentProduct);
            
            if (success) {
                // Redirect về trang danh sách sản phẩm với thông báo thành công
                response.sendRedirect(request.getContextPath() + "/admin/allproduct?success=updated");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật sản phẩm");
                response.sendRedirect(request.getContextPath() + "/admin/allproduct");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/allproduct");
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/allproduct");
        }
    }

    @Override
    public String getServletInfo() {
        return "Update Product Servlet";
    }
}
