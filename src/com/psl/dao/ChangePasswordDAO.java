package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.psl.model.Message;

public class ChangePasswordDAO {
	static Connection connection = null;
	static ResultSet rSet = null;
	static PreparedStatement preparedStatement = null;
	private static String query = "update userlogin set Password=?, FirstLogin=0 where Email=?";
	public static Message changePassword(String password, String email){
		try{
			connection = ConnectionManager.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, password);
			preparedStatement.setString(2, email);
			System.out.println(preparedStatement.toString());
			int updated = preparedStatement.executeUpdate();
			if(updated==1){
				return new Message("Successfully updated", true);
			}
			
				
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new Message("Not updated", false);
		
	}
}
