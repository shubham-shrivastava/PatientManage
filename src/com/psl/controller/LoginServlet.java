package com.psl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.psl.dao.FacilityDAO;
import com.psl.dao.UserDAO;
import com.psl.model.Message;
import com.psl.model.UserBean;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Map<String, String> messages = new HashMap<String, String>();
		//request.setAttribute("messages", messages);
		try
		{	    
		     UserBean user = new UserBean();
		   
		     user.setEmail(request.getParameter("email"));
		     user.setPassword(request.getParameter("password"));
		    // PrintWriter out = response.getWriter();
		     user = UserDAO.login(user);
		     HttpSession session=request.getSession(true); 
		     //request.removeAttribute("loginuser");
		     //if(session!=null)
		    // {
		     if (user.isValid())
		     {
		    	if(!user.getStatus().equals("Active"))	 {
		    		request.getRequestDispatcher("notactive.html").forward(request, response);
		    		return;
		    	}
		    	
		    	 
		          request.setAttribute("Uname", user.getFirstName());
		         
		          ArrayList<String> facilityArr= new FacilityDAO().getMultipleFacility(user.getEmail());
		          System.out.println(session);
		          session.setAttribute("multiFacility", facilityArr);
		          
		          if(user.getRole().equals("Admin"))
		          {		          
		        	  
		          //response.sendRedirect("admin"); //logged-in page
		        	  request.setAttribute("name", new Message("successfully logged in", true));
		        	//  session.setAttribute("invalid", invalid);
		        	  session.setAttribute("user", user);
		        	  
			    	  request.getRequestDispatcher("admin").include(request, response);
			      }
			      else			    	  
			      {
			    	//  session.setAttribute("invalid", invalid);
			    	  session.setAttribute("user", user);
			    	  if(user.isFirstLogin()){
			    		  request.setAttribute("firstlogin", user.isFirstLogin());
			    		 // request.setAttribute("email", user.getEmail());
			    		  
			    		  request.getRequestDispatcher("changepassword.jsp").forward(request, response);
			    		  return;
			    	  }
			    	
			    	   request.setAttribute("name", new Message("successfully logged in", true));
			    	  request.getRequestDispatcher("clerk.jsp").include(request, response);
			    	  
			      }
		     }
			        
		     else {
		    	// invalid = true;
		    	// session.setAttribute("invalid", true);
		    	 //request.setAttribute("loginuser", 1);
		    	 request.setAttribute("name", new Message("Invalid login details", true));
		    	 // messages.put("form-username", "Please enter foo");
		          request.getRequestDispatcher("/login.jsp").include(request, response);
		     }
		     
		    /* else{
		    	 out.print("Please login first");  
		            request.getRequestDispatcher("index.html").include(request, response); 
		     }*/
		} 
				
				
		catch (Throwable theException) 	    
		{
		     System.out.println(theException); 
		}
		    
			

	}
	

}
