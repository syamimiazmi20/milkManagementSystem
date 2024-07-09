package Milk.dao; 
 
import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.sql.SQLException; 
import java.util.ArrayList; 
import java.util.List;

import Milk.connection.ConnectionManager;
import Milk.model.MilkProduction;
import Milk.model.MilkPurchase;
import Milk.model.payment; 
 
public class MilkPurchaseDAO { 
 
    private Connection connection; 
 
    public MilkPurchaseDAO(Connection connection) { 
        this.connection = connection; 
    } 
 
    public List<MilkPurchase> getAllMilkPurchases() throws SQLException { 
        List<MilkPurchase> purchases = new ArrayList<>(); 
        String query = "SELECT * FROM MILK_PURCHASE"; 
        try (PreparedStatement statement = connection.prepareStatement(query); 
             ResultSet resultSet = statement.executeQuery()) { 
            while (resultSet.next()) { 
                MilkPurchase purchase = new MilkPurchase(); 
                purchase.setPurchaseID(resultSet.getInt("purchase_id")); 
                purchase.setCustID(resultSet.getInt("cust_id")); 
                purchase.setAmountLiter(resultSet.getDouble("amount_liter")); 
                purchase.setTotalPrice(resultSet.getDouble("total_price")); 
                purchases.add(purchase); 
            } 
        } 
        return purchases; 
    } 
 
    public void addMilkPurchase(MilkPurchase purchase) throws SQLException { 
//    	MilkProduction milk = new MilkProduction();
    	payment payment = null;
        String query = "INSERT INTO MILK_PURCHASE (production_id, cust_id, amount_liter, total_price, payment_id, shipping_id, purchase_id) VALUES (?, ?, ?, ?,?, ?,?)"; 
        try (PreparedStatement statement = connection.prepareStatement(query)) { 
        	statement.setInt(1, purchase.getProductionId()); 
            statement.setInt(2, purchase.getCustID()); 
            statement.setDouble(3, purchase.getAmountLiter()); 
            statement.setDouble(4, purchase.getTotalPrice()); 
//            statement.setInt(5, purchase.getPaymentId()); 
            int payid = MilkPurchaseDAO.getLatestPayment();
            statement.setInt(5, payid); 
            statement.setInt(6, purchase.getShipping_id()); 
            statement.setInt(7, purchase.getPurchaseID()); 
            System.out.println("PaymentID: "+ payid);

            statement.executeUpdate(); 
        } 
    } 
 
    public void deleteMilkPurchase(int purchase_id) throws SQLException { 
        String query = "DELETE FROM MILK_PURCHASE  WHERE purchase_id = ?"; 
        try (PreparedStatement statement = connection.prepareStatement(query)) { 
            statement.setInt(1, purchase_id); 
            statement.executeUpdate(); 
        } 
    } 
 
    public MilkPurchase getMilkPurchaseById(int purchase_id) throws SQLException { 
        MilkPurchase purchase = null; 
        String query = "SELECT * FROM MILK_PURCHASE  WHERE purchase_id = ?"; 
        try (PreparedStatement statement = connection.prepareStatement(query)) { 
            statement.setInt(1, purchase_id); 
            try (ResultSet resultSet = statement.executeQuery()) { 
                if (resultSet.next()) { 
                    purchase = new MilkPurchase(); 
                    purchase.setPurchaseID(resultSet.getInt("purchase_id")); 
                    purchase.setCustID(resultSet.getInt("cust_id")); 
                    purchase.setAmountLiter(resultSet.getDouble("amount_liter")); 
                    purchase.setTotalPrice(resultSet.getDouble("total_price")); 
                } 
            } 
        } 
        return purchase; 
    } 
 
    public void updateMilkPurchase(MilkPurchase purchase) throws SQLException { 
        String query = "UPDATE MILK_PURCHASE  SET cust_id = ?, amount_liter = ?, total_price = ? WHERE purchase_id = ?"; 
        try (PreparedStatement statement = connection.prepareStatement(query)) { 
            statement.setInt(1, purchase.getCustID()); 
            statement.setDouble(2, purchase.getAmountLiter()); 
            statement.setDouble(3, purchase.getTotalPrice()); 
            statement.setInt(4, purchase.getPurchaseID()); 
            statement.executeUpdate(); 
            
//            amount_balance(0) = purchase.getAmountBalance() - purchase.getAmountLiter();
        } 
    } 
    
    public static int getLatestPayment() throws SQLException {
        payment pay = new payment();
        int payid = 0;
        String query = "SELECT * FROM (\r\n"
        		+ "    SELECT MAX(payment_id) AS payment_id, payment_date, payment_type\r\n"
        		+ "    FROM payment\r\n"
        		+ "    GROUP BY payment_id, payment_date, payment_type\r\n"
        		+ "    ORDER BY 1 DESC\r\n"
        		+ ")\r\n"
        		+ "WHERE ROWNUM = 1";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

//            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pay.setPayment_id(rs.getInt("payment_id"));
                    pay.setPayment_date(rs.getDate("payment_date"));
                    pay.setPayment_type(rs.getString("payment_Type"));
                    payid = pay.getPayment_id();
                    System.out.println("get PaymentID: "+ pay.getPayment_id());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return payid;
    }
    
    public double getTotalSalesLast30Days() throws SQLException {
        String query = "SELECT SUM(mp.total_price) FROM milk_purchase mp " +
                       "JOIN payment p ON mp.payment_id = p.payment_id " +
                       "WHERE p.payment_date >= SYSDATE - 30";
        try (PreparedStatement ps = connection.prepareStatement(query);
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