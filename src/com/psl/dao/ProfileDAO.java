package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.psl.model.Message;
import com.psl.model.UserBean;

public class ProfileDAO {
	Connection connection = ConnectionManager.getConnection();
	public Message MyProfile (UserBean user,String[] facilityArr ,String orgid)
	{
		
		try {
	
				String query = "update userlogin set Firstname=?, Lastname=?, Email=?, Facility=? where Email = ?";
				PreparedStatement preparedStmt = connection.prepareStatement(query);
				preparedStmt.setString(1,user.getFirstName());
				preparedStmt.setString(2, user.getLastName());
				preparedStmt.setString(3,user.getEmail());
				preparedStmt.setString(4, user.getFacility());
				preparedStmt.setString(5,orgid);
				
				System.out.println(preparedStmt);
				preparedStmt.executeUpdate();
				
				
				
				String query1 = "select id from Facility where Name=?";
				PreparedStatement preparedStatement = connection.prepareStatement(query1);
				int[] ids=new int[facilityArr.length];
				int i = 0;
				ResultSet rset=null;
				for(String f : facilityArr){
					preparedStatement.setString(1, f);
					rset = preparedStatement.executeQuery();
					while(rset.next())
						ids[i] = rset.getInt("id");
					i++;
				}
				String getindex = "Select id from userlogin where Email=?";
				PreparedStatement preparedSt = connection.prepareStatement(getindex);
				preparedSt.setString(1,user.getEmail());
				ResultSet r=preparedSt.executeQuery();
				int idy=0;
				if(r.next())
					idy=r.getInt(1);
				
				String deleteQ="delete from user_facility_mapping where userId=?";
				preparedStatement = connection.prepareStatement(deleteQ);
				preparedStatement.setInt(1, idy);
				preparedStatement.executeUpdate();
				
				String mapQuery="insert into user_facility_mapping values(?, ?)";
				preparedStatement = connection.prepareStatement(mapQuery);
				for(int id : ids){
					System.out.println(id);
					preparedStatement.setInt(1, idy);
					preparedStatement.setInt(2, id);
					preparedStatement.executeUpdate();
				}
				return new Message("changed profile details", true);

		}catch (Exception e) {
			e.printStackTrace();
	//		return new Message("exception", false);
		}
	//	return new Message("successfull", true);
		return new Message("error", true);

		}
}
