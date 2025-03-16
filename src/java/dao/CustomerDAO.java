package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import utils.DBContext;

public class CustomerDAO extends DBContext {



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

    // Thêm phương thức kiểm tra email tồn tại
    public boolean isEmailExist(String email) {
        String query = "SELECT COUNT(*) FROM Customer WHERE email = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm phương thức cập nhật mật khẩu
    public boolean updatePassword(String email, String newPassword) {
        String query = "UPDATE Customer SET password = ? WHERE email = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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

    
}
