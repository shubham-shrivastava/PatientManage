<%@page import="com.psl.model.UserBean"%>
<%@ page language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">




<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">

<!-- DataTables CSS -->
<link href="vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<!-- Custom Fonts -->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- <style type="text/css">
	.bgimg {
    background-image: url('2.jpg');
    min-height: 100%;
    background-position: center top;
    background-size: cover;   
     background-repeat: no-repeat;
}

</style>
 -->

<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet" href="css/bootstrap.min.css">


<link rel="stylesheet" href="assets/css/animate.css">
<!-- <link rel="stylesheet" href="assets/css/style.css"> -->

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



</head>

</head>
<body>
	<div class="top-content">
		<%
    	UserBean user = (UserBean)session.getAttribute("user");
    	String home = null;
    	String facilitytab = null;
    	if(user.getRole().equals("Admin")){
    		home = "admin";
    		facilitytab = "FacilityUpload.do";
    	}
    	else if(user.getRole().equals("Clerk")){
    		home = "clerk.jsp";
    		facilitytab = "FacilityUpload.do";
    	}
    %>

		<nav class="navbar navbar-default" style="background-color: #e3f2fd;">
		<div class="container-fluid ">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href=<%=home %>>PatientAid</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav ">
					<li><a href="Patients.do"><i class="active glyphicon glyphicon-home"></i>
							Patient</a></li>
					<li><a href=<%=facilitytab %>><i
							class="glyphicon glyphicon-lock"></i> Facility</a></li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<button class="navbar-btn btn btn-default dropdown-toggle "
							data-toggle="dropdown">
							<i class="glyphicon glyphicon-user"></i><span> <%=user.getFirstName() %></span>
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a href="profile.jsp">Profile</a></li>
							<li class="divider"></li>
							<li><a href="logout.do">Logout</a></li>
						</ul>
					</li>
				</ul>

			</div>
		</div>
		</nav>




		<!-- jQuery -->
		<script src="vendor/jquery/jquery.min.js"></script> 

		<!-- Bootstrap Core JavaScript -->
		<script src="vendor/bootstrap/js/bootstrap.min.js"></script>


		<!-- DataTables JavaScript -->
		
		
		<script src="assets/js/wow.min.js"></script>

		<script src="assets/js/scripts.js"></script>
		<!-- <script src="dist/js/sb-admin-2.js"></script> -->
		
		<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="assets/js/jquery.backstretch.min.js"></script>
<script src="vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script src="vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script src="vendor/datatables-responsive/dataTables.responsive.js"></script>
	</div>
</body>
</html>