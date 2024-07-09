package Milk.controller;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import Milk.model.MilkProduction;
import Milk.dao.MilkProductionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
public class EditMilkEntryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productionIdString = request.getParameter("production_id");
        String empIdString = request.getParameter("emp_id");
        String productionDateStr = request.getParameter("production_date");
        String productionTime = request.getParameter("production_time");
        String amountString = request.getParameter("amount");
        if (productionIdString == null || empIdString == null || productionDateStr == null || productionTime == null || amountString == null) {
            response.sendRedirect("milkProduction.jsp?error=Missing+required+fields");
            return;
        }
        int productionId;
        int empId;
        double amount;
        try {
            productionId = Integer.parseInt(productionIdString);
            empId = Integer.parseInt(empIdString);
            amount = Double.parseDouble(amountString);
        } catch (NumberFormatException e) {
            response.sendRedirect("milkProduction.jsp?error=Invalid+number+format");
            return;
        }
        Date productionDate;
        try {
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(productionDateStr);
            productionDate = new Date(utilDate.getTime());
        } catch (ParseException e) {
            response.sendRedirect("milkProduction.jsp?error=Invalid+date+format");
            return;
        }
        
        double previousAmount = 0.0;
        double latestBalance = 0.0;
        try {
            previousAmount = MilkProductionDAO.getMilkProductionAmount(productionId);
            latestBalance = MilkProductionDAO.getLatestMilkProductionAmtBal();
        } catch (SQLException e) {
            response.sendRedirect("milkProduction.jsp?error=Error+fetching+data");
            return;
        }

        double amountDifference = amount - previousAmount;
        double newAmtBal = latestBalance + amountDifference;

        
        MilkProduction milk = new MilkProduction();
        milk.setProductionId(productionId);
        milk.setEmpId(empId);
        milk.setProductionDate(productionDate);
        milk.setProductionTime(productionTime);
        milk.setAmount(amount);
        milk.setTotalProduction(amount);
        milk.setAmountBalance(newAmtBal);
        MilkProductionDAO dao = new MilkProductionDAO();
        dao.updateMilkProduction(milk);
        response.sendRedirect("milkProduction.jsp");
    }
}