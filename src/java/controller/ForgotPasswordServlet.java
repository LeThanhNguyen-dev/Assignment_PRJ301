package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

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
        String otp = generateOTP();
        HttpSession session = request.getSession();
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetOTP", otp);
        session.setMaxInactiveInterval(300); // OTP hết hạn sau 5 phút

        // Gửi email
        sendEmail(email, "Password Reset OTP", "Your OTP to reset password is: " + otp);

        // Chuyển hướng đến trang reset password
        response.sendRedirect("resetPassword.jsp");
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Mã 6 chữ số
        return String.valueOf(otp);
    }

    private void sendEmail(String to, String subject, String body) {
        final String from = "your_email@gmail.com"; // Thay bằng email của bạn
        final String password = "your_app_password"; // Thay bằng App Password của Gmail

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            System.out.println("Email sent successfully to " + to);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}