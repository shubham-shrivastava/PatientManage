package com.psl.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.psl.model.Message;
import com.psl.dao.ChangePatientStatus;
import com.psl.dao.ChangeUserStatus;

/**
 * Servlet implementation class StatusUpdate
 */
@WebServlet("/deleted.do")
public class DeletionUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletionUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String str[]=request.getParameterValues("status[]");
		

		for(String s: str)
		{
			System.out.println(s);
		}
		
		ChangePatientStatus ob= new ChangePatientStatus();
		Message message=ob.Updation(str);
		if(message.isSuccessful())
	      {
	    	 request.getSession().setAttribute("name", message);
	    	  //response.sendRedirect("UserServlet");
	    	 // request.getRequestDispatcher("DisplayUser.jsp").forward(request, response);
	    	 request.getRequestDispatcher("/delete.do").forward(request, response);
	      }
	      else
	    	  response.sendRedirect("Delete.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
