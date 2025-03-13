package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import jakarta.servlet.annotation.WebServlet;
import utils.EmailUtil;

@WebServlet("/sendEmail")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        try {
            String subject = "Contact Form Message from " + name;
            String body = "Message from: " + name + "\nEmail: " + email + "\n\n" + message;
            EmailUtil.sendEmail("nsn251tp@gmail.com", subject, body);
            request.setAttribute("messageStatus", "Email sent successfully!");
        } catch (Exception e) {
            request.setAttribute("messageStatus", "Error sending email: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("contact.jsp");
        dispatcher.forward(request, response);
    }
}
    