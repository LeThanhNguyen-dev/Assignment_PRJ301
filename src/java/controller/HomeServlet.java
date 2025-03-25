package controller;

import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductSales;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số categoryId từ request, mặc định là 1 nếu không hợp lệ
        String categoryIdStr = request.getParameter("categoryId");
        int categoryId = 1; // Mặc định là 1 (Men)
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int parsedId = Integer.parseInt(categoryIdStr);
                if (parsedId >= 1 && parsedId <= 3) { // Giới hạn categoryId từ 1 đến 3
                    categoryId = parsedId;
                }
            } catch (NumberFormatException e) {
                // Nếu không parse được, giữ categoryId = 1
            }
        }

        // Lấy top 3 sản phẩm bán chạy nhất theo categoryId từ ProductDAO
        List<ProductSales> topProductSales = productDAO.getTop3ProductsPerCategory(categoryId);
        List<Product> topProducts = new ArrayList<>();

        if (topProductSales == null || topProductSales.isEmpty()) {
            // Nếu không có dữ liệu bán hàng, lấy 3 sản phẩm đầu tiên của danh mục
            String categoryName = categoryId == 1 ? "Men" : categoryId == 2 ? "Women" : "Kid";
            List<Product> allProducts = productDAO.getProductsByCategory(categoryName);
            topProducts = allProducts.size() > 3 ? allProducts.subList(0, 3) : allProducts;
            request.setAttribute("noSalesData", "Hiện chưa có dữ liệu bán hàng cho danh mục này.");
        } else {
            // Nếu có dữ liệu bán hàng, lấy thông tin sản phẩm chi tiết
            for (ProductSales sales : topProductSales) {
                Product product = productDAO.getProductById(sales.getProductId());
                if (product != null) {
                    topProducts.add(product);
                }
            }
        }

        // Đặt danh sách sản phẩm và categoryId hiện tại vào request
        request.setAttribute("topProductList", topProducts);
        request.setAttribute("selectedCategoryId", categoryId);

        // Chuyển hướng đến home.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "HomeServlet for displaying top products";
    }
}