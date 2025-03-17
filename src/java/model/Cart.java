package model;

import dao.ProductDAO;


public class Cart {
    private int customerId;
    private int productId;
    private int quantity;

    public Cart() {
    }

    public Cart(int customerId, int productId, int quantity) {
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
public double getTotalPrice(ProductDAO productDAO) {
    Product product = productDAO.getProductByID(this.productId);
    return product.getPrice() * this.quantity;
}

    @Override
    public String toString() {
        return "Cart{" +
                "customerId=" + customerId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                '}';
    }
}
    