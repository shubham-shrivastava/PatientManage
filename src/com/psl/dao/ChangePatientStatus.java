package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.psl.model.Message;

public class ChangePatientStatus {
	Connection connection = ConnectionManager.getConnection();
	public Message Updation (String[] arr)
	{
		
		try {
	
			for(String str: arr)
			{
				String a[]=str.split(" ");
				System.out.println(a[0]+" "+a[1]);
				String query = "update patient set isdeleted = ? where id = ?";
				PreparedStatement preparedStmt = connection.prepareStatement(query);
				preparedStmt.setString(1, a[1]);
				preparedStmt.setInt(2, Integer.parseInt(a[0]));
				System.out.println(preparedStmt);
				preparedStmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
			return new Message("exception", false);
		}
		return new Message("successfull", true);

		}
}
