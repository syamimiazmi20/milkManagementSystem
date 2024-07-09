package Milk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import Milk.model.MilkProduction;
import Milk.connection.ConnectionManager;

public class MilkProductionRDAO {

    public List<MilkProduction> getMilkProductionByDateRange(String fromDate, String toDate) {
        List<MilkProduction> milkList = new ArrayList<>();
        String query = "SELECT * FROM MilkProduction WHERE TO_DATE(TO_CHAR(production_date, 'DD/MM/RRRR'), 'DD/MM/RRRR') BETWEEN TO_DATE(?, 'DD/MM/RRRR') AND TO_DATE(?, 'DD/MM/RRRR')";
        SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfOutput = new SimpleDateFormat("dd/MM/yyyy");

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            // Parse the date strings to java.sql.Date in the appropriate format
            java.sql.Date sqlFromDate = new java.sql.Date(sdfInput.parse(fromDate).getTime());
            java.sql.Date sqlToDate = new java.sql.Date(sdfInput.parse(toDate).getTime());

            // Format the dates to match the database date format
            String formattedFromDate = sdfOutput.format(sqlFromDate);
            String formattedToDate = sdfOutput.format(sqlToDate);

            System.out.println("SQL From Date: " + formattedFromDate);
            System.out.println("SQL To Date: " + formattedToDate);

            ps.setString(1, formattedFromDate);
            ps.setString(2, formattedToDate);

            System.out.println("Executing query: " + ps);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MilkProduction milk = new MilkProduction();
                    milk.setProductionId(rs.getInt("production_id"));
                    milk.setProductionDate(rs.getDate("production_date"));
                    milk.setProductionTime(rs.getString("production_time"));
                    milk.setAmount(rs.getDouble("amount_in"));
                    milk.setTotalProduction(rs.getDouble("total_production"));
                    milk.setAmountBalance(rs.getDouble("amount_balance"));
                    milk.setEmpId(rs.getInt("emp_id"));
                    milkList.add(milk);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Log the size of the milkList to ensure data is being retrieved
        System.out.println("Milk Production List Size: " + milkList.size());
        return milkList;
    }
}