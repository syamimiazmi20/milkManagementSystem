package Milk.controller;

import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import Milk.dao.EmployeeDAO;
import Milk.dao.MilkProductionDAO;
import Milk.dao.MilkPurchaseDAO;
import Milk.connection.ConnectionManager;

//@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EmployeeDAO employeeDAO = new EmployeeDAO();
        MilkProductionDAO milkProductionDAO = new MilkProductionDAO();
        Connection connection = null;

        try {
            connection = ConnectionManager.getConnection();
            MilkPurchaseDAO milkPurchaseDAO = new MilkPurchaseDAO(connection);

            int totalEmployees = employeeDAO.getTotalEmployees();
            double totalMilkProduction = milkProductionDAO.getTotalMilkProductionLast30Days();
            double totalSales = milkPurchaseDAO.getTotalSalesLast30Days();

            request.setAttribute("totalEmployees", totalEmployees);
            request.setAttribute("totalMilkProduction", totalMilkProduction);
            request.setAttribute("totalSales", totalSales);

            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
