package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Customer;
import model.Product;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo instance của ProductDAO
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("session_Login");

        if (customer != null && customer.getCart() != null) {
            customer.updateCart();
            List<CartItem> cartItems = customer.getCart();
            List<Product> productsInCart = new ArrayList<>();

            // Sử dụng instance của ProductDAO để lấy thông tin sản phẩm
            for (CartItem cartItem : cartItems) {
                Product product = productDAO.getProductById(cartItem.getProductId());
                if (product != null) {
                    productsInCart.add(product);
                }
            }

            // Đặt dữ liệu vào request để JSP sử dụng
            request.setAttribute("productsInCart", productsInCart);
            request.setAttribute("cartItems", cartItems);
        }

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
    
    
    
}
