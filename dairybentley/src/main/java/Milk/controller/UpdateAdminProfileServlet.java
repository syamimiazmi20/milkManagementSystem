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

public class UpdateAdminProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("employee") != null) {
            Employee employee = (Employee) session.getAttribute("employee");
            int empId = employee.getId();
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String phoneNum = request.getParameter("phone");

            try {
                Connection connection = ConnectionManager.getConnection();
                String sql = "UPDATE employees SET emp_name=?, emp_email=?, emp_address=?, emp_phoneNum=? WHERE emp_id=?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, name);
                statement.setString(2, email);
                statement.setString(3, address);
                statement.setString(4, phoneNum);
                statement.setInt(5, empId);
                
                int rowsUpdated = statement.executeUpdate();
                connection.close();

                if (rowsUpdated > 0) {
                    // Update the Employee object
                    employee.setName(name);
                    employee.setEmail(email);
                    employee.setAddress(address);
                    employee.setPhoneNum(phoneNum);

                    // Update session attribute
                    session.setAttribute("employee", employee);
                    response.sendRedirect("viewAdminProfile.jsp?success=true");
                } else {
                    response.sendRedirect("viewAdminProfile.jsp?error=UpdateFailed");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("viewAdminProfile.jsp?error=DatabaseError");
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
