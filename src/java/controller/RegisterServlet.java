package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import dao.CustomerDAO;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String sessionEmail = (String) session.getAttribute("otpEmail");
        String sessionOTP = (String) session.getAttribute("otp");
        String submittedEmail = request.getParameter("email");
        String submittedOTP = request.getParameter("otp");

        if (sessionEmail == null || sessionOTP == null || !sessionEmail.equals(submittedEmail) || !sessionOTP.equals(submittedOTP)) {
            request.setAttribute("error", "Invalid OTP code or email!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (username == null || password == null || name == null || phone == null || address == null
                || username.trim().isEmpty() || password.trim().isEmpty() || name.trim().isEmpty()
                || phone.trim().isEmpty() || address.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();

        if (customerDAO.isUsernameOrEmailExist(username, submittedEmail)) {
            request.setAttribute("error", "Username or Email already exists!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        Customer newCustomer = new Customer(0, username, password, name, phone, submittedEmail, address);

        boolean added = customerDAO.addCustomer(newCustomer);

        if (added) {
            // Xóa OTP khỏi session sau khi đăng ký thành công
            session.removeAttribute("otp");
            session.removeAttribute("otpEmail");
            request.setAttribute("message", "Registration successful! Please login.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
