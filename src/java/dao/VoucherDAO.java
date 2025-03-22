package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;
import utils.DBContext;

public class VoucherDAO {
    private Connection conn;
    private DBContext dbContext;

    public VoucherDAO() {
        dbContext = new DBContext();
        conn = dbContext.c;
        if (conn == null) {
            throw new RuntimeException("Failed to initialize VoucherDAO: Database connection is null. Check DBContext configuration.");
        }
    }

    public List<Voucher> getAllVouchers() throws SQLException {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Voucher";  // Changed from 'vouchers' to 'Voucher'
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Voucher voucher = new Voucher(
                    rs.getInt("id"),
                    rs.getString("code"),
                    rs.getDouble("discount"),  // Changed from 'discountPercentage' to 'discount'
                    rs.getDate("expiry_date")  // Match column name
                );
                vouchers.add(voucher);
            }
        }
        return vouchers;
    }

    public Voucher getVoucherById(int id) throws SQLException {
        String sql = "SELECT * FROM Voucher WHERE id = ?";  // Changed from 'vouchers' to 'Voucher'
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Voucher(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getDouble("discount"),  // Changed from 'discountPercentage' to 'discount'
                        rs.getDate("expiry_date")  // Match column name
                    );
                }
            }
        }
        return null;
    }

    public void addVoucher(Voucher voucher) throws SQLException {
        String sql = "INSERT INTO Voucher (code, discount, expiry_date) VALUES (?, ?, ?)";  // Changed from 'vouchers' to 'Voucher'
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode());
            stmt.setDouble(2, voucher.getDiscount());
            stmt.setDate(3, new java.sql.Date(voucher.getExpiryDate().getTime()));
            stmt.executeUpdate();
        }
    }

    public void updateVoucher(Voucher voucher) throws SQLException {
        String sql = "UPDATE Voucher SET code = ?, discount = ?, expiry_date = ? WHERE id = ?";  // Changed from 'vouchers' to 'Voucher'
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode());
            stmt.setDouble(2, voucher.getDiscount());
            stmt.setDate(3, new java.sql.Date(voucher.getExpiryDate().getTime()));
            stmt.setInt(4, voucher.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteVoucher(int id) throws SQLException {
        String sql = "DELETE FROM Voucher WHERE id = ?";  // Changed from 'vouchers' to 'Voucher'
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public void closeConnection() {
        if (dbContext != null) {
            dbContext.closeConnection();
        }
    }
}