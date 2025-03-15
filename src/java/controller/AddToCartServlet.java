/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CustomerDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import model.Product;

/**
 *
 * @author Dell
 */
@WebServlet(name="AddToCartServlet", urlPatterns={"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {
   
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddToCartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId); // Get product from DB

        if (product != null) {
            HttpSession session = request.getSession();
            Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            // Check if the product is already in the cart
            cart.put(product, cart.getOrDefault(product, 0) + 1); // Add product or update quantity
            session.setAttribute("cart", cart); // Update cart in session

            // Update the total number of items in the cart
            int cartSize = cart.values().stream().mapToInt(Integer::intValue).sum();
            session.setAttribute("cartSize", cartSize);

            // Optionally, set a message or redirect after adding to cart
            request.setAttribute("message", "Product added to cart!");
        }

        response.sendRedirect("home.jsp"); // Redirect to homepage or cart page
    }


    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
