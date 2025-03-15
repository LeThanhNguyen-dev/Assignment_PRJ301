package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import dao.CustomerDAO;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer currentCustomer = (Customer) session.getAttribute("session_Login");
        
        if (currentCustomer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        if (name == null || phone == null || email == null || address == null ||
            name.trim().isEmpty() || phone.trim().isEmpty() || email.trim().isEmpty() || address.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            return;
        }

        if (!phone.matches("[0-9]{10}")) {
            request.setAttribute("error", "Số điện thoại phải là 10 chữ số!");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            return;
        }

        Customer updatedCustomer = new Customer(
            currentCustomer.getId(),
            currentCustomer.getUsername(),
            currentCustomer.getPassword(),
            name,
            phone,
            email,
            address
        );

        CustomerDAO customerDAO = new CustomerDAO();

        if (!email.equals(currentCustomer.getEmail()) && customerDAO.isUsernameOrEmailExist(null, email)) {
            request.setAttribute("error", "Email đã được sử dụng bởi tài khoản khác!");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            return;
        }

        if (updateCustomerInDB(customerDAO, updatedCustomer)) {
            session.setAttribute("session_Login", updatedCustomer);
            request.setAttribute("message", "Cập nhật thông tin thành công!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Cập nhật thông tin thất bại!");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
        }
    }

    private boolean updateCustomerInDB(CustomerDAO customerDAO, Customer customer) {
        String query = "UPDATE Customer SET name = ?, phone = ?, email = ?, address = ? WHERE id = ?";
        
        try {
            java.sql.PreparedStatement stmt = customerDAO.c.prepareStatement(query);
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getPhone());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getAddress());
            stmt.setInt(5, customer.getId());
            
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}