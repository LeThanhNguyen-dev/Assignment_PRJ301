package dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;

public class VoucherDAO {
    private Connection conn;

    public VoucherDAO() {
        // Khởi tạo kết nối cơ sở dữ liệu
        // conn = DBConnection.getConnection();
    }

    public List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM vouchers";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Voucher voucher = new Voucher(
                    rs.getInt("id"),
                    rs.getString("code"),
                    rs.getDouble("discount"),
                    rs.getDate("expiry_date")
                );
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }

    public Voucher getVoucherById(int id) {
        String sql = "SELECT * FROM vouchers WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Voucher(
                    rs.getInt("id"),
                    rs.getString("code"),
                    rs.getDouble("discount"),
                    rs.getDate("expiry_date")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addVoucher(Voucher voucher) {
        String sql = "INSERT INTO vouchers (code, discount, expiry_date) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode());
            stmt.setDouble(2, voucher.getDiscount());
            stmt.setDate(3, new java.sql.Date(voucher.getExpiryDate().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateVoucher(Voucher voucher) {
        String sql = "UPDATE vouchers SET code = ?, discount = ?, expiry_date = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode());
            stmt.setDouble(2, voucher.getDiscount());
            stmt.setDate(3, new java.sql.Date(voucher.getExpiryDate().getTime()));
            stmt.setInt(4, voucher.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteVoucher(int id) {
        String sql = "DELETE FROM vouchers WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}