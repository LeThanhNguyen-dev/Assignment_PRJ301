package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DBContext;

public class ProductDAO extends DBContext {

    public Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT * FROM Product WHERE id = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("category") // Thêm category vào constructor
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> listAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Product";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("category") // Thêm category vào constructor
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Sửa lại main để kiểm tra ProductDAO thay vì CustomerDAO
    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO(); // Sửa từ CustomerDAO thành ProductDAO

        List<Product> products = productDAO.listAllProducts();

        for (Product p : products) {
            System.out.println(p.toString());
        }

        System.out.println("==================");
        System.out.println("==================");
        System.out.println("==================");

        // Nếu bạn muốn kiểm tra getProductById
        Product product = productDAO.getProductById(1); // Ví dụ lấy sản phẩm có id = 1
        if (product != null) {
            System.out.println("Product with ID 1: " + product.toString());
        } else {
            System.out.println("No product found with ID 1");
        }

        // Đóng kết nối sau khi sử dụng
        productDAO.closeConnection();
    }
}