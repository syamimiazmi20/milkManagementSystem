package Milk.connection;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        // Attempt to get a connection
        Connection con = ConnectionManager.getConnection();
        
        // Check if the connection is successful
        if (con != null) {
            System.out.println("Connection established successfully!");
        } else {
            System.out.println("Failed to establish connection.");
        }
    }
}
