package model;

import java.util.Date;

public class Voucher {
    private int id;
    private String code;
    private double discount;
    private Date expiryDate;

    public Voucher(int id, String code, double discount, Date expiryDate) {
        this.id = id;
        this.code = code;
        this.discount = discount;
        this.expiryDate = expiryDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
}