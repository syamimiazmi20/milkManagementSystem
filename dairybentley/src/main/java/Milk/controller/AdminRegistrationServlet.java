package Milk.controller;

import java.io.IOException;

import Milk.dao.EmployeeDAO;
import Milk.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class AdminRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        EmployeeDAO employeeDAO = new EmployeeDAO();
        boolean isRegistered = employeeDAO.registerEmployee(name, email, password, address, phone, "Admin");

        if (isRegistered) {
            // Set the employee in the session
            Employee admin = employeeDAO.getEmployeeByEmail(email);
            HttpSession session = request.getSession();
            session.setAttribute("employee", admin);
            response.sendRedirect("adminLogin.jsp");
        } else {
            response.sendRedirect("adminRegistration.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
