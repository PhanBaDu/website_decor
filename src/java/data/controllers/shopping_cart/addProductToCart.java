package data.controllers.shopping_cart;

import data.dao.Database;
import data.models.Cart;
import data.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "addProductToCart", urlPatterns = {"/add-to-cart"})
public class addProductToCart extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet addProductToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addProductToCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
    
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String productIdStr = request.getParameter("id");
        String priceStr = request.getParameter("price");

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
            return;
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            response.getWriter().write("{\"success\": false, \"message\": \"Giá sản phẩm không hợp lệ\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            double price = Double.parseDouble(priceStr);

            if (action == null || action.trim().isEmpty()) {
                action = "newProductToCart";
            }

            switch (action) {
                case "newProductToCart":
                    boolean success = Database.getCartDao().addNewProductToCart(new Cart(user.getId(), productId, 1, price));
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/shopping-cart");
                    } else {
                        response.getWriter().write("{\"success\": false, \"message\": \"Không thể thêm sản phẩm vào giỏ hàng\"}");
                    }
                    break;
                default:
                    response.getWriter().write("{\"success\": false, \"message\": \"Action không hợp lệ: " + action + "\"}");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Dữ liệu đầu vào không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi hệ thống. Vui lòng thử lại sau\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
