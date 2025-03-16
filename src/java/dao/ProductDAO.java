package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DBContext;

public class ProductDAO extends DBContext {

    // Lấy sản phẩm theo danh mục
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE category = ? OR ? = ''";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, category);
            stmt.setString(2, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("category")
                    );
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy sản phẩm theo category: " + e.getMessage());
        }
        return products;
    }

    // Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product";
        try (PreparedStatement stmt = c.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getString("category")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy tất cả sản phẩm: " + e.getMessage());
        }
        return products;
    }

    // Lấy danh sách category duy nhất
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT DISTINCT category FROM Product";
        try (PreparedStatement stmt = c.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách category: " + e.getMessage());
        }
        return categories;
    }

    // Đóng kết nối
    public void closeConnection() {
        if (c != null) {
            try {
                c.close();
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }

    // Test
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getProductsByCategory("Nữ");
        for (Product p : products) {
            System.out.println(p);
        }
        dao.closeConnection();
    }
}