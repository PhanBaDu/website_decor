package data.controllers.search;

import data.dao.Database;
import data.dao.ProductDao;
import data.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "searchServlet", urlPatterns = {"/search"})
public class searchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        // Lấy từ khóa tìm kiếm
        String searchQuery = request.getParameter("q");
        
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            searchQuery = "";
        }
        
        // Tạo biến final để sử dụng trong lambda
        final String finalSearchQuery = searchQuery;
        
        try {
            // Lấy tất cả sản phẩm
            ProductDao productDao = Database.getProductsDao();
            List<Product> allProducts = productDao.findAll();
            
            // Lọc sản phẩm theo từ khóa tìm kiếm
            List<Product> searchResults = allProducts.stream()
                .filter(product -> 
                    product.getName().toLowerCase().contains(finalSearchQuery.toLowerCase())
                )
                .collect(Collectors.toList());
            
            // Đặt kết quả vào request
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("totalResults", searchResults.size());
            
            // Forward đến trang search.jsp
            request.getRequestDispatcher("/views/search.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home?error=search_failed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Search products";
    }
}
