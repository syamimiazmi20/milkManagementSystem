package Milk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Milk.model.MilkProduction;
import Milk.connection.ConnectionManager;

public class MilkProductionDAO {

	public List<MilkProduction> getAllMilkProduction() {
	    List<MilkProduction> milkList = new ArrayList<>();
	    try (Connection con = ConnectionManager.getConnection()) {
	        // Order by production_id to ensure the newest entries are at the top
	        String query = "SELECT * FROM milkproduction ORDER BY production_id DESC";
	        try (PreparedStatement ps = con.prepareStatement(query);
	             ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                MilkProduction milk = new MilkProduction();
	                milk.setProductionId(rs.getInt("production_id"));
	                milk.setEmpId(rs.getInt("emp_id"));
	                milk.setProductionDate(rs.getDate("production_date"));
	                milk.setProductionTime(rs.getString("production_time"));
	                milk.setAmount(rs.getDouble("amount_in"));
	                milk.setTotalProduction(rs.getDouble("total_production"));
	                milk.setAmountBalance(rs.getDouble("amount_balance"));
	                milkList.add(milk);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return milkList;
	}

    public boolean addMilkProduction(MilkProduction milk) {
        String query = "INSERT INTO milkproduction (emp_id, production_date, production_time, amount_in, total_production, amount_balance) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, milk.getEmpId());
            ps.setDate(2, milk.getProductionDate());
            ps.setString(3, milk.getProductionTime());
            ps.setDouble(4, milk.getAmount());
            ps.setDouble(5, milk.getTotalProduction());
            ps.setDouble(6, milk.getAmountBalance());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public MilkProduction getMilkProductionById(int id) throws SQLException {
        MilkProduction milk = new MilkProduction();
        String query = "SELECT * FROM milkproduction WHERE production_id = ?";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    milk.setProductionId(rs.getInt("production_id"));
                    milk.setEmpId(rs.getInt("emp_id"));
                    milk.setProductionDate(rs.getDate("production_date"));
                    milk.setProductionTime(rs.getString("production_time"));
                    milk.setAmount(rs.getDouble("amount_in"));
                    milk.setTotalProduction(rs.getDouble("total_production"));
                    milk.setAmountBalance(rs.getDouble("amount_balance"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return milk;
    }
    
    public static MilkProduction getLatestMilkProduction() throws SQLException {
        MilkProduction milk = new MilkProduction();
        String query = "SELECT *\r\n"
        		+ "FROM (\r\n"
        		+ "    SELECT MAX(production_id) AS production_id, emp_id, production_date, production_time, amount_in, total_production, amount_balance \r\n"
        		+ "    FROM milkproduction\r\n"
        		+ "    GROUP BY emp_id, production_date, production_time, amount_in, total_production, amount_balance\r\n"
        		+ "    ORDER BY 1 DESC\r\n"
        		+ ")\r\n"
        		+ "WHERE ROWNUM = 1";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

//            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    milk.setProductionId(rs.getInt("production_id"));
                    milk.setEmpId(rs.getInt("emp_id"));
                    milk.setProductionDate(rs.getDate("production_date"));
                    milk.setProductionTime(rs.getString("production_time"));
                    milk.setAmount(rs.getDouble("amount_in"));
                    milk.setTotalProduction(rs.getDouble("total_production"));
                    milk.setAmountBalance(rs.getDouble("amount_balance"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return milk;
    }


    public static double getLatestMilkProductionAmtBal() throws SQLException {
        double amtbal = 0.0;
        String query = "SELECT amount_balance FROM milkproduction WHERE ROWNUM = 1 ORDER BY production_id DESC";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                amtbal = rs.getDouble("amount_balance");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return amtbal;
    }

    public void updateMilkProduction(MilkProduction milk) {
        String query = "UPDATE milkproduction SET emp_id = ?, production_date = ?, production_time = ?, amount_in = ?, total_production = ?, amount_balance = ? WHERE production_id = ?";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
        	

            ps.setInt(1, milk.getEmpId());
            ps.setDate(2, milk.getProductionDate());
            ps.setString(3, milk.getProductionTime());
            ps.setDouble(4, milk.getAmount());
            ps.setDouble(5, milk.getTotalProduction());
            ps.setDouble(6, milk.getAmountBalance());
            ps.setInt(7, milk.getProductionId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static int getLatestMilkProductionProdId() throws SQLException {
        int prodId = 0;
        String query = "SELECT production_id FROM milkproduction WHERE ROWNUM = 1 ORDER BY production_id DESC";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                prodId = rs.getInt("production_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return prodId;
    }
    
    public static double getMilkProductionAmount(int productionId) throws SQLException {
        double amount = 0.0;
        String query = "SELECT amount_in FROM milkproduction WHERE production_id = ?";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, productionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    amount = rs.getDouble("amount_in");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return amount;
    }

public void updateMilkProductionAmtBal(double newAmtBal, int prodId) throws SQLException {
    String query = "UPDATE milkproduction SET amount_balance = ? WHERE production_id = ?";
    try (Connection con = ConnectionManager.getConnection();
         PreparedStatement ps = con.prepareStatement(query)) {

        ps.setDouble(1, newAmtBal);
        ps.setInt(2, prodId);

        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
        throw e;
    }
	}

	public double getTotalMilkProductionLast30Days() throws SQLException {
    String query = "SELECT SUM(total_production) FROM milkproduction WHERE production_date >= SYSDATE - 30";
    try (Connection con = ConnectionManager.getConnection();
         PreparedStatement ps = con.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getDouble(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw e;
      }
    return 0;
	}
}
