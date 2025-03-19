package dao;

import java.sql.*;
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
                productDetail.setWeight(rs.getDouble("weight"));
                productDetail.setDimensions(rs.getString("dimensions"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productDetail;
    }
}
