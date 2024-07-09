package Milk.connection;


/**
 * Author: FES
 * Date: June 2024
 * Purpose: CSC584 Assignment 2
 */

import java.sql.*;

public class ConnectionManager {
	static Connection con;
	//private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
	//private static final String DB_CONNECTION = "jdbc:mysql://localhost/test";
	//private static final String DB_USER = "root";
	//public static final String DB_PASSWORD = "";
	
	//oracle
	private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";//Driver class
	private static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:xe";//Connection URL
	private static final String DB_USER = "DMMS"; 	//Change to your DB Username
	public static final String DB_PASSWORD = "DMMS";	//Change to your DB Password
	
	public static Connection getConnection() {
		try {
			//1. load the driver
			Class.forName(DB_DRIVER);
			try {
				//2. create connection
				con = DriverManager.getConnection(DB_CONNECTION,DB_USER,DB_PASSWORD);
				System.out.println("Connected");
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		catch  (ClassNotFoundException e) {
			System.out.println(e);
		}
		return con;
	}
}

