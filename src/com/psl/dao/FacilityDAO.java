package com.psl.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.psl.exception.WrongFormatException;
import com.psl.model.Facility;
import com.psl.model.Message;


public class FacilityDAO {
	static Connection conn = null;
	static ResultSet rSet = null;
	static PreparedStatement preparedStatement = null;
	boolean wrong=false;
	public void uploadData(BufferedReader reader) throws IOException, SQLException, WrongFormatException {

		String line;
		int i = 0;
		String query = "insert into Facility values(?, ?, ?, ?, ?, ?)";
		String rowCount = "select max(id) from Facility";
		try {
			
			conn = ConnectionManager.getConnection();
			Statement st = conn.createStatement();
			preparedStatement = conn.prepareStatement(query);
			rSet = st.executeQuery(rowCount);
			while (rSet.next())
				i = rSet.getInt(1);
			System.out.println("Id is:" +i);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		while ((line = reader.readLine()) != null) {
			String data[] = line.split(",");
			System.out.println(data.length);
			preparedStatement.setInt(1, ++i);
			if(data.length!=5)
				
					throw new WrongFormatException("CSV Format Not VAlid.");
			
			for (int j = 0; j < data.length; j++) {
				
				try {
					preparedStatement.setString(j + 2, data[j]);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			System.out.println(preparedStatement.toString());
			preparedStatement.executeUpdate();
			// boolean more = rSet.next();

		}
		return;
	} 
	
	public ArrayList<Facility> UserDisplay() {
		Facility facility = null;
		ArrayList<Facility> facilities = new ArrayList<Facility>();
		try {
			conn = ConnectionManager.getConnection();
			Statement st=conn.createStatement();
			String str="select * from Facility";
			rSet = st.executeQuery(str);
			//System.out.println(str);
			while (rSet.next()) 
			{
				facility = new Facility(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4), rSet.getString(5) ,
						rSet.getString(6));
				//System.out.println(pat);
				facilities.add(facility);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return facilities;
	}
	
	public int getCount()
	{
		int count=0;
		try {
			Statement st=conn.createStatement();
		ResultSet rs = st.executeQuery("select count(*) from Facility");
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
	
	public Message facilityUpload(Facility facility)
	{
		try {
			
			conn = ConnectionManager.getConnection();
			String query ="insert into Facility values(?, ?, ?, ?, ?, ?)";
			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setInt(1, facility.getId());
			preparedStatement.setString(2, facility.getName());
			preparedStatement.setString(3, facility.getAddress());
			preparedStatement.setString(4, facility.getCity());
			preparedStatement.setString(5, facility.getState());
			preparedStatement.setString(6, facility.getZip());
			System.out.println("In Upload"+preparedStatement);
			preparedStatement.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new Message("successfully registered", true);
	}
	
	public ArrayList<String> getMultipleFacility(String email)
	{
		try {
			conn = ConnectionManager.getConnection();
			Statement st=conn.createStatement();
			ArrayList<String> arr=new ArrayList<String>();
			String str="select Facility.Name from userlogin left join user_facility_mapping on "
					+ "userlogin.id = user_facility_mapping.userId left join Facility on Facility.id = user_facility_mapping.facilityId "
					+ "where Facility.Name is not null and userlogin.email='"+email+"' ";
			rSet = st.executeQuery(str);
			while(rSet.next()) 
			{
				arr.add(rSet.getString(1));
			}
			return arr;
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
	}
}
