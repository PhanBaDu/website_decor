package data.controllers.shopping_cart;

import data.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "decreaseQuantity", urlPatterns = {"/decrease-quantity"})
public class decreaseQuantity extends HttpServlet {

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
        
        if (cartIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/shopping-cart");
            return;
        }
        
        try {
            int cartId = Integer.parseInt(cartIdStr);
            
            // Giảm số lượng sản phẩm trong giỏ hàng
            boolean success = Database.getCartDao().decreaseQuantity(cartId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/shopping-cart?message=quantity_decreased");
            } else {
                response.sendRedirect(request.getContextPath() + "/shopping-cart?error=quantity_decrease_failed");
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
        return "Decrease quantity in cart";
    }
}
