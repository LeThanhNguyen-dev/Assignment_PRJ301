package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.CustomerDAO;

import dao.ProductDAO;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/adminDashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("session_Admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Khởi tạo DAO
        CustomerDAO customerDAO = new CustomerDAO();
        ProductDAO productDAO = new ProductDAO();

        // Lấy dữ liệu
        int totalCustomers = customerDAO.getTotalCustomers();
        int totalProducts = productDAO.getTotalProducts();

        // Debugging - In ra giá trị
        System.out.println("Total Customers: " + totalCustomers);
        System.out.println("Total Products: " + totalProducts);

        // Đặt dữ liệu vào request
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalProducts", totalProducts);

        // Đóng kết nối
        customerDAO.closeConnection();
        productDAO.closeConnection();

        // Forward đến JSP
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin Dashboard Servlet";
    }
    public static void main(String[] args) {
       CustomerDAO customerDAO = new CustomerDAO();
        ProductDAO productDAO = new ProductDAO();

        // Lấy dữ liệu
        int totalCustomers = customerDAO.getTotalCustomers();
        int totalProducts = productDAO.getTotalProducts();

        // Debugging - In ra giá trị
        System.out.println("Total Customers: " + totalCustomers);
        System.out.println("Total Products: " + totalProducts); 
    }
}

