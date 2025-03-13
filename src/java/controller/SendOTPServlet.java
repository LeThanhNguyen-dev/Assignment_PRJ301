/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import utils.EmailUtil;

/**
 *
 * @author NhatNS
 */
@WebServlet(name = "SendOTPServlet", urlPatterns = {"/sendOTP"})
public class SendOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String username = request.getParameter("username");

        System.out.println("thời gian vào doPost: " + java.time.LocalDateTime.now());

        if (email == null || email.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Email là bắt buộc.\"}");
            return;
        }

        // Tạo mã OTP ngẫu nhiên
        String otp = generateOTP();

        // Lưu OTP và email vào session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("otpEmail", email);

        // Gửi OTP qua email
        try {
            String subject = "Perfume Nhung Chu Be Dan";
            String message = String.format("Dear %s,\nYour OTP is: %s\nRegards,\nPerfume Nhung Chu Be Dan.",
                    username, otp);
            EmailUtil.sendEmail(email, subject, message);
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Mã OTP đã được gửi đến email của bạn.\"}");
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Gửi OTP thất bại. Vui lòng thử lại.\"}");
        } finally {
            System.out.println("thời gian het doPost: " + java.time.LocalDateTime.now());

        }

    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo mã OTP 6 chữ số
        return String.valueOf(otp);
    }
}
