<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.psl.dao.ConnectionManager"%>
<%@include file="header.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.psl.model.Message"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
UserBean userBean = (UserBean)session.getAttribute("user");
ArrayList<String> multiFacility=(ArrayList<String>)session.getAttribute("multiFacility");
if (userBean.getFirstName() == null) {
   request.setAttribute("Error", "Session has ended.  Please login.");
   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
   rd.forward(request, response);
}
%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">


<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>







<title>Clerk Dashboard</title>
</head>
<body>


	<% Message message= (Message)request.getAttribute("name");
if(message!=null)
{
	
%>
	<div
		class="alert alert-<%=message.isSuccessful()?"success":"danger" %> role="
		alert"
		id="myalert">
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<strong><%=message.getMsg() %></strong>
	</div>
	<%
		message = null;	
} %>
	<script>
	$("#myalert").fadeTo(2000, 500).slideUp(500, function(){
	    $("#myalert").slideUp(500);
	});
	</script>
	<div class="bgimg container">
		<form class="form-horizontal" action="showdata.jsp">
			<div class="container">
				<div class="form-group">
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>

					<div class="col-md-3">
						<input class="form-control" id="fname" type="text"
							placeholder="First Name" name="firstname">
					</div>
					<div class="col-md-2">
						<input class="form-control" id="lname" type="text"
							placeholder="Last Name" name="lastname">
					</div>
					<div class="col-md-2">
						<input class="form-control" id="facility" type="text"
							placeholder="Facility" name="facility">
					</div>

					<div class="col-md-2">
						<input class="form-control" type="text"
							placeholder="Date of Admit" onchange="checkDate()" value=""
							name="dateofadmit" id="admit">
					</div>



					<div class="col-md-2">
						<input class="form-control" type="text"
							placeholder="Date of Discharge" value="" onchange="checkDate()"
							id="discharge" name="dateofdischarge">
					</div>
					<!-- <p class="col-md-2">Date: <input type="text" id="datepicker"></p> -->
				</div>

				<!-- <input class="form-control" type="reset" value="Reset"> -->
			</div>
<input type="hidden" id="orgfacility" >
			<br>
			<br>
			<div class="container">
				<div class="form-group">
					<div class="col-md-2"></div>
					<div class="col-md-2">

						<input style="width: 80%" class="btn btn-success " type="submit"
							onclick="validateLength()" class="" value="Search" name="Search"
							id="search">
					</div>
					<div class="col-md-2">
						<input style="width: 80%" class="btn btn-info btn-md"
							type="button" onclick="redirect()" value="Load">
					</div>

					<div class="col-md-2">
						<input style="width: 80%" class="btn btn-warning btn-md"
							type="button" onclick="del()" value="Delete">
					</div>
					<div class="col-md-2">
						<input style="width: 80%" class="btn btn-danger btn-md"
							type="reset" value="Clear">
					</div>
					<div class="col-md-2"></div>
				</div>
			</div>
		</form>
	</div>

	<script>
					
	
  $( function() {
    $( "#admit" ).datepicker({
    	dateFormat: 'yy-mm-dd' ,
    		changeMonth: true,
            changeYear: true,
            firstDay: 1,
            minDate: Date.parse("1900-01-01"),
            maxDate: Date.parse("2100-01-01"),
            yearRange: "c-90:c+150"   	
    
    });

    
    $( "#discharge" ).datepicker({
    	dateFormat: 'yy-mm-dd' ,
    		changeMonth: true,
            changeYear: true,
            firstDay: 1,
            minDate: Date.parse("1900-01-01"),
            maxDate: Date.parse("2100-01-01"),
            yearRange: "c-90:c+150"   	
    
    });
  } ); 
  
   
	
	function checkDate(){
		var admit = document.getElementById("admit");
		var discharge = document.getElementById("discharge");
		 if(!ValidateDate(admit.value)){
            admit.setCustomValidity("Please enter correct date format. ");
          } else {
            admit.setCustomValidity('');
          }
		 
		 if(!ValidateDate(discharge.value)){
            discharge.setCustomValidity("Please enter correct date format. ");
          } else {
            discharge.setCustomValidity('');
          }
	} 
  
  function ValidateDate(dtValue)  {
     
 		var patt = new RegExp(/^(20\d\d-(01|02|03|04|05|06|07|08|09|10|11|12)-(0[1-9]|[12][0-9]|3[01]))?$/);
  		 var res = patt.test(dtValue);
         return res;
   
  }

  </script>


	<script type="text/javascript">
	function redirect(){
		window.location="Uploader.jsp"
	}
</script>
	<script type="text/javascript">
	function del(){
		window.location="delete.do"
	}
</script>

	<script type="text/javascript">

var fname = document.getElementById("fname")
  , lname = document.getElementById("lname"),
  	facility = document.getElementById("facility"),
  	admit = document.getElementById("admit"),
  	discharge = document.getElementById("discharge"),
  	button = document.getElementById("search");

function validateLength(){
  if(fname.value.length === 0 && lname.value.length === 0 && facility.value.length === 0 && admit.value.length === 0 && discharge.value.length === 0) {
    button.setCustomValidity("Please enter atleast one field. ");
  } else {
    button.setCustomValidity('');
  }
}
 
/* fname.onchange = validatePassword;
lname.onkeyup = validatePassword; */
</script>
<!-- 
<script type="text/javascript">
function checkfaci(){
	var facility = document.getElementById("facility");
	var f=document.getElementById("orgfacility");
	 if(f.value!=facility.value)
	 {
		 button.setCustomValidity("you are not allowed to see these facility patients. ");
	 }
	 else {
		    button.setCustomValidity('');
		  }
	 }
</script>
 -->
</body>
</html>