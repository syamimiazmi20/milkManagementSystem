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
import Milk.connection.ConnectionManager;
import Milk.model.Employee;

public class deleteAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("employee") != null) {
            Employee employee = (Employee) session.getAttribute("employee");
            int empId = employee.getId();
            Connection connection = null;
            try {
                connection = ConnectionManager.getConnection();
                String sql = "DELETE FROM employees WHERE id=?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, empId);
                int rowsDeleted = statement.executeUpdate();
                
                if (rowsDeleted > 0) {
                    // Invalidate the session after deletion
                    session.invalidate();
                    response.sendRedirect("index.jsp?deleted=true");
                } else {
                    response.sendRedirect("viewAdminProfile.jsp?error=DeleteFailed");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("viewAdminProfile.jsp?error=DatabaseError");
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
            response.sendRedirect("adminLogin.jsp?error=notLoggedIn");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}