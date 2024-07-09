package Milk.controller;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Milk.connection.ConnectionManager;  // Import your ConnectionManager


public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            int userID = (int) session.getAttribute("userID");

            Connection connection = null;
            try {
                connection = ConnectionManager.getConnection();  // Use ConnectionManager to get the connection
                String sql = "DELETE FROM customers WHERE cust_id=?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, userID);
                statement.executeUpdate();

                // Invalidate the session after deletion
                session.invalidate();

                response.sendRedirect("index.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("viewCustomerProfile.jsp?error=true");
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            response.sendRedirect("customerLogin.jsp?error=notLoggedIn");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
