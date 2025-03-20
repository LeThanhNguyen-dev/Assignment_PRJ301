package dao;

import model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;

public class OrderDAO {

    private Connection connection;

    public OrderDAO() {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.c;
    }

    public int addOrder(Order order) {
        String query = "INSERT INTO [Order] (customerId, totalAmount, status, shippingAddress, voucherCode) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getCustomerId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getVoucherCode());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về orderId
                    }
                }
            }
            return -1; // Trả về -1 nếu không có khóa được sinh ra
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE [Order] SET status = ? WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi
        }
    }

    // Method to retrieve an Order by orderId
    public Order getOrderById(int orderId) {
        String query = "SELECT * FROM [Order] WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to retrieve all Orders by customerId
    public List<Order> getOrdersByCustomerId(int customerId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM [Order] WHERE customerId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Method to update an existing Order
    public boolean updateOrder(Order order) {
        String query = "UPDATE [Order] SET customerId = ?, totalAmount = ?, status = ?, shippingAddress = ?, voucherCode = ? "
                + "WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, order.getCustomerId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getVoucherCode());
            ps.setInt(6, order.getOrderId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete an Order
    public boolean deleteOrder(int orderId) {
        String query = "DELETE FROM [Order] WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getTotalOrders() {
        String query = "SELECT COUNT(*) AS totalOrders FROM [Order]";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalOrders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu có lỗi hoặc không có đơn hàng
    }

    // Phương thức mới: Tính tổng tiền từ tất cả đơn hàng
    public double getTotalRevenue() {
        String query = "SELECT SUM(totalAmount) AS totalRevenue FROM [Order]";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0; // Trả về 0 nếu có lỗi hoặc không có doanh thu
    }

    // Helper method to map a ResultSet row to an Order object
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("orderId"));
        order.setCustomerId(rs.getInt("customerId"));
        order.setOrderDate(rs.getDate("orderDate"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shippingAddress"));
        order.setVoucherCode(rs.getString("voucherCode"));
        return order;
    }

}
