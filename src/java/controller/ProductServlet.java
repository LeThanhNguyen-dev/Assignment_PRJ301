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

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO; 

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        productDAO.getAllProducts();
    }

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Lấy tham số từ request
        String category = request.getParameter("category");
        String priceRange = request.getParameter("priceRange");

        // Danh sách sản phẩm
        List<Product> productList;

        // Trường hợp 1 & 2 & 3: Xử lý logic lọc
        if ((category == null || category.isEmpty()) && (priceRange == null || priceRange.isEmpty())) {
            // Không chọn danh mục, không chọn giá -> Lấy tất cả sản phẩm
            productList = productDAO.getAllProducts();
        } else {
            // Có ít nhất một tiêu chí lọc (category hoặc priceRange)
            productList = productDAO.getFilteredProducts(category, priceRange);
        }

        // Lưu danh sách sản phẩm vào request
        request.setAttribute("product", productList);
        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }

}