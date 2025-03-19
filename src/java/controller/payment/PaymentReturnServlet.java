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
        System.out.println("doget");

        if ("00".equals(vnp_ResponseCode)) { // "00" là mã thành công của VNPAY
            orderDAO.updateOrderStatus(Integer.parseInt(vnp_TxnRef), "Completed");
            resp.sendRedirect("orderConfirmation.jsp?status");
        } else {
            orderDAO.updateOrderStatus(Integer.parseInt(vnp_TxnRef), "Failed");
            resp.sendRedirect("orderConfirmation.jsp?status=fail");
        }
    }
}
