package com.psl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.psl.model.Message;
import com.psl.model.Patient;
import com.psl.model.UserBean;

public class PatientEntry {
	Connection connection = ConnectionManager.getConnection();
	
	
	public ArrayList<Patient> UserDisplay(ArrayList<String> facility) {
		Patient patient = null;
		ArrayList<Patient> a = new ArrayList<Patient>();
		try {
			Statement st = connection.createStatement();
			String str="select * from patient where isdeleted='Added' and facility in (";
			for(String s: facility)
			{
				str+="'"+s+"',";
			}
			str = str.substring(0, str.length() - 1);
			str+=")";
			ResultSet rs = st.executeQuery(str);
		
			while (rs.next()) {
				patient = new Patient(rs.getInt(1),rs.getString(8), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getString(6), rs.getString(7));
				a.add(patient);
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
