package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Order;
import model.OrderDetail;
import dao.OrderDAO;
import dao.OrderDetailDAO;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("do gett profife Sẻvlet ");
        
        HttpSession session = request.getSession();
        Customer currentCustomer = (Customer) session.getAttribute("session_Login");
        
        System.out.println("Fetching orders for customer ID: " + currentCustomer.getId());
        
        retrieveUserOrdersAndDetails(currentCustomer.getId(), request);
        
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders == null || orders.isEmpty()) {
            System.out.println("No orders found for customer ID: " + currentCustomer.getId());
        } else {
            System.out.println("Found " + orders.size() + " orders for customer ID: " + currentCustomer.getId());
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    private void retrieveUserOrdersAndDetails(int customerId, HttpServletRequest request) {
        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        
        List<Order> orders = orderDAO.getOrdersByCustomerId(customerId);
        if (orders == null) {
            System.out.println("OrderDAO returned null for customer ID: " + customerId);
        } else {
            System.out.println("OrderDAO returned " + orders.size() + " orders");
        }
        
        request.setAttribute("orders", orders);
        
        if (orders != null) {
            for (Order order : orders) {
                List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(order.getOrderId());
                if (orderDetails == null) {
                    System.out.println("No details found for order ID: " + order.getOrderId());
                } else {
                    System.out.println("Found " + orderDetails.size() + " details for order ID: " + order.getOrderId());
                }
                order.setOrderDetails(orderDetails);
            }
        }
    }
    
    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO();
        
        List<Order> orders = orderDAO.getOrdersByCustomerId(1);
        for (Order order : orders) {
            System.out.println(order.toString());
        }
    }
}
