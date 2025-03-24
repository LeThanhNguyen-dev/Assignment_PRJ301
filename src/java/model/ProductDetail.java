package model;

public class ProductDetail {

    // Các thuộc tính của bảng ProductDetail
    private int productId;
    private int stock;
    private String brand;
    private String material;
    private double volume;
    private String dimensions;

    // Constructor
    public ProductDetail() {
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) {
        this.volume = volume;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    @Override
    public String toString() {
        return "ProductDetail{" + "productId=" + productId + ", stock=" + stock + ", brand=" + brand + ", material=" + material + ", volume=" + volume + ", dimensions=" + dimensions + '}';
    }

}
