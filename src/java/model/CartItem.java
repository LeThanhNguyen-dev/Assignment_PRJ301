package model;

import dao.ProductDAO;

public class CartItem {

    private int customerId;
    private int productId;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int customerId, int productId, int quantity) {
        this.customerId = customerId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity > 0) {
            this.quantity = quantity;
        } else {
            throw new IllegalArgumentException("Quantity must be greater than 0");
        }
    }

    public double getTotalPrice() {
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(this.productId);
        return product.getPrice() * this.quantity;
    }

    public Product getProduct() {
        ProductDAO dao = new ProductDAO();
        return dao.getProductById(productId);
    }

    @Override
    public String toString() {
        return "CartItem{"
                + "customerId=" + customerId
                + ", productId=" + productId
                + ", quantity=" + quantity
                + '}';
    }
}
