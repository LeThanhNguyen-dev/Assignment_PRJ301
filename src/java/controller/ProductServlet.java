package controller;

import dao.ProductDAO;
import dao.ProductDetailDAO;
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
    private ProductDetailDAO pdtDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        pdtDAO = new ProductDetailDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String category = request.getParameter("category");
        String priceRange = request.getParameter("priceRange");

        List<Product> productList;

        if ((category == null || category.isEmpty()) && (priceRange == null || priceRange.isEmpty())) {

            productList = productDAO.getAllProducts();
        } else {

            productList = productDAO.getFilteredProducts(category, priceRange);
        }

        List<Integer> soldOutListIds = pdtDAO.getIdListSoldOut();
        request.setAttribute("soldOutListIds", soldOutListIds);
        request.setAttribute("product", productList);

        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }

}
