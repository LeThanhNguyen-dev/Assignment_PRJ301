package dao;

import com.sun.jdi.connect.spi.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.Product;
import utils.DBContext;

public class CustomerDAO extends DBContext {

    public  Product getProductById(int productId) {
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

    public Customer checkLogin(String username, String password) {
        Customer customer = null;
        String query = "SELECT * FROM Customer WHERE username = ? AND password = ?";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            System.out.println("Executing query: " + query);
            System.out.println("Parameters: " + username + ", " + password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                customer = new Customer(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("address")
                );
                System.out.println("Login successful for user: " + username);
            } else {
                System.out.println("No user found with provided credentials.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }

    public boolean addCustomer(Customer customer) {
        String query = "INSERT INTO Customer (username, password, name, phone, email, address) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getPassword());
            stmt.setString(3, customer.getName());
            stmt.setString(4, customer.getPhone());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getAddress());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteCustomer(int id) {
        String query = "DELETE FROM Customer WHERE id = ?";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, id);

            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Customer> listAll() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customer";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("address")
                );
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }

    public boolean isUsernameOrEmailExist(String username, String email) {
        String query = "SELECT COUNT(*) FROM Customer WHERE username = ? OR email = ?";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
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
