package data.controllers.auth;

import data.dao.Database;
import data.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "registerServlet", urlPatterns = {"/register"})
public class registerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet registerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet registerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/newproduct");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.getRequestDispatcher("/views/register.jsp").include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        
        String errorMessage = null;

        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        String phoneRegex = "^(0\\d{9}|\\+84\\d{9})$";

        if (name == null || name.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập họ và tên.";
        } else if (email == null || email.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập email.";
        } else if (!email.matches(emailRegex)) {
            errorMessage = "Email không hợp lệ.";
        } else if (phone == null || phone.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập số điện thoại.";
        } else if (!phone.matches(phoneRegex)) {
            errorMessage = "Số điện thoại không hợp lệ.";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập mật khẩu.";
        } else if (password.length() < 6) {
            errorMessage = "Mật khẩu phải có ít nhất 6 ký tự.";
        }
        
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/views/register.jsp").include(request, response);
            return;
        }
        
        
        try {
            User user = Database.getUserDao().insertUser(name, email, phone, password);
            System.err.println(user);
            if (user == null) {
                request.setAttribute("error", "Thông tin đăng ký không chính xác.");
                request.getRequestDispatcher("/views/register.jsp").include(request, response);
                return;
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/newproduct");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("/views/register.jsp").include(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
