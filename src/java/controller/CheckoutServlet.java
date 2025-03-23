package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý đơn hàng
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang thanh toán
        response.sendRedirect("checkout.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        double totalBill = Double.parseDouble(request.getParameter("totalBill"));

        // Giả lập xử lý đơn hàng (có thể thay bằng xử lý thực tế)
        boolean orderSuccess = processOrder(fullName, email, phone, address, paymentMethod, totalBill);

        // Thiết lập session để giữ kích thước giỏ hàng
        HttpSession session = request.getSession();
        if (orderSuccess) {
            // Đơn hàng thành công, xóa giỏ hàng
            session.removeAttribute("cart");
            session.setAttribute("cartSize", 0);

            // Chuyển hướng đến trang xác nhận thành công
            request.setAttribute("status", "success");
            request.setAttribute("message", "Đặt hàng thành công!");
            request.setAttribute("totalBill", totalBill);
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
        } else {
            // Đơn hàng thất bại
            request.setAttribute("status", "fail");
            request.setAttribute("message", "Đặt hàng thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
        }
    }

    // Giả lập xử lý đơn hàng (có thể thay bằng xử lý thực tế)
    private boolean processOrder(String fullName, String email, String phone, String address, String paymentMethod, double totalBill) {
        // Giả lập xử lý đơn hàng thành công với xác suất 80%
        return Math.random() > 0.2;
    }

    @Override
    public String getServletInfo() {
        return "CheckoutServlet xử lý quá trình đặt hàng";
    }
}
