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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String resetEmail = (String) session.getAttribute("resetEmail");
        String resetOTP = (String) session.getAttribute("resetOTP");
        String submittedOTP = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");

        if (resetEmail == null || resetOTP == null || !resetOTP.equals(submittedOTP)) {
            response.sendRedirect("resetPassword?error=Invalid+or+expired+OTP!");
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        boolean updated = customerDAO.updatePassword(resetEmail, newPassword);

        if (updated) {
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetOTP");
            response.sendRedirect("login?message=Password+reset+successfully");
        } else {
            response.sendRedirect("resetPassword?error=Failed+to+reset+password.+Please+try+again.");
        }
    }
}
