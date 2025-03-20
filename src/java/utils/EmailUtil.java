/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author NhatNS
 */
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {

    private static final String HOST = "smtp.gmail.com";
    private static final String FROM = "hoanganh19010809@gmail.com"; // Thay bằng email của bạn
    private static final String PASSWORD = "efyc eyev lmfe xnmu"; // Thay bằng app password của bạn

    public static void sendEmail(String to, String subject, String messageText) throws MessagingException {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", HOST);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setContent(messageText, "text/html; charset=utf-8");
        Transport.send(message);
    }

    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo mã OTP 6 chữ số
        return String.valueOf(otp);
    }

    public static String createMessageOTP(String otp, String title) {
        return "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }"
                + ".container { background-color: white; padding: 20px; text-align: center; border-radius: 10px; }"
                + ".logo { font-size: 24px; font-weight: bold; color: #cd2653; }"
                + ".otp { font-size: 36px; font-weight: bold; margin: 20px 0; letter-spacing: 5px; }"
                + ".warning { font-size: 14px; color: #666; }"
                + ".footer { margin-top: 20px; font-size: 12px; color: #999; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<div class='logo'>Perfume Nhung Chu Be Dan</div>"
                + "<h2>" + title + "</h2>"
                + "<p>Here is your OTP:</p>"
                + "<div class='otp'>" + otp + "</div>"
                + "<p class='warning'>If this request did not come from you, change your account password immediately to prevent further unauthorized access.</p>"
                + "</div>"
                + "<div class='footer'>Perfume Nhung Chu Be</div>"
                + "</body>"
                + "</html>";
    }

    public static String createOrderStatusMessage(String status) {
        // Xác định nội dung dựa trên trạng thái đơn hàng
        String message;
        if ("completed".equalsIgnoreCase(status)) {
            message = "<p>Thank you for your order! Your order has been processed successfully.</p>";
        } else {
            message = "<p>Thank you for your order! However, your order has not been completed yet. Please contact us for more details.</p>";
        }

        // Trả về email dưới dạng HTML
        return "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }"
                + ".container { background-color: white; padding: 20px; text-align: center; border-radius: 10px; }"
                + ".logo { font-size: 24px; font-weight: bold; color: #cd2653; }"
                + ".message { font-size: 18px; margin: 20px 0; }"
                + ".footer { margin-top: 20px; font-size: 12px; color: #999; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<div class='logo'>Perfume Nhung Chu Be Dan</div>"
                + "<h2>Order Confirmation</h2>"
                + "<div class='message'>" + message + "</div>"
                + "</div>"
                + "<div class='footer'>Perfume Nhung Chu Be</div>"
                + "</body>"
                + "</html>";
    }
}
