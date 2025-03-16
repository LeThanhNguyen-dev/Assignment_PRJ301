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
    private ProductDAO productDAO; // Assume this is your data access object

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO(); // Initialize your DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> productList;

        if (category == null || category.isEmpty()) {
            // Fetch all products
            productList = productDAO.getAllProducts();
        } else {
            // Fetch products by category
            productList = productDAO.getProductsByCategory(category);
        }

        // Set productList in request scope
        request.setAttribute("product", productList);

        // Forward to product.jsp
        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }
}