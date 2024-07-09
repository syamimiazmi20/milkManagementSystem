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

public class AddMilkEntryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String empIdString = request.getParameter("empId");
        String productionDateString = request.getParameter("productionDate");
        String productionTime = request.getParameter("productionTime");
        String amountString = request.getParameter("amount");

        if (empIdString == null || productionDateString == null || productionTime == null || amountString == null) {
            response.sendRedirect("milkProduction.jsp?error=Missing+required+fields");
            return;
        }

        int empId;
        double amount;

        try {
            empId = Integer.parseInt(empIdString);
            amount = Double.parseDouble(amountString);
        } catch (NumberFormatException e) {
            response.sendRedirect("milkProduction.jsp?error=Invalid+number+format");
            return;
        }

        Date productionDate;
        try {
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(productionDateString);
            productionDate = new Date(utilDate.getTime());
        } catch (ParseException e) {
            response.sendRedirect("milkProduction.jsp?error=Invalid+date+format");
            return;
        }

        // Fetch the latest amount balance
        double latestBalance = 0.0;
        try {
            latestBalance = MilkProductionDAO.getLatestMilkProductionAmtBal();
        } catch (Exception e) {
            response.sendRedirect("milkProduction.jsp?error=Error+fetching+latest+balance");
            return;
        }

        // Calculate the new amount balance
        double newBalance = latestBalance + amount;

        MilkProduction milk = new MilkProduction();
        milk.setEmpId(empId);
        milk.setProductionDate(productionDate);
        milk.setProductionTime(productionTime);
        milk.setAmount(amount);
        milk.setTotalProduction(amount);
        milk.setAmountBalance(newBalance);

        MilkProductionDAO dao = new MilkProductionDAO();
        boolean success = dao.addMilkProduction(milk);

        if (success) {
            response.sendRedirect("milkProduction.jsp");
        } else {
            response.sendRedirect("milkProduction.jsp?error=Failed+to+add+milk+entry");
        }
    }
}
