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

@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/removeFromCart"})
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

        if (cart != null) {
            cart.entrySet().removeIf(entry -> entry.getKey().getId() == productId);
            session.setAttribute("cart", cart);
            int cartSize = cart.values().stream().mapToInt(Integer::intValue).sum();
            session.setAttribute("cartSize", cartSize);
        }

        response.sendRedirect("cart.jsp");
    }
}