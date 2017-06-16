<%@page import="com.psl.model.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Patient</title>

<!-- CSS -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/form-elements.css">
<link rel="stylesheet" href="assets/css/style.css">


</head>

<body>

	<%  Message message= (Message)request.getAttribute("name");
if(message!=null)
{
	
%>

	<div
		class="alert alert-<%=message.isSuccessful()?"success":"danger" %> role="
		alert"
		id="myalert">
		<strong><%=message.getMsg() %></strong>

	</div>
	<%} %>



	<div class="top-content">
		<div class="inner-bg">
			<div class="container">
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2 text">
						<h1>
							<strong>My Patient</strong> Login
						</h1>
						<div class="description"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							<div class="form-top-left">
								<h3>Login to our site</h3>
								<p>Enter your username and password to log on:</p>
							</div>
							<div class="form-top-right">
								<i class="fa fa-lock"></i>
							</div>
						</div>
						<div class="form-bottom">
							<form action="login.do" method="post" class="login-form">
								<div class="form-group">
									<input type="text" name="email" placeholder="E-mail"
										class="form-username form-control" id="form-username">
								</div>

								<div class="form-group">
									<input type="password" name="password" placeholder="Password"
										class="form-password form-control" id="form-password">
								</div>

								<button type="submit" class="btn" id="login">Sign in!</button>

							</form>
						</div>
					</div>
				</div>

			</div>
		</div>

	</div>


	<%--         <%
if(null!=session.getAttribute("invalid")){
	out.println("invalid details");
%>
<script>
var login = document.getElementById("login");
login.setCustomValidity("Invalid details!");
</script>
<%
session.removeAttribute("invalid");
}
%> --%>


	<!-- Javascript -->
	<script src="assets/js/jquery-1.11.1.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.backstretch.min.js"></script>
	<script src="assets/js/scripts.js"></script>
	<script>
	$("#myalert").fadeTo(2000, 500).slideUp(500, function(){
	    $("#myalert").slideUp(500);
	});
</script>

</body>
</html>