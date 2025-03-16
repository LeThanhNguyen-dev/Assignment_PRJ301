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
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String category = request.getParameter("category");
        List<Product> productList;

        if (category == null || category.isEmpty()) {
            productList = productDAO.getAllProducts();
        } else {
            productList = productDAO.getProductsByCategory(category);
        }

        request.setAttribute("product", productList);
        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }}