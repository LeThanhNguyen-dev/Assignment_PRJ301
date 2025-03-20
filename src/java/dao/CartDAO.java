package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import utils.DBContext;

public class CartDAO extends DBContext {

    // Xóa tất cả bản ghi trong Cart theo customerId
    public boolean deleteCartByCustomerId(int customerId) {
        String query = "DELETE FROM Cart WHERE customerId = ?";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, customerId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " cart entries for customer ID: " + customerId);
            return rowsAffected >= 0; // Trả về true nếu không có lỗi
        } catch (SQLException e) {
            System.err.println("Error deleting cart for customer ID " + customerId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}