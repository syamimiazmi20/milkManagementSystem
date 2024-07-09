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
import Milk.connection.*;

public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            int userID = (int) session.getAttribute("userID");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String phoneNum = request.getParameter("phoneNum");

            try {
                Connection connection = ConnectionManager.getConnection();
                String sql = "UPDATE customers SET cust_name=?, cust_email=?, cust_address=?, cust_phoneNum=? WHERE cust_id=?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, name);
                statement.setString(2, email);
                statement.setString(3, address);
                statement.setString(4, phoneNum);
                statement.setInt(5, userID);
                statement.executeUpdate();
                connection.close();

                // Update session attributes
                session.setAttribute("userName", name);
                session.setAttribute("userEmail", email);
                session.setAttribute("userAddress", address);
                session.setAttribute("userPhone", phoneNum);

                response.sendRedirect("viewCustomerProfile.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("editCustomerProfile.jsp?error=true");
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
