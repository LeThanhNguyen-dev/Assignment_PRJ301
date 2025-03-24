package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductSales;
import utils.DBContext;

public class ProductDAO extends DBContext {

    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.* FROM Product p "
                + "JOIN Category c ON p.categoryId = c.categoryId "
                + "WHERE c.name = ? OR ? = ''";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, category);
            stmt.setString(2, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("productId"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getInt("categoryId")
                    );

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy sản phẩm theo category: " + e.getMessage());
        }
        return products;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product";
        try (PreparedStatement stmt = c.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getInt("categoryId")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy tất cả sản phẩm: " + e.getMessage());
        }
        return products;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT DISTINCT category FROM Product";
        try (PreparedStatement stmt = c.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách category: " + e.getMessage());
        }
        return categories;
    }

    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM Product";
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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

    public Product getProductById(int id) {
        String query = "SELECT * FROM Product WHERE productId = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("productId"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getInt("categoryId")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm theo ID: " + e.getMessage());
        }
        return null;
    }

    public List<Product> getProductsByQuery(String query) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE name LIKE ?";

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%"); // Tìm kiếm tên chứa từ khóa

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("productId"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getInt("categoryId")
                    );
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm sản phẩm theo tên: " + e.getMessage());
        }
        return products;
    }

    public void addProduct(Product product) {
        String query = "INSERT INTO Product (name, description, image, price, categoryId) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setString(3, product.getImage());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getCategoryId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm sản phẩm: " + e.getMessage());
        }
    }

    public void updateProduct(Product product) {
        String query = "UPDATE Product SET name = ?, description = ?, image = ?, price = ?, categoryId = ? WHERE productId = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setString(3, product.getImage());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getCategoryId());
            stmt.setInt(6, product.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
        }
    }

    public void deleteProduct(int id) {
        String query = "DELETE FROM Product WHERE productId = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa sản phẩm: " + e.getMessage());
        }
    }
    
    
    
    public List<ProductSales> getTop3ProductsPerCategory(int categoryId) {
        List<ProductSales> productSalesList = new ArrayList<>();
        String query = """
                WITH ProductSales AS (
                    SELECT 
                        p.productId,
                        p.name AS productName,
                        c.name AS categoryName,
                        p.categoryId,
                        SUM(od.quantity) AS totalQuantity,
                        ROW_NUMBER() OVER (PARTITION BY p.categoryId ORDER BY SUM(od.quantity) DESC, p.productId ASC) AS rank
                    FROM 
                        OrderDetail od
                        INNER JOIN Product p ON od.productId = p.productId
                        INNER JOIN Category c ON p.categoryId = c.categoryId
                    WHERE 
                        p.categoryId = ?  -- Thêm điều kiện lọc theo categoryId
                    GROUP BY 
                        p.productId,
                        p.name,
                        c.name,
                        p.categoryId
                )
                SELECT 
                    productId,
                    productName,
                    categoryName,
                    totalQuantity
                FROM 
                    ProductSales
                WHERE 
                    rank <= 3
                ORDER BY 
                    totalQuantity DESC;
                """;

        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setInt(1, categoryId); // Truyền tham số categoryId vào truy vấn
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductSales productSales = new ProductSales(
                            rs.getInt("productId"),
                            rs.getString("productName"),
                            rs.getString("categoryName"),
                            rs.getInt("totalQuantity")
                    );
                    productSalesList.add(productSales);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy top 3 sản phẩm bán chạy nhất: " + e.getMessage());
        }
        return productSalesList;
    }
    
    public List<ProductSales> getTop3BestSellingProducts() {
        List<ProductSales> productSalesList = new ArrayList<>();
        String query = """
                WITH ProductSales AS (
                    SELECT 
                        p.productId,
                        p.name AS productName,
                        c.name AS categoryName,
                        SUM(od.quantity) AS totalQuantity,
                        ROW_NUMBER() OVER (ORDER BY SUM(od.quantity) DESC, p.productId ASC) AS rank
                    FROM 
                        OrderDetail od
                        INNER JOIN Product p ON od.productId = p.productId
                        INNER JOIN Category c ON p.categoryId = c.categoryId
                    GROUP BY 
                        p.productId,
                        p.name,
                        c.name
                )
                SELECT 
                    productId,
                    productName,
                    categoryName,
                    totalQuantity
                FROM 
                    ProductSales
                WHERE 
                    rank <= 3
                ORDER BY 
                    totalQuantity DESC;
                """;

        try (PreparedStatement stmt = c.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ProductSales productSales = new ProductSales(
                        rs.getInt("productId"),
                        rs.getString("productName"),
                        rs.getString("categoryName"),
                        rs.getInt("totalQuantity")
                );
                productSalesList.add(productSales);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy top 3 sản phẩm bán chạy nhất tổng quát: " + e.getMessage());
        }
        return productSalesList;
    }

    // Test
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        System.out.println(dao.getProductById(1));
        
        dao.closeConnection();
    }
}
