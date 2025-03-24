package dao;

import model.OrderDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;

public class OrderDetailDAO {

    private Connection connection;

    public OrderDetailDAO() {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.c;
    }

    public boolean addOrderDetail(OrderDetail orderDetail) {
        String query = "INSERT INTO OrderDetail (orderId, productId, quantity, unitPrice, subtotal) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderDetail.getOrderId());
            ps.setInt(2, orderDetail.getProductId());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getUnitPrice());
            ps.setDouble(5, orderDetail.getSubtotal());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public OrderDetail getOrderDetailById(int orderDetailId) {
        String query = "SELECT * FROM OrderDetail WHERE orderDetailId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToOrderDetail(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT * FROM OrderDetail WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderDetails.add(mapResultSetToOrderDetail(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public boolean updateOrderDetail(OrderDetail orderDetail) {
        String query = "UPDATE OrderDetail SET orderId = ?, productId = ?, quantity = ?, unitPrice = ?, subtotal = ? "
                + "WHERE orderDetailId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderDetail.getOrderId());
            ps.setInt(2, orderDetail.getProductId());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getUnitPrice());
            ps.setDouble(5, orderDetail.getSubtotal());
            ps.setInt(6, orderDetail.getOrderDetailId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteOrderDetailsByOrderId(int orderId) {
        String query = "DELETE FROM OrderDetail WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " order details for order ID: " + orderId);
            return rowsAffected >= 0; // Trả về true nếu không có lỗi
        } catch (SQLException e) {
            System.err.println("Error deleting order details for order ID " + orderId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteOrderDetail(int orderDetailId) {
        String query = "DELETE FROM OrderDetail WHERE orderDetailId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderDetailId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to map a ResultSet row to an OrderDetail object
    private OrderDetail mapResultSetToOrderDetail(ResultSet rs) throws SQLException {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setOrderDetailId(rs.getInt("orderDetailId"));
        orderDetail.setOrderId(rs.getInt("orderId"));
        orderDetail.setProductId(rs.getInt("productId"));
        orderDetail.setQuantity(rs.getInt("quantity"));
        orderDetail.setUnitPrice(rs.getDouble("unitPrice"));
        orderDetail.setSubtotal(rs.getDouble("subtotal"));
        return orderDetail;
    }

    public static void main(String[] args) {
        OrderDetailDAO dao = new OrderDetailDAO();
        dao.addOrderDetail(new OrderDetail(3, 2, 15, 120));
    }
}
