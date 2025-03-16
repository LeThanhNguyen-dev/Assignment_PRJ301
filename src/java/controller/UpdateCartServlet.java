package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import model.Product;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/updateCart"})
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

        if (cart != null) {
            for (Product product : cart.keySet()) {
                String quantityParam = request.getParameter("quantity_" + product.getId());
                if (quantityParam != null) {
                    int newQuantity = Integer.parseInt(quantityParam);
                    if (newQuantity > 0) {
                        cart.put(product, newQuantity);
                    }
                }
            }
            session.setAttribute("cart", cart);
            int cartSize = cart.values().stream().mapToInt(Integer::intValue).sum();
            session.setAttribute("cartSize", cartSize);
        }

        response.sendRedirect("cart.jsp");
    }
}