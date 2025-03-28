package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Admin;
import dao.CustomerDAO;
import dao.AdminDAO;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberme");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password cannot be empty!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.login(username, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("session_Admin", admin);
            adminDAO.closeConnection(); 
            response.sendRedirect("adminDashboard"); 
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.checkLogin(username, password);
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("session_Login", customer);

            if ("on".equals(rememberMe)) {
                Cookie usernameCookie = new Cookie("CookieUserName", username);
                Cookie passwordCookie = new Cookie("CookiePassWord", password);

                usernameCookie.setMaxAge(60 * 60 * 24); // 1 ngày
                passwordCookie.setMaxAge(60 * 60 * 24); // 1 ngày

                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            } else {
                deleteCookie(request, response, "CookieUserName");
                deleteCookie(request, response, "CookiePassWord");
            }

            customerDAO.closeConnection(); 
            response.sendRedirect("home"); 
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void deleteCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Controller Servlet";
    }
}