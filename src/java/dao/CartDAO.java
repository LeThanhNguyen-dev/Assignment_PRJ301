package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.CartItem;
import utils.DBContext;

public class CartDAO extends DBContext {

    private Connection connection;

    public CartDAO() {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.c;
    }

    public ArrayList<CartItem> getCartByCustomerId(int customerId) {
        ArrayList<CartItem> cartItems = new ArrayList<>();

        String query = "SELECT * FROM CartItem WHERE customerId = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();

                    item.setCustomerId(rs.getInt("customerId"));
                    item.setProductId(rs.getInt("productId"));
                    item.setQuantity(rs.getInt("quantity"));

                    cartItems.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving cart items for customer ID " + customerId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return cartItems;
    }

    // Xóa tất cả bản ghi trong Cart theo customerId
    public boolean deleteCartByCustomerId(int customerId) {
        String query = "DELETE FROM CartItem WHERE customerId = ?";
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

    public boolean updateCartItemQuantity(int customerId, int productId, int newQuantity) {
        String query = "UPDATE CartItem SET quantity = ? WHERE customerId = ? AND productId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, customerId);
            ps.setInt(3, productId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Updated quantity for customer ID: " + customerId + ", product ID: " + productId + " to " + newQuantity);
                return true;
            } else {
                System.out.println("No cart item found for customer ID: " + customerId + " and product ID: " + productId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error updating cart item quantity: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCartItem(int customerId, int productId) {
        String query = "DELETE FROM CartItem WHERE customerId = ? AND productId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            System.err.println("Error deleting cart item: " + e.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        CartDAO dao = new CartDAO();
        dao.getCartByCustomerId(16).forEach(a -> System.out.println(a.toString()));
        dao.updateCartItemQuantity(16, 2, 4);
        dao.getCartByCustomerId(16).forEach(a -> System.out.println(a.toString()));

    }

}
