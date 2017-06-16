package com.psl.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class Facility
 */
@WebServlet("/facilityUpload.do")
@MultipartConfig
public class FacilityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FacilityController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

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

		BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
		BufferedReader reader1 = new BufferedReader(new InputStreamReader(inputStream2));
		try {
			Class<?> clazz = Class.forName("com.psl.dao.FacilityDAO");
			Object obj = clazz.newInstance();
			Method method = clazz.getMethod("uploadData", reader.getClass());
			method.invoke(obj, reader);

		}
		
		catch (ClassNotFoundException | InstantiationException | IllegalAccessException | NoSuchMethodException
				| SecurityException | IllegalArgumentException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		request.setAttribute("Reader", reader1);
		//System.out.println(reader.toString());
		// System.out.println("Reaching here");
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/facilityuploaded.jsp");
		requestDispatcher.forward(request, response);
		doGet(request, response);
	}

}
