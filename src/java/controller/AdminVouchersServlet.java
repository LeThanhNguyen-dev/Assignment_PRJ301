package controller;

import dao.VoucherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Voucher;

@WebServlet("/admin/vouchers")
public class AdminVouchersServlet extends HttpServlet {
    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        try {
            voucherDAO = new VoucherDAO();
            if (voucherDAO == null) {
                throw new ServletException("Failed to initialize VoucherDAO");
            }
        } catch (Exception e) {
            throw new ServletException("Error initializing VoucherDAO: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                // Hiển thị danh sách voucher
                List<Voucher> vouchers = voucherDAO.getAllVouchers();
                if (vouchers == null) {
                    throw new ServletException("Voucher list is null");
                }
                request.setAttribute("vouchers", vouchers);
                request.getRequestDispatcher("/adminVouchers.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                // Lấy thông tin voucher để sửa
                int id = Integer.parseInt(request.getParameter("id"));
                Voucher voucher = voucherDAO.getVoucherById(id);
                if (voucher == null) {
                    throw new ServletException("Voucher not found with ID: " + id);
                }
                request.setAttribute("voucher", voucher);
                List<Voucher> vouchers = voucherDAO.getAllVouchers();
                if (vouchers == null) {
                    throw new ServletException("Voucher list is null");
                }
                request.setAttribute("vouchers", vouchers);
                request.getRequestDispatcher("/adminVouchers.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                // Xóa voucher
                int id = Integer.parseInt(request.getParameter("id"));
                voucherDAO.deleteVoucher(id);
                response.sendRedirect("vouchers");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid voucher ID format");
            request.getRequestDispatcher("/adminVouchers.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                // Thêm voucher mới
                String code = request.getParameter("code");
                double discount = Double.parseDouble(request.getParameter("discount"));
                String expiryDateStr = request.getParameter("expiryDate");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date expiryDate;
                try {
                    expiryDate = sdf.parse(expiryDateStr);
                } catch (Exception e) {
                    expiryDate = new Date();
                }
                Voucher voucher = new Voucher(0, code, discount, expiryDate);
                voucherDAO.addVoucher(voucher);
                response.sendRedirect("vouchers");
            } else if ("update".equals(action)) {
                // Cập nhật voucher
                int id = Integer.parseInt(request.getParameter("id"));
                String code = request.getParameter("code");
                double discount = Double.parseDouble(request.getParameter("discount"));
                String expiryDateStr = request.getParameter("expiryDate");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date expiryDate;
                try {
                    expiryDate = sdf.parse(expiryDateStr);
                } catch (Exception e) {
                    expiryDate = new Date();
                }
                Voucher voucher = new Voucher(id, code, discount, expiryDate);
                voucherDAO.updateVoucher(voucher);
                response.sendRedirect("vouchers");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid discount or ID format");
            request.getRequestDispatcher("/adminVouchers.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}