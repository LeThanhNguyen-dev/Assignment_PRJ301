package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.CartDAO; // Thêm import này
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Customer;

@WebServlet("/adminCustomers")
public class AdminCustomersServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;
    private CartDAO cartDAO; // Thêm CartDAO

    @Override
    public void init() throws ServletException {
        try {
            customerDAO = new CustomerDAO();
            orderDAO = new OrderDAO();
            orderDetailDAO = new OrderDetailDAO();
            cartDAO = new CartDAO(); // Khởi tạo CartDAO
            if (customerDAO == null || orderDAO == null || orderDetailDAO == null || cartDAO == null) {
                throw new ServletException("Failed to initialize DAOs");
            }
        } catch (Exception e) {
            throw new ServletException("Error initializing DAOs: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra session admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("session_Admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

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
                System.out.println("Attempting to delete customer ID: " + id);

                // Xóa tất cả bản ghi trong Cart liên quan đến customerId
                boolean cartDeleted = cartDAO.deleteCartByCustomerId(id);
                System.out.println("Deleted cart for customer ID " + id + ": " + cartDeleted);
                if (!cartDeleted) {
                    throw new ServletException("Failed to delete cart for customer ID: " + id);
                }

                // Xóa tất cả đơn hàng liên quan
                List<model.Order> orders = orderDAO.getOrdersByCustomerId(id);
                System.out.println("Found " + orders.size() + " orders for customer ID: " + id);
                for (model.Order order : orders) {
                    // Xóa OrderDetail trước
                    boolean detailsDeleted = orderDetailDAO.deleteOrderDetailsByOrderId(order.getOrderId());
                    System.out.println("Deleted order details for order ID " + order.getOrderId() + ": " + detailsDeleted);
                    if (!detailsDeleted) {
                        throw new ServletException("Failed to delete order details for order ID: " + order.getOrderId());
                    }

                    // Xóa Order
                    boolean orderDeleted = orderDAO.deleteOrder(order.getOrderId());
                    System.out.println("Deleted order ID " + order.getOrderId() + ": " + orderDeleted);
                    if (!orderDeleted) {
                        throw new ServletException("Failed to delete order ID: " + order.getOrderId());
                    }
                }

                // Sau đó xóa khách hàng
                boolean deleted = customerDAO.deleteCustomer(id);
                System.out.println("Customer deletion result: " + deleted);
                if (!deleted) {
                    request.setAttribute("error", "Failed to delete customer with ID: " + id);
                    List<Customer> customers = customerDAO.listAll();
                    if (customers == null) {
                        request.setAttribute("error", "Failed to retrieve customer list after delete attempt");
                    } else {
                        request.setAttribute("customers", customers);
                    }
                    request.getRequestDispatcher("/adminCustomers.jsp").forward(request, response);
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/adminCustomers");
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