/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dao.CartDAO;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class Customer {

    private int id;
    private String username, password, name, phone, email, address;
    private ArrayList<CartItem> cart;

    public Customer() {
    }

    public Customer(int id, String username, String password, String name, String phone, String email, String address) {
        CartDAO dao = new CartDAO();
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.cart = dao.getCartByCustomerId(id);
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public ArrayList<CartItem> getCart() {
        return cart;
    }

    public void setCart(ArrayList<CartItem> cart) {
        this.cart = cart;
    }

    public void resetCart() {
        CartDAO dao = new CartDAO();
        dao.deleteCartByCustomerId(id);
        this.cart.clear();
    }

    public void updateCart() {
        CartDAO dao = new CartDAO();
        this.cart = dao.getCartByCustomerId(id);
    }

    @Override
    public String toString() {
        return "Customer{" + "id=" + id + ", username=" + username + ", password=" + password + ", name=" + name + ", phone=" + phone + ", email=" + email + ", address=" + address + '}';
    }

}
