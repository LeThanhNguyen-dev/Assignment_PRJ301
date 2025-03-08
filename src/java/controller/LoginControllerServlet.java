/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="LoginControllerServlet", urlPatterns={"/login"})
public class LoginControllerServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginControllerServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginControllerServlet at " + request.getContextPath () + "</h1>");
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
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String rememberMe = request.getParameter("rememberMe");

    // Kiểm tra thông tin đăng nhập
    if (username != null && password != null && username.equals(USERNAME_SYSTEM) && BCrypt.checkpw(password, PASSWORD_HASHED)) {
        HttpSession session = request.getSession();
        session.setAttribute("session_Login", username);

        if (rememberMe != null) {
            Cookie usernameCookie = new Cookie("CookieUserName", username);
            usernameCookie.setMaxAge(60 * 60 * 24);
            usernameCookie.setHttpOnly(true);
            usernameCookie.setSecure(true);
            response.addCookie(usernameCookie);
        } else {
            // Xóa cookie nếu người dùng bỏ chọn "Remember Me"
            Cookie deleteUsernameCookie = new Cookie("CookieUserName", "");
            deleteUsernameCookie.setMaxAge(0);
            deleteUsernameCookie.setPath("/");
            response.addCookie(deleteUsernameCookie);
        }

        response.sendRedirect("welcome.jsp");
    } else {
        request.setAttribute("error", "Invalid username or password!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
