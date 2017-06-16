<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Upload Data</title>





<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">-->
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

</head>
<body class="bgimg img-responsive">


	<br>
	<br>
	<form action="upload.do" method="post" enctype="multipart/form-data">
		<center>
			<div class="col-sm-5" style="margin-top: 0%; margin-left: 30%">
				<label class="control-label" style="color: gainsboro">Upload
					Patient Data</label> <input id="input-7" name="input7[]" type="file"
					multiple class="file-loading col-sm-5" accept=".csv">
			</div>
		</center>
	</form>
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