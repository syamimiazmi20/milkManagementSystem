package Milk.controller;

import java.io.IOException;
import Milk.dao.EmployeeDAO;
import Milk.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class EmployeeLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        EmployeeDAO employeeDAO = new EmployeeDAO();
        if (employeeDAO.authenticateEmployee(email, password)) {
		    Employee employee = employeeDAO.getEmployeeByEmail(email);
		    if (employee != null) {
		        HttpSession session = request.getSession();
		        session.setAttribute("userID", employee.getId());
		        session.setAttribute("userName", employee.getName());
		        session.setAttribute("userEmail", employee.getEmail());
		        session.setAttribute("userAddress", employee.getAddress());
		        session.setAttribute("userPhone", employee.getPhoneNum());
		        session.setAttribute("userRole", employee.getRole());

		       
		        response.sendRedirect("milkProduction.jsp");
		    } else {
		        response.sendRedirect("employeeLogin.jsp?error=true");
		    }
		} else {
		    response.sendRedirect("employeeLogin.jsp?error=true");
		}
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
