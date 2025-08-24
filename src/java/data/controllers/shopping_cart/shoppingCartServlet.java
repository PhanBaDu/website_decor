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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "shoppingCartServlet", urlPatterns = {"/shopping-cart"})
public class shoppingCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet shoppingCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet shoppingCartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Cart> cartItems = Database.getCartDao().getCartsByUserId(user.getId());

            double totalAmount = 0;
            for (Cart cart : cartItems) {
                totalAmount += cart.getSubtotal();
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("cartCount", cartItems.size());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải giỏ hàng. Vui lòng thử lại sau.");
            request.setAttribute("cartItems", new ArrayList<Cart>());
            request.setAttribute("totalAmount", 0.0);
            request.setAttribute("cartCount", 0);
        }

        request.getRequestDispatcher("./views/shoppingCart.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
