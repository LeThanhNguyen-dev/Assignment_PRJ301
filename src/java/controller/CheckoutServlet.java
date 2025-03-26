package controller;

import dao.ProductDetailDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.CartItem;
import model.Customer;

/**
 * Servlet xử lý đơn hàng
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("session_Login");
        ProductDetailDAO ptd = new ProductDetailDAO();

        double amountTotal = 0;
        ArrayList<CartItem> selectedItems = session.getAttribute("selectedItems") != null ? (ArrayList<CartItem>) session.getAttribute("selectedItems") : new ArrayList<>();

        if (request.getParameter("isBuyNow") != null) {
            selectedItems.clear();
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = request.getParameter("quantity") != null ? Integer.parseInt(request.getParameter("quantity")) : 1;

            if (ptd.checkStockIsEnough(productId, quantity)) {
                selectedItems.add(new CartItem(cus.getId(), productId, quantity));
            } else {
                response.sendRedirect("product?error=Product is out of stock, please come back later&soldOutProductId=" + productId);
                return;
            }
        }

        if (selectedItems != null) {
            for (CartItem item : selectedItems) {
                amountTotal += item.getTotalPrice();
            }
        }
        session.setAttribute("selectedItems", selectedItems);

        session.setAttribute("totalBill", amountTotal);

        request.getRequestDispatcher("checkOut.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "CheckoutServlet xử lý quá trình đặt hàng";
    }
}
