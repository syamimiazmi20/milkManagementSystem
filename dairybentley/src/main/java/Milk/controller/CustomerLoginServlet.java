package Milk.controller;

import java.io.IOException;
import java.sql.SQLException;

import Milk.dao.CustomerDAO;
import Milk.dao.MilkProductionDAO;
import Milk.model.Customer;
import Milk.model.MilkProduction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        CustomerDAO customerDAO = new CustomerDAO();
        try {
            if (customerDAO.authenticateCustomer(email, password)) {
                Customer customer = customerDAO.getCustomerByEmail(email);
                if (customer != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userID", customer.getId());
                    session.setAttribute("userName", customer.getName());
                    session.setAttribute("userEmail", customer.getEmail());
                    session.setAttribute("userAddress", customer.getAddress());
                    session.setAttribute("userPhone", customer.getPhoneNum());
                    session.setAttribute("userRole", "Customer");
                    MilkProduction milk = MilkProductionDAO.getLatestMilkProduction();
                    request.setAttribute("milkProduction", milk);
                    request.getRequestDispatcher("MilkPurchase.jsp").forward(request, response);
//                    response.sendRedirect("MilkPurchase.jsp");
                } else {
                    response.sendRedirect("customerLogin.jsp?error=true");
                }
            } else {
                response.sendRedirect("customerLogin.jsp?error=true");
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customerLogin.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
