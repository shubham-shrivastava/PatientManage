package com.psl.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.psl.dao.UserDAO;
import com.psl.model.UserBean;

/**
 * Servlet implementation class WannaChangePW
 */
@WebServlet("/WannaChangePW.do")
public class WannaChangePW extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WannaChangePW() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		 UserBean user = new UserBean();
		   
	     user.setEmail(request.getParameter("email"));
	     user.setPassword(request.getParameter("password"));
	    // PrintWriter out = response.getWriter();
	     user = UserDAO.login(user);
	     HttpSession session=request.getSession(false); 
		request.setAttribute("firstlogin", 1);
		 // request.setAttribute("email", user.getEmail());
		  
		  request.getRequestDispatcher("changepassword.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
