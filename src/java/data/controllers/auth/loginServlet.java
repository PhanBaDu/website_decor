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


@WebServlet(name = "loginServlet", urlPatterns = {"/login"})
public class loginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginServlet at " + request.getContextPath() + "</h1>");
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
            request.getRequestDispatcher("./views/login.jsp").include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String emailPhone = request.getParameter("emailPhone");
        String password = request.getParameter("password");
        
        String errorMessage = null;

        if (emailPhone == null || emailPhone.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập email hoặc số điện thoại.";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập mật khẩu.";
        }
        
        else {
            String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
            String phoneRegex = "^(0\\d{9}|\\+84\\d{9})$";

            if (!emailPhone.matches(emailRegex) && !emailPhone.matches(phoneRegex)) {
                errorMessage = "Email hoặc số điện thoại không hợp lệ.";
            } else if (password.length() < 6) {
                errorMessage = "Mật khẩu phải có ít nhất 6 ký tự.";
            }
        }
        
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/views/login.jsp").include(request, response);
            return;
        }
        
        User user = Database.getUserDao().find(emailPhone, password);
        
        if (user == null) {
            request.setAttribute("error", "Thông tin đăng nhập không chính xác.");
            request.getRequestDispatcher("/views/login.jsp").include(request, response);
            return;
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/newproduct");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
