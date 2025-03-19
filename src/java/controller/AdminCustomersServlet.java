package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Customer;

@WebServlet("/admin/customers")
public class AdminCustomersServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        try {
            customerDAO = new CustomerDAO();
            if (customerDAO == null) {
                throw new ServletException("Failed to initialize CustomerDAO");
            }
        } catch (Exception e) {
            throw new ServletException("Error initializing CustomerDAO: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                // Hiển thị danh sách khách hàng
                List<Customer> customers = customerDAO.listAll();
                if (customers == null) {
                    throw new ServletException("Customer list is null");
                }
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/adminCustomers.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                // Xóa khách hàng
                int id = Integer.parseInt(request.getParameter("id"));
                customerDAO.deleteCustomer(id);
                // Sửa redirect thành URL tuyệt đối
                response.sendRedirect(request.getContextPath() + "/admin/customers");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid customer ID format");
            request.getRequestDispatcher("/adminCustomers.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}