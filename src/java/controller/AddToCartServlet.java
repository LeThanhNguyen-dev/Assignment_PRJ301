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
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductByID(productId);

            HttpSession session = request.getSession();
            Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }

            if (product != null) {
                // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
                cart.put(product, cart.getOrDefault(product, 0) + 1);
                session.setAttribute("cart", cart);

                int cartSize = cart.values().stream().mapToInt(Integer::intValue).sum();
                session.setAttribute("cartSize", cartSize);

                response.getWriter().write("{\"cartSize\": " + cartSize + "}");
            } else {
                response.getWriter().write("{\"error\": \"Product not found\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}