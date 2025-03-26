package controller;

import dao.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminManageProduct", urlPatterns = {"/adminProduct"})
public class AdminManageProduct extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO(); // Khởi tạo DAO
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Mặc định hiển thị danh sách sản phẩm
        }

        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "add":
                addProduct(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    // Hiển thị danh sách sản phẩm
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("products", productList);
        request.getRequestDispatcher("adminProduct.jsp").forward(request, response);
    }

    // Thêm sản phẩm mới
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            Product newProduct = new Product(0, name, description, image, price, categoryId);
            productDAO.addProduct(newProduct); // Gọi phương thức thêm mới (sẽ thêm vào ProductDAO)
            response.sendRedirect("adminProduct?message=Add " + name + " successfully");
        } else {
            request.getRequestDispatcher("adminProduct.jsp").forward(request, response); // Hiển thị form thêm
        }
    }

    // Hiển thị form chỉnh sửa sản phẩm
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product existingProduct = productDAO.getProductById(id);
        request.setAttribute("product", existingProduct);
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("products", productList);
        request.getRequestDispatcher("adminProduct.jsp").forward(request, response);
    }

    // Cập nhật sản phẩm
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Product product = new Product(id, name, description, image, price, categoryId);
        productDAO.updateProduct(product); // Gọi phương thức cập nhật (sẽ thêm vào ProductDAO)
        response.sendRedirect("adminProduct");
    }

    // Xóa sản phẩm
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id); // Gọi phương thức xóa (sẽ thêm vào ProductDAO)
        response.sendRedirect("adminProduct");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing products in admin panel";
    }

    @Override
    public void destroy() {
        productDAO.closeConnection(); // Đóng kết nối khi servlet bị hủy
    }
}
