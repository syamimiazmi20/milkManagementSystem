package Milk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import Milk.connection.ConnectionManager;
import Milk.model.payment;


public class AddPaymentDAO {

    public void addPayment(payment newPayment) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Get a connection from the ConnectionManager
            con = ConnectionManager.getConnection();

            if (con != null) {
                System.out.println("Database connection established.");

                // SQL query to insert a new payment record
                String sql = "INSERT INTO payment (payment_id, payment_date, payment_type) VALUES (payment_id_seq.NEXTVAL, ?, ?)";

                // Prepare the statement
                ps = con.prepareStatement(sql);
                ps.setDate(1, new java.sql.Date(newPayment.getPayment_date().getTime())); // convert java.util.Date to java.sql.Date
                ps.setString(2, newPayment.getPayment_type());

                // Execute the update
                int rowsAffected = ps.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
                int payid = MilkPurchaseDAO.getLatestPayment();
                System.out.println("FROM addpaymentDAO payid: " + payid);
            } else {
                System.err.println("Failed to establish database connection.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
