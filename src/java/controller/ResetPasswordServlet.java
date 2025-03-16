package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetPassword"})
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String resetEmail = (String) session.getAttribute("resetEmail");
        String resetOTP = (String) session.getAttribute("resetOTP");
        String submittedOTP = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");

        if (resetEmail == null || resetOTP == null || !resetOTP.equals(submittedOTP)) {
            request.setAttribute("error", "Invalid or expired OTP!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "New password cannot be empty!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        boolean updated = customerDAO.updatePassword(resetEmail, newPassword);

        if (updated) {
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetOTP");
            response.sendRedirect("login.jsp?message=Password+reset+successfully");
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }
}