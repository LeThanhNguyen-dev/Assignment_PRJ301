package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import model.Product;


@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/updateCart"})
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

        int productId = Integer.parseInt(request.getParameter("productId"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductByID(productId);

        if (cart != null && product != null) {
            if (newQuantity > 0) {
                cart.put(product, newQuantity); // Cập nhật số lượng
            } else {
                cart.remove(product); // Xóa nếu số lượng <= 0
            }
            session.setAttribute("cart", cart); // Cập nhật session
        }

        response.sendRedirect("cart.jsp"); // Load lại trang giỏ hàng
    }
}
