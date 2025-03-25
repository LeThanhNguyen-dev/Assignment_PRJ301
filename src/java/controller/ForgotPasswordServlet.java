package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import utils.EmailUtil;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        CustomerDAO customerDAO = new CustomerDAO();
        if (!customerDAO.isEmailExist(email)) {
            request.setAttribute("error", "Email not found!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        // Tạo mã OTP
        String otp = EmailUtil.generateOTP();
        HttpSession session = request.getSession();
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetOTP", otp);
        session.setMaxInactiveInterval(300); // OTP hết hạn sau 5 phút

        try {
            String subject = "Reset Password";
            String message = EmailUtil.createMessageOTP(otp, "Reset Password");

            EmailUtil.sendEmail(email, subject, message);
            // Chuyển hướng đến trang reset password
            response.sendRedirect("resetPassword");
        } catch (Exception e) {
            System.err.println("Loi khi goi reset OTP ");
        }

    }

}
