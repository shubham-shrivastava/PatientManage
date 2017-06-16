package com.psl.controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.psl.dao.ChangePasswordDAO;
import com.psl.dao.ConnectionManager;
import com.psl.model.Message;
import com.psl.model.UserBean;

/**
 * Servlet implementation class ChangePassword
 */
@WebServlet("/change.do")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection = ConnectionManager.getConnection();
	UserBean bean = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePassword() {
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
		String password=request.getParameter("password");
		UserBean userBean= (UserBean)request.getSession().getAttribute("user");
		String email = userBean.getEmail();
		
		Message message = ChangePasswordDAO.changePassword(password, email);
		System.out.println(message.toString());
		if(message.isSuccessful())
	      {
	    	// request.getSession().setAttribute("name", message);
			request.setAttribute("name", new Message("password changed", true));
		request.getRequestDispatcher("login.jsp").forward(request, response);
	      }
		//doGet(request, response);
	}

}
