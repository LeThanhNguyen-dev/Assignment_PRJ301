/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package controller.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author NhatNS
 */
@WebFilter(filterName = "CustomerFilter", urlPatterns = {"/*"})
public class CustomerFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter (có thể để trống nếu không cần)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        System.out.println(path);
        // Danh sách các URI không cần kiểm tra session
        boolean isExcludedPath = path.equals("/home")
                || path.equals("/")
                || path.equals("/login")
                || path.equals("/logout")
                || path.equals("/forgotPassword")
                || path.equals("/resetPassword")
                || path.startsWith("/admin")
                || path.startsWith("/img")
                || path.equals("/register")
                || path.equals("/search")
                || path.equals("/product");

        if (isExcludedPath) {
            // Nếu là trang không cần kiểm tra, cho phép request tiếp tục
            chain.doFilter(request, response);

        } else {
            // Kiểm tra session cho các trang còn lại
            if (session != null && (session.getAttribute("session_Login") != null || session.getAttribute("session_Admin") != null)) {
                chain.doFilter(request, response);
            } else {
                // Nếu không có session hoặc không có user, chuyển hướng về /login
                httpResponse.sendRedirect(contextPath + "/login");
            }
        }
    }

    @Override
    public void destroy() {
        // Dọn dẹp filter (có thể để trống nếu không cần)
    }
}
