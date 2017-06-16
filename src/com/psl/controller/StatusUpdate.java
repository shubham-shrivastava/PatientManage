package com.psl.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.psl.model.Message;
import com.psl.dao.ChangeUserStatus;

/**
 * Servlet implementation class StatusUpdate
 */
@WebServlet("/updated.do")
public class StatusUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatusUpdate() {
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
		

		 //HttpSession session=request.getSession(true); 
		ChangeUserStatus ob= new ChangeUserStatus();
		Message message=ob.Updation(str);
		if(message.isSuccessful())
	      {
			request.setAttribute("update", "Updated");
	    	request.getSession().setAttribute("name", message);
	    	  //response.sendRedirect("UserServlet");
	    	 // request.getRequestDispatcher("DisplayUser.jsp").forward(request, response);
	    	 request.getRequestDispatcher("/admin").forward(request, response);
	      }
	      else
	    	  response.sendRedirect("DisplayUser.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
