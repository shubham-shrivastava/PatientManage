<%-- <%@page import="com.psl.model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="styles.css" />

</head>
<body>
	<%
	UserBean bean = (UserBean) session.getAttribute("user");
%>
	<form action="change.do" method="post">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-6 col-md-offset-3">
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								<span class="glyphicon glyphicon-th"></span> Hi
								<%=bean.getFirstName() %>! Please Change your password
							</h3>
						</div>
						<div class="panel-body">
							<div class="row">

								<div style="margin-top: 20px; margin-left: 25%"
									class="col-xs-6 col-sm-6 login-box">

									<div class="form-group">
										<div class="input-group">

											<input class="form-control" type="password"
												placeholder="New Password" id="password" required>


										</div>

										<div class="progress">
											<div class="progress-bar"></div>
										</div>
									</div>
									<div class="form-group">
										<div class="input-group">

											<input class="form-control" type="password"
												placeholder="Repeat Password" id="confirm_password">

										</div>
									</div>

								</div>
							</div>
						</div>
						<div class="panel-footer">
							<div class="row">
								<div class="col-xs-6 col-sm-6 col-md-4"></div>
								<div class="col-xs-6 col-sm-6 col-md-6">
									<button class="btn icon-btn-save btn-success" type="submit">
										<span class="btn-save-label"><i
											class="glyphicon glyphicon-floppy-disk"></i></span>save
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

	<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
	<script type="text/javascript" src="BootstrapPasswordStrengthMeter.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>

	<script type="text/javascript">
        $(document).ready(function(){
          $('#password').bootstrapPasswordStrengthMeter({
            minPasswordLength: 3
          });
        });
    </script>
</html> --%>