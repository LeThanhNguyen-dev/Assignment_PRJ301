package dao;

import dto.ProductDetailDTO;
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
        String query = "SELECT p.productId, p.name, p.description, p.image, p.price, " +
                      "pd.stock, pd.brand, pd.material, pd.volume, pd.dimensions " +
                      "FROM Product p " +
                      "LEFT JOIN ProductDetail pd ON p.productId = pd.productId " +
                      "WHERE p.productId = ?";

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
    public static void main(String[] args) {
        ProductDetailDAO ptd = new ProductDetailDAO();
        
        System.out.println(ptd.getProductDetailsById(5).toString());
    }
            
}
