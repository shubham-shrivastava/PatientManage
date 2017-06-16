package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.psl.model.Message;


public class ChangeUserStatus 
{
	Connection connection = ConnectionManager.getConnection();
	public Message Updation (String[] arr)
	{
		
		try {
			
			//ResultSet rs = st.executeQuery("select id from userlogin");
			for(String str: arr)
			{
				if(str!=null)
				{
					String a[]=str.split(" ");
					System.out.println(a[0]+" "+a[1]);
					String query = "update userlogin set Status = ? where id = ?";
					PreparedStatement preparedStmt = connection.prepareStatement(query);
					preparedStmt.setString(1, a[1]);
					preparedStmt.setInt(2, Integer.parseInt(a[0]));
					System.out.println(preparedStmt);
					preparedStmt.executeUpdate();
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			return new Message("exception", false);
		}
		return new Message("successfully registered", true);

		}
	}
