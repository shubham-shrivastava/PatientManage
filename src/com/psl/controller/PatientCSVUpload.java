package com.psl.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.psl.model.Patient;
import com.psl.model.UserBean;

/**
 * Servlet implementation class PatientCSVUpload
 */
@WebServlet("/upload.do")
@MultipartConfig
public class PatientCSVUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Connection conn = null;
	static ResultSet rSet = null;
	static PreparedStatement preparedStatement = null;
	//Patient patient = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
  

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		InputStream inputStream, inputStream2 = null;
		//String query = "insert into patient values(?, ?, ?, ?, ?)";
		/*try {
			conn = com.psl.dao.ConnectionManager.getConnection();
			preparedStatement = conn.prepareStatement(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		Part filePart = request.getPart("input7[]");
		System.out.println(filePart.getName());
		System.out.println(filePart.getSize());
		inputStream = filePart.getInputStream();
		inputStream2 = filePart.getInputStream();
		// inputStream.mark(0);
		ArrayList<Patient> arr=new ArrayList<Patient>();
		BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
		//BufferedReader reader1 = new BufferedReader(new InputStreamReader(inputStream2));
		try {
			Class<?> clazz = Class.forName("com.psl.dao.PatientDAO");
			Object obj = clazz.newInstance();
			//UserBean userBean= (UserBean)request.getSession().getAttribute("user");
			//String facility=userBean.getFacility();
			ArrayList<String> facility=(ArrayList<String>)request.getSession().getAttribute("multiFacility");
			Method method = clazz.getMethod("uploadData", reader.getClass(), facility.getClass());
			arr=(ArrayList<Patient>) method.invoke(obj, reader, facility);
			
		}
		
		catch (ClassNotFoundException | InstantiationException | IllegalAccessException | NoSuchMethodException
				| SecurityException | IllegalArgumentException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.getCause();
			e.printStackTrace();
		} 
		
		//request.setAttribute("Reader", reader1);
		//System.out.println(reader.toString());
		// System.out.println("Reaching here");
		request.setAttribute("Reader", arr);
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/uploadSuccess.jsp");
		requestDispatcher.forward(request, response);
	}

}
