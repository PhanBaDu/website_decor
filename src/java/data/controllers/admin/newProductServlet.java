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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "newProductServlet", urlPatterns = {"/admin/newproduct"})
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
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int idCategory = Integer.parseInt(request.getParameter("idCategory"));
            boolean status = "1".equals(request.getParameter("status"));
            
            // Create product object
            Product product = new Product();
            product.setName(name);
            product.setImage(image);
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
