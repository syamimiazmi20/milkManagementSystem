package Milk.controller;

import java.io.IOException;
import java.util.List;
import Milk.dao.MilkProductionRDAO;
import Milk.model.MilkProduction;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class ViewProductionReport extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        System.out.println("Received From Date: " + fromDate);
        System.out.println("Received To Date: " + toDate);

        if (fromDate == null || fromDate.isEmpty() || toDate == null || toDate.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date range");
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            // Validate date format
            sdf.parse(fromDate);
            sdf.parse(toDate);
        } catch (ParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format. Please use yyyy-MM-dd.");
            return;
        }

        MilkProductionRDAO dao = new MilkProductionRDAO();
        List<MilkProduction> milkList = dao.getMilkProductionByDateRange(fromDate, toDate);

        System.out.println("Milk List Size After DAO Call: " + milkList.size());

        request.setAttribute("milkList", milkList);
        request.getRequestDispatcher("ProductionReport.jsp").forward(request, response);
    }
}