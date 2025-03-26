package dao;

import dto.ProductDetailDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductDetail;
import utils.DBContext;

public class ProductDetailDAO extends DBContext {

    // Phương thức để lấy tất cả chi tiết sản phẩm dựa trên productId
    public ProductDetail getAllDetail(int productId) {
        ProductDetail productDetail = null;

        String sql = "SELECT * FROM ProductDetail WHERE productId = ?";

        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                productDetail = new ProductDetail();
                productDetail.setProductId(rs.getInt("productId"));
                productDetail.setStock(rs.getInt("stock"));
                productDetail.setBrand(rs.getString("brand"));
                productDetail.setMaterial(rs.getString("material"));
                productDetail.setVolume(rs.getDouble("volume"));
                productDetail.setDimensions(rs.getString("dimensions"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productDetail;
    }

    public ProductDetailDTO getProductDetailsById(int productId) {
        ProductDetailDTO productDetailDTO = null;
        String query = "SELECT p.productId, p.name, p.description, p.image, p.price, "
                + "pd.stock, pd.brand, pd.material, pd.volume, pd.dimensions "
                + "FROM Product p "
                + "LEFT JOIN ProductDetail pd ON p.productId = pd.productId "
                + "WHERE p.productId = ?";

        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                productDetailDTO = new ProductDetailDTO();
                productDetailDTO.setProductId(rs.getInt("productId"));
                productDetailDTO.setName(rs.getString("name"));
                productDetailDTO.setDescription(rs.getString("description"));
                productDetailDTO.setImage(rs.getString("image"));
                productDetailDTO.setPrice(rs.getDouble("price"));
                productDetailDTO.setStock(rs.getInt("stock"));
                productDetailDTO.setBrand(rs.getString("brand"));
                productDetailDTO.setMaterial(rs.getString("material"));
                productDetailDTO.setVolume(rs.getDouble("volume"));
                productDetailDTO.setDimensions(rs.getString("dimensions"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productDetailDTO;
    }

    // Phương thức để cập nhật stock khi mua hàng
    public void updateStock(int productId, int quantity) {
        String sql = "UPDATE ProductDetail SET stock = stock - ? WHERE productId = ? AND stock >= ?";

        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setInt(1, quantity);    // Số lượng cần trừ
            stmt.setInt(2, productId);   // ID của sản phẩm
            stmt.setInt(3, quantity);    // Kiểm tra stock có đủ không
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Không thể cập nhật stock: Stock không đủ hoặc sản phẩm không tồn tại.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật stock: " + e.getMessage());
        }
    }

    public List<Integer> getIdListSoldOut() {
        List<Integer> soldOutProductIds = new ArrayList<>();
        String sql = "SELECT productId FROM ProductDetail WHERE stock = 0";

        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                soldOutProductIds.add(rs.getInt("productId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return soldOutProductIds;
    }

    public List<Product> getListSoldOutProducts() {
        List<Product> soldOutProducts = new ArrayList<>();
        String sql = "SELECT p.productId, p.name, p.description, p.image, p.price, p.categoryId "
                + "FROM Product p "
                + "JOIN ProductDetail pd ON p.productId = pd.productId "
                + "WHERE pd.stock = 0";

        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("productId"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("categoryId"));
                soldOutProducts.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return soldOutProducts;
    }

    public boolean checkStockIsEnough(int productId, int quantity) {
        String sql = "SELECT stock FROM ProductDetail WHERE productId = ?";

        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int stock = rs.getInt("stock");
                return stock >= quantity;  // Chỉ trả về true nếu stock đủ
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;  // Trả về false nếu không tìm thấy sản phẩm
    }

    public static void main(String[] args) {
        ProductDetailDAO ptd = new ProductDetailDAO();

        System.out.println(ptd.getIdListSoldOut().toString());
    }

}
