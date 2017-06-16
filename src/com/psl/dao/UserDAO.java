package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.psl.model.*;

public class UserDAO {
	static Connection conn = null;
	static ResultSet rSet = null;
	static PreparedStatement preparedStatement = null;

	public static UserBean login(UserBean bean) {
		Statement statement = null;
		String email = bean.getEmail();
		String password = bean.getPassword();
		String searchQuery = "select * from `userlogin` where `Email`=? and `Password`=?";

		try {
			conn = ConnectionManager.getConnection();
			// statement = conn.createStatement();
			preparedStatement = conn.prepareStatement(searchQuery);
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, password);
			System.out.println(preparedStatement.toString());
			rSet = preparedStatement.executeQuery();
			boolean more = rSet.next();

			if (!more) {
				System.out.println("Sorry, you are not a registered user! Please sign up first");
				bean.setValid(false);
			} else if (more) {
				String firstName = rSet.getString("Firstname");
				String lastName = rSet.getString("Lastname");
				String userEmail = rSet.getString("Email");
				String facility = rSet.getString("Facility");
				String role = rSet.getString("Role");
				String status = rSet.getString("Status");
				boolean firstLogin = rSet.getBoolean("FirstLogin");
				
				System.out.println("Welcome " + firstName + " " + lastName + " Role " + role + "Is First Login" + firstLogin);
				bean.setEmail(userEmail);
				bean.setFirstName(firstName);
				bean.setLastName(lastName);
				bean.setRole(role);
				bean.setStatus(status);
				bean.setFacility(facility);
				bean.setFirstLogin(firstLogin);
				// bean.setName(name);
				bean.setValid(true);
			}
		} catch (Exception ex) {
			System.out.println("Log In failed: An Exception has occurred! " + ex);
		}

		// some exception handling
		finally {
			if (rSet != null) {
				try {
					rSet.close();
				} catch (Exception e) {
				}
				rSet = null;
			}

			if (statement != null) {
				try {
					statement.close();
				} catch (Exception e) {
				}
				statement = null;
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}

				conn = null;
			}
		}
		return bean;
	}
}