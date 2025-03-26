/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NhatNS
 */
@WebServlet(name = "AdminPaymentUpdateServlet", urlPatterns = {"/AdminPaymentUpdateServlet"})
public class AdminPaymentUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");

        OrderDAO dao = new OrderDAO();
        if (dao.updateOrderStatus(Integer.parseInt(orderId), "Completed")) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"success\", \"message\": \"Success\"}");
        } else {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"fail\", \"message\": \"Fail\"}");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
