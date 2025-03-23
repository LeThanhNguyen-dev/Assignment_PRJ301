package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.CartDAO;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import model.Customer;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO(); // Khởi tạo CartDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer cus = (Customer)session.getAttribute("session_Login");
        String action = request.getParameter("action");

        // Cập nhật số lượng cho tất cả sản phẩm
        for (int i = 0; request.getParameter("productId_" + i) != null; i++) {
            int productId = Integer.parseInt(request.getParameter("productId_" + i));
            int quantity = Integer.parseInt(request.getParameter("quantity_" + i));
            cartDAO.updateCartItemQuantity(cus.getId(), productId, quantity);
        }

        // Chuyển hướng dựa trên action
        if ("continue".equals(action)) {
            response.sendRedirect("product");
        } else if ("checkout".equals(action)) {
            response.sendRedirect("checkOut.jsp");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số từ yêu cầu DELETE
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Xóa sản phẩm khỏi giỏ hàng trong cơ sở dữ liệu
        boolean success = cartDAO.deleteCartItem(customerId, productId);
        if (success) {
            response.getWriter().write("{\"status\": \"success\", \"message\": \"Xóa thành công!\"}");
        } else {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Xóa thất bại!\"}");
        }
    }
}
