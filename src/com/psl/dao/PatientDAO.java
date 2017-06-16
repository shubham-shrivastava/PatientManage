package com.psl.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import com.psl.model.*;
import com.psl.exception.*;

public class PatientDAO {
	static Connection conn = null;
	static ResultSet rSet = null;
	static PreparedStatement preparedStatement = null;
	boolean wrong=false;
	public ArrayList<Patient> uploadData(BufferedReader reader,ArrayList<String> facility) throws IOException, SQLException, WrongFormatException, FacilityNotMatched {

		String line;
		int i = 0;
		Patient p;
		ArrayList<Patient> arr=new ArrayList<Patient>();
		String query = "insert into patient values(?, ?, ?, ?, ?, ?, 'Added',?)";
		String rowCount = "select max(id) from patient";
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
			System.out.println(data.length+ "...."+data[2]);
			
			if(data.length!=6)
			{	
				System.out.println(data[0]+ " is not inserted coz insuff data");
				//throw new WrongFormatException("CSV Format Not VAlid.");
			}
			else if(!(facility.contains(data[2])))
			{
				System.out.println(data[0]+ " is not inserted coz facility is diff");
				//throw new FacilityNotMatched("Facility of patient is not matching to your facility");
			}
			else
			{	
				preparedStatement.setInt(1, ++i);
				Date admit = Date.valueOf(data[3]);
				Date discharge = Date.valueOf(data[4]);
				preparedStatement.setDate(5, admit);
				preparedStatement.setDate(6, discharge);
				
				for (int j = 0; j < data.length-2; j++) {
					
					try {
						preparedStatement.setString(j + 2, data[j]);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	
				}
				preparedStatement.setString(7, data[5]);
				System.out.println(preparedStatement.toString());
				preparedStatement.executeUpdate();
				p=new Patient(data[5],data[0], data[1], data[2], data[3], data[4]);
				arr.add(p);
				// boolean more = rSet.next();
			}

		}
		return arr;
	} 
	
	/*public ArrayList<Patient> UserDisplay(int page) {
		return UserDisplay(page, 5);
	}
	public ArrayList<Patient> UserDisplay() {
		return UserDisplay(1, 5);
	}*/
	public ArrayList<Patient> UserDisplay(int page, int limit) {
		Patient pat = null;
		ArrayList<Patient> a = new ArrayList<Patient>();
		try {
			conn = ConnectionManager.getConnection();
			Statement st=conn.createStatement();
			String str="select * from patient limit "+(page-1)*limit+", "+limit;
			rSet = st.executeQuery(str);
			System.out.println(str);
			while (rSet.next()) 
			{
				pat = new Patient(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4), rSet.getString(5) ,
						rSet.getString(6), rSet.getString(7), rSet.getString(8));
				//System.out.println(pat);
				a.add(pat);
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
			Statement st=conn.createStatement();
		ResultSet rs = st.executeQuery("select count(*) from patient");
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
