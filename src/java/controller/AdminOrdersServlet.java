package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.Order;
import model.OrderDetail;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderDetailDAO = new OrderDetailDAO();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            // Hiển thị danh sách đơn hàng
            List<Order> orders = new ArrayList<>();
            // Lấy tất cả khách hàng
            List<Customer> customers = customerDAO.listAll();
            // Lấy đơn hàng của từng khách hàng
            for (Customer customer : customers) {
                List<Order> customerOrders = orderDAO.getOrdersByCustomerId(customer.getId());
                orders.addAll(customerOrders);
            }
            // Lấy danh sách OrderDetail cho mỗi Order
            for (Order order : orders) {
                List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(order.getOrderId());
                order.setOrderDetails(orderDetails);
            }
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/adminOrders.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // Lấy thông tin đơn hàng để sửa
            int id = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(id);
            if (order != null) {
                // Lấy danh sách OrderDetail cho đơn hàng
                List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(order.getOrderId());
                order.setOrderDetails(orderDetails);
                request.setAttribute("order", order);
            }
            // Lấy lại danh sách tất cả đơn hàng
            List<Order> orders = new ArrayList<>();
            List<Customer> customers = customerDAO.listAll();
            for (Customer customer : customers) {
                List<Order> customerOrders = orderDAO.getOrdersByCustomerId(customer.getId());
                orders.addAll(customerOrders);
            }
            for (Order o : orders) {
                List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(o.getOrderId());
                o.setOrderDetails(orderDetails);
            }
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/adminOrders.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            // Xóa đơn hàng
            int id = Integer.parseInt(request.getParameter("id"));
            // Xóa tất cả OrderDetail liên quan trước
            List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(id);
            for (OrderDetail detail : orderDetails) {
                orderDetailDAO.deleteOrderDetail(detail.getOrderDetailId());
            }
            // Sau đó xóa Order
            orderDAO.deleteOrder(id);
            response.sendRedirect("orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            // Cập nhật trạng thái đơn hàng
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            orderDAO.updateOrderStatus(id, status);
            response.sendRedirect("orders");
        }
    }
}