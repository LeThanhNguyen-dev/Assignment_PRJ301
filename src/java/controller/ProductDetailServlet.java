package controller;

import java.io.IOException;

import com.google.gson.Gson;
import dao.ProductDetailDAO;
import dto.ProductDetailDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProductDetailServlet")
public class ProductDetailServlet extends HttpServlet {
    private ProductDetailDAO productDetailDAO;

    @Override
    public void init() throws ServletException {
        productDetailDAO = new ProductDetailDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid product ID\"}");
            return;
        }

        ProductDetailDTO productDetailDTO = productDetailDAO.getProductDetailsById(productId);
        if (productDetailDTO == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"Product not found\"}");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        String json = gson.toJson(productDetailDTO);
        response.getWriter().write(json);
    }
}