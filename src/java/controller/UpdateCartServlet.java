package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.CartDAO;
import dao.ProductDAO;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
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
        Customer cus = (Customer) session.getAttribute("session_Login");
        String action = request.getParameter("action");

        // Lấy danh sách productIds, quantities và selectedProducts từ form
        String[] productIds = request.getParameterValues("productIds");
        String[] quantities = request.getParameterValues("quantities");
        String[] selectedProducts = request.getParameterValues("selectedProducts");

        // Cập nhật số lượng cho tất cả sản phẩm
        if (productIds != null && quantities != null && productIds.length == quantities.length) {
            for (int i = 0; i < productIds.length; i++) {
                int productId = Integer.parseInt(productIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                cartDAO.updateCartItemQuantity(cus.getId(), productId, quantity);
            }
        }

        cus.updateCart(); // Cập nhật giỏ hàng trong session

        if ("checkout".equals(action)) {
            if (selectedProducts != null) {
                // Lọc ra các CartItem được chọn
                List<CartItem> selectedItems = new ArrayList<>();
                for (String selectedId : selectedProducts) {
                    for (CartItem item : cus.getCart()) {
                        if (item.getProductId() == Integer.parseInt(selectedId)) {
                            selectedItems.add(item);
                            break;
                        }
                    }
                }
                // Lưu danh sách selectedItems vào session
                session.setAttribute("selectedItems", selectedItems);
            }
            response.sendRedirect("checkOut.jsp");
        } else if ("continue".equals(action)) {
            response.sendRedirect("product");
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
