package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.psl.model.Message;
import com.psl.model.UserBean;

public class UserEntry {
	Connection connection = ConnectionManager.getConnection();
	public Message createUser(String firstName, String lastName, String email, String facility,String[] facilities, String role,
			String status) {
		Connection connection = ConnectionManager.getConnection();
		try {
			Statement st = connection.createStatement();
			PreparedStatement preparedStatement = null;
			Statement stmt = connection.createStatement();
			ResultSet rs = st.executeQuery("select Firstname from userlogin where Email='" + email + "'");
			if (rs.next()) {
				return new Message("email is already taken", false);
			}
			ResultSet rset = null;
			String sql = "insert into userlogin(Firstname,Lastname,Email,Password, Facility, Role,Status, Deleted) values(?,?,?,?,?,?,?,?)";
			String query = "select id from Facility where Name=?";
			String getindex = "Set @user_index = LAST_INSERT_ID();";
			String mapQuery="insert into user_facility_mapping values(@user_index, ?)";
			preparedStatement = connection.prepareStatement(query);
			int[] ids=new int[facilities.length];
			int i = 0;
			for(String f : facilities){
				preparedStatement.setString(1, f);
				rset = preparedStatement.executeQuery();
				while(rset.next())
					ids[i] = rset.getInt("id");
				i++;
			}
			PreparedStatement pst = connection.prepareStatement(sql);
			pst.setString(1, firstName);
			pst.setString(2, lastName);
			pst.setString(3, email);
			pst.setString(4, firstName + "_" + lastName);
			pst.setString(5, facility);
			pst.setString(6, role);
			pst.setString(7, status);
			pst.setInt(8, 0);
			pst.executeUpdate();
			pst.close();
			stmt.execute(getindex);
			preparedStatement = connection.prepareStatement(mapQuery);
			for(int id : ids){
				System.out.println(id);
				preparedStatement.setInt(1, id);
				preparedStatement.executeUpdate();
			}
			return new Message("successfully registered", true);
		} catch (SQLException e) {
			e.printStackTrace();
			return new Message("exception", false);
		}
	}
	
	
	public ArrayList<UserBean> UserDisplay() {
		UserBean user = null;
		ArrayList<UserBean> a = new ArrayList<UserBean>();
		try {
			Statement st = connection.createStatement();
			String str="select * from userlogin";
			ResultSet rs = st.executeQuery(str);
		
			while (rs.next()) {
				user = new UserBean(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(6),
						rs.getString(7), rs.getBoolean(8), rs.getString(9) );
				a.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return a;
	}
	
	public int getCount()
	{
		int count=0;
		try {
		
		Statement st = connection.createStatement();
		ResultSet rs = st.executeQuery("select count(*) from userlogin");
		if(rs.next())
		{
			count=rs.getInt(1);
			return count;
		}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
