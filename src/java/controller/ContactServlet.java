package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.*;
import java.util.Properties;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/sendEmail")
public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        String host = "smtp.gmail.com";
        String from = "hoanganh19010809@gmail.com"; 
        String password = "efyc eyev lmfe xnmu"; 

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("lethanhdat20072005@gmail.com")); 
            msg.setSubject("Contact Form Message from " + name);
            msg.setText("Message from: " + name + "\nEmail: " + email + "\n\n" + message);

            Transport.send(msg);

            request.setAttribute("messageStatus", "Email sent successfully!");
        } catch (MessagingException e) {
            request.setAttribute("messageStatus", "Error sending email: " + e.getMessage());
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("contact.jsp");
        dispatcher.forward(request, response);
    }
}
    