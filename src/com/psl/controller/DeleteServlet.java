package com.psl.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.psl.model.*;
import com.psl.dao.*;
/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/delete.do")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		PatientEntry pentry = new PatientEntry();
		//UserBean userBean= (UserBean)request.getSession().getAttribute("user");
		ArrayList<String> facility=(ArrayList<String>)request.getSession().getAttribute("multiFacility");
		ArrayList<Patient> arrayList= pentry.UserDisplay(facility);
		
		int totalUser=pentry.getCount();
		int pg=(int) Math.ceil(totalUser/5.0);
		request.setAttribute("totalUser", new Integer(totalUser));
		request.setAttribute("pages", new Integer(pg));
		request.setAttribute("PatientList", arrayList);
		if(request.getMethod().equals("POST"))
			request.setAttribute("name", new Message("successfully updated", true));
		 request.getRequestDispatcher("Delete.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
