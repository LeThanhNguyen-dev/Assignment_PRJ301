package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
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
                        rs.getInt("quantity")
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
                        rs.getInt("quantity")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
    
    
    
    public static void main(String[] args) {
        CustomerDAO cs = new CustomerDAO();

        List<Product> products = cs.listAllProducts();

        for (Product p : products) {
            System.out.println(p.toString());
        }

        System.out.println("==================");
        System.out.println("==================");
        System.out.println("==================");

        //==================================================
        var list = cs.listAll();
        for (Customer customer : list) {
            System.out.println(customer.toString());
        }
    }
}
