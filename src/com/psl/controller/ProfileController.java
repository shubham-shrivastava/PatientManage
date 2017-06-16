package com.psl.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.psl.dao.FacilityDAO;
import com.psl.dao.ProfileDAO;
import com.psl.model.Message;
import com.psl.model.UserBean;

/**
 * Servlet implementation class ProfileController
 */
@WebServlet("/ProfileController.do")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		ProfileDAO pf= new ProfileDAO();
		String orgid=request.getParameter("id");
		String name=request.getParameter("name");
		System.out.println(name+" "+orgid);
		
		String email=request.getParameter("email");
		String facility=request.getParameter("facility");
	      String[] facilityarray=request.getParameterValues("FacilityName");
	      if(facilityarray==null)
	      { 
	    	  //System.out.println("yoooooo");
	    	  facilityarray=facility.split(" ");
	      }
		String role=request.getParameter("role");
		System.out.println(role);
		String status=request.getParameter("status");
		String nm[]=name.split(" ");
		UserBean user= new UserBean(0, nm[0], nm[1], email, facility, role,false, status);
		
		Message message=pf.MyProfile(user, facilityarray, orgid);
		if(message.isSuccessful())
	      {
			request.getSession().setAttribute("name", message);
			HttpSession session=request.getSession(false);
			session.setAttribute("user", user);
			ArrayList<String> facilityArr= new FacilityDAO().getMultipleFacility(user.getEmail());
	          session.setAttribute("multiFacility", facilityArr);
			if(role.equals("Admin"))
				request.getRequestDispatcher("admin").forward(request, response);
			else
				request.getRequestDispatcher("clerk.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
