package Milk.controller;

import java.io.IOException;

import Milk.dao.EmployeeDAO;
import Milk.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class UpdateEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        int adminId = Integer.parseInt(request.getParameter("adminId"));

        Employee employee = new Employee(id, name, address, role, email, "", phone, 0);
        EmployeeDAO employeeDAO = new EmployeeDAO();
        boolean isUpdated = employeeDAO.updateEmployee(employee);

        if (isUpdated) {
            response.sendRedirect("ManageEmployeesServlet");
        } else {
            response.sendRedirect("manageEmployees.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
