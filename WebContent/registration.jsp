<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<%@page import="com.psl.dao.ConnectionManager"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
UserBean userBean = (UserBean)session.getAttribute("user");
if (userBean.getFirstName() == null) {
   request.setAttribute("Error", "Session has ended.  Please login.");
   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
   rd.forward(request, response);
}
%>
<html>
<head>
<title>Register New User</title>



<!-- CSS -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway:400,700">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="newstyle.css">
<link rel="stylesheet" href="style.css">

  <link rel="stylesheet" href="chosen.min.css">
  <style type="text/css" media="all">
    /* fix rtl for demo */
    .chosen-rtl .chosen-drop { left: -9000px; }
  </style>



</head>
<body>
	<%
	Statement stmt = null;
	Connection conn = ConnectionManager.getConnection();
	String query = "select distinct(Name) from Facility";
	String query1 = "select count(distinct(Name)) from Facility";
	stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(query1);
    int size = 0;
    while(rs.next()){
    	size = rs.getInt(1);
    }
    System.out.println(size);
    rs = stmt.executeQuery(query);
    String[] array = new String[size];
    StringBuilder names= new StringBuilder();
    int i = 0;
   /*   while(rs.next() && i<size){
    	names.append(rs.getString("Name"));
    	array[i] = rs.getString("Name");
    	i++;
    } 
    for(int j = 0; j<array.length; j++){
    	System.out.println(array[j]);
    }
    System.out.println(names); */
	%>


	<div class="inner-bg">
		<div class="container">
			<div class="col-sm-5 form-box"
				style="margin-left: 30%; margin-top: 0%">
				<div class="form-top">
					<div class="form-top-left">
						<h3>Ragister New User</h3>
						<p>Role can be Admin or Clerk</p>
					</div>
					<div class="form-top-right">
						<i class="fa fa-pencil"></i>
					</div>
				</div>



				<div class="form-bottom">
					<form class="form-horizontal" role="form" action="register.do"
						method="post">
						<div class="form-group">
							<label class="sr-only" for="firstname">First name</label> <input
								type="text" required name="firstName"
								placeholder="First name..."
								class="r-form-1-first-name form-control"
								id="r-form-1-first-name">
						</div>
						<div class="form-group">
							<label class="sr-only " for="lastname">Last name</label> <input
								type="text" required name="lastName" placeholder="Last name..."
								class="r-form-1-last-name form-control" id="r-form-1-last-name">
						</div>
						<div class="form-group">
							<label class="sr-only" for="email">Email</label> <input
								type="email" required name="email" placeholder="Email..."
								class="r-form-1-email form-control" id="r-form-1-email">
						</div>
						 <div class="form-group">
						 <label for="Facility Name" class="sr-only control-label">Facility
								Name</label>
							 <select multiple name="FacilityName" required
								data-placeholder="Facility..."
								class="r-form-1-last-name form-control chosen-select col-sm-10"
								id="r-form-1-facility" style="position: relative;">
								<%
								 while(rs.next() && i<size){%>
								 <option><%= rs.getString("Name")%></option>
								    	<% 
								    }
								%>
							</select>

						</div>
						<!-- <div class="form-group">
							<label for="Facility Name" class="sr-only control-label">Facility
								Name</label> <select multiple name="FacilityName" required
								placeholder="Facility..."
								class="Input r-form-1-facility form-control"
								id="facility">
								<option value="" disabled selected style="color: #999">Select
									Facility</option>
							</select>

						</div> -->

						<div class="form-group">


							<label class="sr-only" for="role">User Role</label> <select
								id="role" class="form-control r-form-1-role" name="role"
								placeholder="Facility...">
								<option value="Admin">Admin</option>
								<option value="Clerk">Clerk</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" style="color: gainsboro">Status</label>


							<label class="radio-inline" style="color: gainsboro"> <input
								type="radio" id="ActiveRadio" value="Active" name="activation"
								style="color: gainsboro" checked>Active

							</label> <label class="radio-inline" style="color: gainsboro"> <input
								type="radio" id="De-activeRadio" value="Deactive"
								name="activation">De-Active
							</label>


						</div>




						<center>
							<button type="submit" class="btn btn-success">Add User</button>
						</center>
					</form>
				</div>

			</div>
		</div>



	</div>



	<%-- <script>
	$( function() { 
	    var availableTags = new Array();
	    var length1 = <%=array.length %>;
	    
	    <%
	   for(i = 0; i < array.length; i++){
		   
		   %>
		   availableTags[[<%= i %>]] = '<%=array[i] %>';
	 <%   }%>    

 
  console.log();
    $( "#tags" ).autocomplete({
      source: availableTags
    });
  } );
	
function check(){
	var data = document.getElementById("tags").value;     
	alert(data);
}
  </script> --%>

	<%-- <script>
  $( function() { 
	    var availableTags = new Array();
	    var length1 = <%=array.length %>;
	    
	    <%
	   for(i = 0; i < array.length; i++){
		   
		   %>    
		   $('.Input').append('<option>' + '<%=array[i]%>'  + '</option>');	
  <%   }%>
  });
  	</script> --%>
  <script src="js/chosen.jquery.min.js" type="text/javascript"></script>

  <script type="text/javascript">
    var config = {
      '.chosen-select'           : {},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:10},
      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
      '.chosen-select-width'     : {width:"100%"}
    }
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
  </script> 
 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</body>
</html>