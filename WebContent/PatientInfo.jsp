<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<%@ page import="com.psl.model.Message"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.3.6/css/fileinput.min.css"
	media="all" rel="stylesheet" type="text/css" />
<!-- <script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->

<style type="text/css">
.bgimg {
	background: url('2.jpg') no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
<link rel="stylesheet" href="newstyle.css">
<!-- the main fileinput plugin file -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.3.6/js/fileinput.min.js"></script>
<!-- bootstrap.js below is needed if you wish to zoom and view file content 
     in a larger detailed modal dialog -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" type="text/javascript"></script>
 -->
<!-- optionally if you need a theme like font awesome theme you can include 
    it as mentioned below -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.3.6/js/locales/fa.js"></script>




<title>Clerk Dashboard</title>
</head>
<body class="bgimg">


	<div class="" id="loginModal">

		<div class="modal-body"
			style="margin-left: 20%; margin-right: 20%; margin-top: 0%">
			<div class="container-fluid">
				<div class="well">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#login" data-toggle="tab">Upload</a></li>
						<li><a href="#create" data-toggle="tab">Fill Details
								Manually</a></li>
					</ul>
				</div>
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane active in" id="login">

						<center>
							<form id="tab" action="facilityUpload.do" method="post"
								enctype="multipart/form-data">
								<div>
									<label class="control-label" style="color: white;">Upload
										Facility Data</label> <br>
									<br>
									<br> <input id="input-7" name="input7[]" type="file"
										multiple class="file-loading col-sm-5" accept=".csv">
								</div>
							</form>
						</center>
					</div>

					<div class="tab-pane fade" id="create">

						<div class="container">
							<div class="col-sm-5 form-box"
								style="margin-left: 10%;
	/* box-shadow: 1px -2px black; */ background-color: rgb(78, 78, 78); text-shadow: 0px 0px black; background-color: rgba(85, 85, 85, 0.24);">
								<div class="form-top">
									<div class="form-top-left">
										<h3>Add New Facility</h3>
										<p>You can also upload .csv file by clicking upload tab.</p>
									</div>
									<div class="form-top-right">
										<i class="fa fa-pencil"></i>
									</div>
								</div>



								<div class="form-bottom">
									<form class="form-horizontal" role="form" action="FacilityUpload.do"
										method="post">
										<div class="form-group">
											<label class="sr-only" for="name">Name</label> <input
												type="text" required name="firstName" placeholder="Name"
												class="r-form-1-first-name form-control"
												id="r-form-1-first-name">
										</div>
										<div class="form-group">
											<label class="sr-only " for="address">Address</label> <input
												type="text" required name="address" placeholder="Address"
												class="r-form-1-last-name form-control"
												id="r-form-1-last-name">
										</div>
										<div class="form-group">
											<label class="sr-only" for="city">City</label> <input
												type="text" required name="city" placeholder="City"
												class="r-form-1-email form-control" id="r-form-1-email">
										</div>
										<div class="form-group">
											<label for="state" class="sr-only control-label">State</label>

											<input type="text" name="state" required placeholder="State"
												class="r-form-1-facility form-control"
												id="r-form-1-facility">

										</div>
										<div class="form-group">
											<label for="zip" class="sr-only control-label">zipcode</label>

											<input type="text" name="zipcode" required
												placeholder="Zipcode" class="r-form-1-facility form-control"
												id="r-form-1-facility">

										</div>





										<%session.setAttribute("newFacility", "true"); %>

										<center>
											<button type="submit" id="updateFacility" class="btn btn-success" >Add
												Facility</button>
										</center>
									</form>
								</div>

							</div>
						</div>






					</div>
				</div>

			</div>
		</div>
	</div>
	<script>
$(document).on('ready', function() {
    $("#input-7").fileinput({
        showUpload: true,
        maxFileCount: 1,
        uploadurl: "",
        allowedFileExtensions: ["csv"],
        maxFilePreviewSize: 1024,
        browseOnZoneClick: true
    });
});
</script>
</body>
</html>