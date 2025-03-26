package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import utils.EmailUtil;

@WebServlet("/sendEmail")
public class ContactServlet extends HttpServlet {

    private final ExecutorService executor = Executors.newFixedThreadPool(10);
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        String subject = "Contact Form Message from " + name;
        String body = "Message from: " + name + "\nEmail: " + email + "\n\n" + message;

        executor.submit(() -> {
            try {
                EmailUtil.sendEmail("nsn251tp@gmail.com", subject, body);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        request.setAttribute("messageStatus", "An email was sent to us.");
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
    @Override
    public void destroy() {
        executor.shutdown();
    }
}
