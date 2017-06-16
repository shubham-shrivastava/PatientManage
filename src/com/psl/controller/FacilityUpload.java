package com.psl.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.User;

import com.psl.dao.FacilityDAO;
import com.psl.dao.UserEntry;
import com.psl.model.Facility;
import com.psl.model.Message;
import com.psl.model.Patient;
import com.psl.model.UserBean;

/**
 * Servlet implementation class FacilityUpload
 */
@WebServlet("/FacilityUpload.do")
public class FacilityUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FacilityUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		//UserBean userBean=(UserBean)request.getSession().getAttribute("user");
		//if(userBean.getRole().equals("Admin"))
		System.out.println(request.getSession().getAttribute("newFacility"));
		if(request.getSession().getAttribute("newFacility") != null)
		{
			
			  String Name=request.getParameter("firstName");
		      String Address =request.getParameter("address");
		      String City=request.getParameter("city");
		      String State=request.getParameter("state");
		      String Zipcode = request.getParameter("zipcode");
		    
		      Facility facility = new Facility(0, Name, Address, City, State, Zipcode);
		      FacilityDAO facilityDAO = new FacilityDAO();
		      String status = (String) request.getAttribute("jumpedFrom");
		     
		     // System.out.println(status);
		      
		      Message message=facilityDAO.facilityUpload(facility);
			
		      if(message.isSuccessful())
		      {
		    	  ArrayList<Facility> arrayList= facilityDAO.UserDisplay();
		  		
		  		int totalUser=facilityDAO.getCount();
		  		int pg=(int) Math.ceil(totalUser/5.0);
		  		request.setAttribute("totalFacility", new Integer(totalUser));
		  		request.setAttribute("pages", new Integer(pg));
		  		request.setAttribute("FacilityList", arrayList);
		    	 request.setAttribute("name", new Message("successfully updated", true));
		    	 request.getRequestDispatcher("showFacility.jsp").forward(request, response);
	//	    	  response.sendRedirect("UserServlet");
		      }
		      else
		    	  response.sendRedirect("facilityupload.jsp");
		}
		else
		{
			FacilityDAO facilityDAO = new FacilityDAO();
			ArrayList<Facility> arrayList= facilityDAO.UserDisplay();
	  		
	  		
	  		
	  		request.setAttribute("FacilityList", arrayList);
	  
	    	 request.getRequestDispatcher("showFacility.jsp").forward(request, response);
//	    	  response.sendRedirect("UserServlet");
	     
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
