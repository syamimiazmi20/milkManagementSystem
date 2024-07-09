package Milk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import Milk.connection.ConnectionManager;

public class AddShippingDAO {
    private static final String INSERT_SHIPPING_METHOD_SQL = "INSERT INTO shipping_method (cust_id, con_phone, shipping_type) VALUES (?, ?, ?)";
    private static final String INSERT_DELIVERY_SQL = "INSERT INTO delivery (shipping_id, receiver_name, send_address) VALUES (?, ?, ?)";
    private static final String INSERT_PICKUP_SQL = "INSERT INTO pickup (shipping_id, pickup_date, pickup_session) VALUES (?, ?, ?)";

    public int addShippingMethod(int cust_id, String con_phone, String shipping_type) throws SQLException {
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmtShipping = conn.prepareStatement(INSERT_SHIPPING_METHOD_SQL, new String[] {"SHIPPING_ID"})) {
     
            stmtShipping.setInt(1, cust_id);
            stmtShipping.setString(2, con_phone);
            stmtShipping.setString(3, shipping_type);

            int affectedRows = stmtShipping.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating shipping method failed, no rows affected.");
            }

            try (var generatedKeys = stmtShipping.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating shipping method failed, no ID obtained.");
                }
            }
        }
    }

    public void addDelivery(int shipping_id, String receiver_name, String send_address) throws SQLException {
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmtDelivery = conn.prepareStatement(INSERT_DELIVERY_SQL)) {

            stmtDelivery.setInt(1, shipping_id);
            stmtDelivery.setString(2, receiver_name);
            stmtDelivery.setString(3, send_address);

            stmtDelivery.executeUpdate();
        }
    }

    public void addPickup(int shipping_id, String pickup_date, String pickup_session) throws SQLException {
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmtPickup = conn.prepareStatement(INSERT_PICKUP_SQL)) {

            stmtPickup.setInt(1, shipping_id);
            stmtPickup.setString(2, pickup_date);
            stmtPickup.setString(3, pickup_session);

            stmtPickup.executeUpdate();
        }
    }
}
