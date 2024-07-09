package Milk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Milk.model.Customer;
import Milk.connection.ConnectionManager;

public class CustomerDAO {
    private ConnectionManager connectionManager;

    public CustomerDAO() {
        connectionManager = new ConnectionManager();
    }

    public boolean registerCustomer(String name, String email, String password, String address, String phone) {
        boolean isSuccess = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "INSERT INTO CUSTOMERS (cust_name, cust_email, cust_password, cust_address, cust_phoneNum) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, address);
            ps.setString(5, phone);

            int rowCount = ps.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }

        return isSuccess;
    }

    public boolean authenticateCustomer(String email, String password) {
        boolean isAuthenticated = false;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "SELECT * FROM CUSTOMERS WHERE cust_email = ? AND cust_password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                isAuthenticated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }

        return isAuthenticated;
    }

    public Customer getCustomerByEmail(String email) throws SQLException {
        Customer customer = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = connectionManager.getConnection();
            String query = "SELECT * FROM CUSTOMERS WHERE cust_email = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);

            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("cust_id");
                String name = rs.getString("cust_name");
                String address = rs.getString("cust_address");
                String password = rs.getString("cust_password");
                String phoneNum = rs.getString("cust_phoneNum");

                customer = new Customer(id, name, address, email, password, phoneNum);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }

        return customer;
    }

  
    private void closeResources(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
