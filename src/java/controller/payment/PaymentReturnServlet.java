/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import utils.EmailUtil;

/**
 *
 * @author NhatNS
 */
@WebServlet(name = "PaymentReturn", urlPatterns = {"/PaymentReturn"})
public class PaymentReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");  // Lấy mã phản hồi từ VNPAY
        String vnp_TxnRef = req.getParameter("vnp_TxnRef");  // Mã đơn hàng
        OrderDAO orderDAO = new OrderDAO();
        HttpSession session = req.getSession();
        Customer cus = (Customer) session.getAttribute("session_Login");
        String status;
        if ("00".equals(vnp_ResponseCode)) { // "00" là mã thành công của VNPAY
            status = "Completed";
            orderDAO.updateOrderStatus(Integer.parseInt(vnp_TxnRef), "Completed");
        } else {
            status = "Failed";
            orderDAO.updateOrderStatus(Integer.parseInt(vnp_TxnRef), "Failed");
        }

        try {
            String subject = "Perfume Nhung Chu Be Dan";
            EmailUtil.sendEmail(cus.getEmail(), subject, EmailUtil.createOrderStatusMessage(status));
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"success\",\"message\":\"Mã OTP đã được gửi đến email của bạn.\"}");
            resp.sendRedirect("orderConfirmation.jsp?status=" + status );

        } catch (Exception e) {
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Gửi OTP thất bại. Vui lòng thử lại.\"}");
        }
    }
}
