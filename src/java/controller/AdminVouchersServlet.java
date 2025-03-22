package controller;

import dao.VoucherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Voucher;

@WebServlet("/adminVouchers")
public class AdminVouchersServlet extends HttpServlet {
    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        try {
            voucherDAO = new VoucherDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing VoucherDAO: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra session admin
        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        try {
            if (action == null) {
                // Hiển thị danh sách voucher
                listVouchers(request, response);
            } else if ("edit".equals(action)) {
                // Lấy thông tin voucher để sửa
                editVoucher(request, response);
            } else if ("delete".equals(action)) {
                // Xóa voucher
                deleteVoucher(request, response);
            }
        } catch (SQLException e) {
            handleError(request, response, "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        } catch (Exception e) {
            handleError(request, response, "Đã xảy ra lỗi: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra session admin
        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                // Thêm voucher mới
                addVoucher(request, response);
            } else if ("update".equals(action)) {
                // Cập nhật voucher
                updateVoucher(request, response);
            }
        } catch (SQLException e) {
            handleError(request, response, "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        } catch (Exception e) {
            handleError(request, response, "Đã xảy ra lỗi: " + e.getMessage());
        }
    }

    // Kiểm tra admin đã đăng nhập chưa
    private boolean isAdminLoggedIn(HttpServletRequest request) {
        return request.getSession(false) != null && request.getSession().getAttribute("session_Admin") != null;
    }

    // Hiển thị danh sách voucher
    private void listVouchers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Voucher> vouchers = voucherDAO.getAllVouchers();
        if (vouchers == null) {
            throw new ServletException("Danh sách voucher rỗng");
        }
        request.setAttribute("vouchers", vouchers);
        request.getRequestDispatcher("/adminVouchers.jsp").forward(request, response);
    }

    // Lấy thông tin voucher để sửa
    private void editVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Voucher voucher = voucherDAO.getVoucherById(id);
        if (voucher == null) {
            throw new ServletException("Không tìm thấy voucher với ID: " + id);
        }
        request.setAttribute("voucher", voucher);
        listVouchers(request, response); // Hiển thị lại danh sách voucher
    }

    // Xóa voucher
    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        voucherDAO.deleteVoucher(id);
        request.setAttribute("success", "Xóa voucher thành công!");
        listVouchers(request, response); // Hiển thị lại danh sách với thông báo thành công
    }

    // Thêm voucher mới
    private void addVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String code = request.getParameter("code");
        double discount = Double.parseDouble(request.getParameter("discount"));
        String expiryDateStr = request.getParameter("expiryDate");
        Date expiryDate = parseDate(expiryDateStr);
        Voucher voucher = new Voucher(0, code, discount, expiryDate);
        voucherDAO.addVoucher(voucher);
        request.setAttribute("success", "Thêm voucher thành công!");
        listVouchers(request, response); // Hiển thị lại danh sách với thông báo thành công
    }

    // Cập nhật voucher
    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        double discount = Double.parseDouble(request.getParameter("discount"));
        String expiryDateStr = request.getParameter("expiryDate");
        Date expiryDate = parseDate(expiryDateStr);
        Voucher voucher = new Voucher(id, code, discount, expiryDate);
        voucherDAO.updateVoucher(voucher);
        request.setAttribute("success", "Cập nhật voucher thành công!");
        listVouchers(request, response); // Hiển thị lại danh sách với thông báo thành công
    }

    // Chuyển đổi chuỗi ngày thành Date
    private Date parseDate(String dateStr) throws ServletException {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.parse(dateStr);
        } catch (Exception e) {
            throw new ServletException("Định dạng ngày không hợp lệ: " + dateStr);
        }
    }

    // Xử lý lỗi
    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        try {
            listVouchers(request, response); // Hiển thị lại trang adminVouchers.jsp với thông báo lỗi
        } catch (SQLException e) {
            // Nếu listVouchers thất bại do lỗi cơ sở dữ liệu, hiển thị thông báo lỗi
            request.setAttribute("error", "Không thể tải danh sách voucher: " + e.getMessage());
            request.getRequestDispatcher("/adminVouchers.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        if (voucherDAO != null) {
            voucherDAO.closeConnection();
        }
    }
}