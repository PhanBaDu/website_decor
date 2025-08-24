package data.controllers.admin;

import data.models.User;
import data.models.Product;
import data.models.Category;
import data.dao.Database;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "allProductServlet", urlPatterns = {"/admin/allproduct"})
public class allProductServlet extends HttpServlet {

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
        
        // Fetch all products and categories
        List<Product> listProducts = Database.getProductsDao().findAll();
        List<Category> listCategories = Database.getCategoriesDao().findAll();
        
        request.setAttribute("listProducts", listProducts);
        request.setAttribute("listCategories", listCategories);
        
        request.getRequestDispatcher("/views/admin/allproduct.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "All Products Admin Servlet";
    }
}
