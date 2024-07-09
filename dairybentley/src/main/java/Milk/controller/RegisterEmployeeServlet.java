package Milk.controller;

import java.io.IOException;

import Milk.dao.EmployeeDAO;
import Milk.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class RegisterEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
        	
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");
            int adminId = 1;

            EmployeeDAO employeeDAO = new EmployeeDAO();
            boolean isRegistered = employeeDAO.registerEmployee(name, email, password, address, phone, role);

            if (isRegistered) {
                response.sendRedirect("ManageEmployeesServlet");
            } else {
                response.sendRedirect("manageEmployees.jsp?error=true");
            }
        } else if ("delete".equals(action)) {
            int empId = Integer.parseInt(request.getParameter("Id"));

            EmployeeDAO employeeDAO = new EmployeeDAO();
            boolean isDeleted = employeeDAO.deleteEmployee(empId);

            if (isDeleted) {
                response.sendRedirect("ManageEmployeesServlet");
            } else {
                response.sendRedirect("manageEmployees.jsp?error=true");
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");

            Employee employee = new Employee(id, name, address, role, email, "", phone, 0);

            EmployeeDAO employeeDAO = new EmployeeDAO();
            boolean isUpdated = employeeDAO.updateEmployee(employee);

            if (isUpdated) {
                response.sendRedirect("ManageEmployeesServlet");
            } else {
                response.sendRedirect("manageEmployees.jsp?error=true");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}