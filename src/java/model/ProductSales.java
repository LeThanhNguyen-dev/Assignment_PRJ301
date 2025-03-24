package model;

public class ProductSales {
    private int productId;
    private String productName;
    private String categoryName;
    private int totalQuantity;

    public ProductSales(int productId, String productName, String categoryName, int totalQuantity) {
        this.productId = productId;
        this.productName = productName;
        this.categoryName = categoryName;
        this.totalQuantity = totalQuantity;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    @Override
    public String toString() {
        return "ProductSales{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", totalQuantity=" + totalQuantity +
                '}';
    }
}