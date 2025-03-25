package controller;

import dao.CartDAO;
import dao.ProductDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import model.CartItem;
import model.Customer;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

    private CartDAO cartDAO;
    private ProductDetailDAO productDetailDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO(); // Khởi tạo CartDAO khi servlet được khởi động
        productDetailDAO = new ProductDetailDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        Customer cus = (Customer) session.getAttribute("session_Login");

        if (productDetailDAO.getProductDetailsById(productId).getStock() < quantity) {
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\": \"fail\", \"message\": \"Please check stock before adding to cart\", \"cartSize\": " + cus.getCart().size() + "}");
            return;
        }

        ArrayList<CartItem> cartItems = cus.getCart();
        boolean productExists = false;

        for (CartItem item : cartItems) {
            if (item.getProductId() == productId) {
                int newQuantity = item.getQuantity() + quantity;
                cartDAO.updateCartItemQuantity(cus.getId(), productId, newQuantity);
                productExists = true;
                break;
            }
        }

        if (!productExists) {
            CartItem newItem = new CartItem();
            newItem.setCustomerId(cus.getId());
            newItem.setProductId(productId);
            newItem.setQuantity(quantity);
            cartDAO.insertCartItem(newItem);
        }

        cus.updateCart();

// Trả về JSON
        resp.setContentType("application/json");
        resp.getWriter().write("{\"status\": \"success\", \"message\": \"Add to cart successfully\", \"cartSize\": " + cus.getCart().size() + "}");
    }

}
