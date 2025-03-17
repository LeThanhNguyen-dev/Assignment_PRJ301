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
            try {
                for (Product product : cart.keySet()) {
                    String quantityParam = request.getParameter("quantity_" + product.getId());
                    
                    if (quantityParam != null) {
                        try {
                            int newQuantity = Integer.parseInt(quantityParam);
                            if (newQuantity > 0) {
                                cart.put(product, newQuantity);
                            } else {
                                cart.remove(product); // Xóa nếu số lượng = 0
                            }
                        } catch (NumberFormatException e) {
                            System.err.println("Lỗi: Số lượng không hợp lệ cho sản phẩm " + product.getId());
                        }
                    }
                }

                session.setAttribute("cart", cart);

                // Cập nhật tổng số lượng sản phẩm trong giỏ hàng
                int cartSize = cart.values().stream().mapToInt(Integer::intValue).sum();
                session.setAttribute("cartSize", cartSize);

                response.sendRedirect("cart.jsp"); // Reload lại trang giỏ hàng

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp"); // Chuyển hướng đến trang lỗi nếu có sự cố
            }
        } else {
            response.sendRedirect("cart.jsp"); // Nếu giỏ hàng trống, vẫn reload lại trang
        }
    }
}