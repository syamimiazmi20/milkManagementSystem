package Milk.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import Milk.model.MilkProduction;
import Milk.dao.MilkProductionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class MilkProductionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("milkProduction.jsp?error=Invalid+action");
            return;
        }

        String empIdString = request.getParameter("emp_id");
        String productionDateString = request.getParameter("production_date");
        String productionTime = request.getParameter("production_time");
        String amountString = request.getParameter("amount");

        if (empIdString == null || productionDateString == null || productionTime == null || amountString == null) {
            response.sendRedirect("milkProduction.jsp?error=Missing+required+fields");
            return;
        }

        int empId = 0;
        double amount = 0.0;

        try {
            empId = Integer.parseInt(empIdString);
            amount = Double.parseDouble(amountString);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("milkProduction.jsp?error=Invalid+number+format");
            return;
        }

        double totalProduction = amount;
        double amountBalance = amount;

        Date productionDate = null;
        try {
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(productionDateString);
            productionDate = new Date(utilDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("milkProduction.jsp?error=Invalid+date+format");
            return;
        }

        MilkProduction milk = new MilkProduction();
        milk.setEmpId(empId);
        milk.setProductionDate(productionDate);
        milk.setProductionTime(productionTime);
        milk.setAmount(amount);
        milk.setTotalProduction(totalProduction);
        milk.setAmountBalance(amountBalance);

        MilkProductionDAO dao = new MilkProductionDAO();

        if ("add".equals(action)) {
            dao.addMilkProduction(milk);
        } else if ("edit".equals(action)) {
            String productionIdString = request.getParameter("production_Id");
            if (productionIdString == null) {
                response.sendRedirect("milkProduction.jsp?error=Missing+production+ID");
                return;
            }

            int productionId = 0;
            try {
                productionId = Integer.parseInt(productionIdString);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("milkProduction.jsp?error=Invalid+production+ID+format");
                return;
            }

            milk.setProductionId(productionId);
            dao.updateMilkProduction(milk);
        } else {
            response.sendRedirect("milkProduction.jsp?error=Unknown+action");
            return;
        }

        request.setAttribute("milkProduction", milk);
        request.getRequestDispatcher("milkProduction.jsp").forward(request, response);
    }
}