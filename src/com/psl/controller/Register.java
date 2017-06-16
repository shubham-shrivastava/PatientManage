package com.psl.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.psl.dao.UserEntry;
import com.psl.model.Message;

/**
 * Servlet implementation class Register
 */
@WebServlet("/register.do")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
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
		response.setContentType("text/html");
	      PrintWriter out = response.getWriter();
	      String firstName=request.getParameter("firstName");
	      String lastName =request.getParameter("lastName");
	      String email=request.getParameter("email");
	      String facility=request.getParameter("FacilityName");
	      String[] facilityarray=request.getParameterValues("FacilityName");
	      String role = request.getParameter("role");
	      System.out.println(role);
	      String status=request.getParameter("activation");
	      
	      UserEntry ue=new UserEntry();
	      Message message=ue.createUser(firstName, lastName, email, facility, facilityarray, role,status);
	      if(message.isSuccessful())
	      {
	    	 request.setAttribute("name", message);
	    	 request.getRequestDispatcher("/admin").forward(request, response);
//	    	  response.sendRedirect("UserServlet");
	      }
	      else
	    	  response.sendRedirect("registration.jsp");
	}

}
