package data.controllers.shopping_cart;

import data.dao.Database;
import data.dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "increaseQuantity", urlPatterns = {"/increase-quantity"})
public class increaseQuantity extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Kiểm tra đăng nhập
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy tham số
        String cartIdStr = request.getParameter("cartId");
        String productIdStr = request.getParameter("productId");
        
        if (cartIdStr == null || productIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/shopping-cart");
            return;
        }
        
        try {
            int cartId = Integer.parseInt(cartIdStr);
            int productId = Integer.parseInt(productIdStr);
            
            // Lấy thông tin sản phẩm để kiểm tra số lượng tối đa
            ProductDao productDao = Database.getProductsDao();
            var product = productDao.findById(productId);
            
            if (product != null) {
                // Tăng số lượng sản phẩm trong giỏ hàng
                boolean success = Database.getCartDao().increaseQuantity(cartId, product.getQuantity());
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/shopping-cart?message=quantity_increased");
                } else {
                    response.sendRedirect(request.getContextPath() + "/shopping-cart?error=quantity_limit_reached");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/shopping-cart?error=product_not_found");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/shopping-cart");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/shopping-cart?error=system_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Increase quantity in cart";
    }
}
