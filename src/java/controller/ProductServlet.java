package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo ProductDAO khi servlet được khởi động
        productDAO = new ProductDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Không cần viết HTML trực tiếp ở đây nữa, sẽ forward sang JSP
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách sản phẩm từ ProductDAO
        List<Product> productList = productDAO.listAllProducts();

        // Đặt danh sách sản phẩm vào request attribute
        request.setAttribute("productList", productList);

        // Chuyển tiếp request và response sang home.jsp
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý thêm vào giỏ hàng (nếu cần)
        String productId = request.getParameter("productId");
        if (productId != null) {
            // Logic thêm sản phẩm vào giỏ hàng có thể được thêm ở đây
            // Ví dụ: Lấy sản phẩm theo ID và thêm vào session hoặc database
            Product product = productDAO.getProductById(Integer.parseInt(productId));
            if (product != null) {
                // Ví dụ: Thêm vào giỏ hàng (chưa triển khai chi tiết)
                System.out.println("Added to cart: " + product.getName());
            }
        }
        // Sau khi xử lý POST, gọi lại doGet để hiển thị danh sách sản phẩm
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to handle product listing and cart actions";
    }

    @Override
    public void destroy() {
        // Đóng kết nối khi servlet bị hủy
        if (productDAO != null) {
            productDAO.closeConnection();
        }
    }
}