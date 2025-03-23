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

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String redirect = request.getParameter("redirect");
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            HttpSession session = request.getSession();
            Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }

            if (product != null) {
                cart.put(product, cart.getOrDefault(product, 0) + 1);
                session.setAttribute("cart", cart);

                // Tính số loại mặt hàng (số key trong Map)
                int cartItemCount = cart.keySet().size();
                session.setAttribute("cartItemCount", cartItemCount);

                if ("true".equals(redirect)) {
                    response.sendRedirect("cart.jsp");
                } else {
                    response.getWriter().write("{\"cartItemCount\": " + cartItemCount + "}");
                }
            } else {
                response.getWriter().write("{\"error\": \"Product not found\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}