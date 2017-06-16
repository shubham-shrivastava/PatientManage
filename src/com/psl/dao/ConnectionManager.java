package com.psl.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//import java.util.Properties;

public class ConnectionManager {
	static Connection connection;
	static String url;
	
	public static Connection getConnection() {
		//Properties properties = new Properties();
		try{
			/*InputStream inputStream = new FileInputStream("jdbc.properties");
			properties.load(inputStream);
			String driverClass = properties.getProperty("MYSQLJDBC.driver");
			String url = properties.getProperty("MYSQLJDBC.url");
			String username = properties.getProperty("MYSQLJDBC.username");
			String password = properties.getProperty("MYSQLJDBC.password");*/
			Class.forName("com.mysql.jdbc.Driver");
			try{
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "root", "Shubham@25");
			}catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}catch (ClassNotFoundException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return connection;
		
	}
}
