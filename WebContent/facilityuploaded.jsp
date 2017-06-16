<%@page import="com.psl.model.Facility"%>
<%@page import="com.psl.dao.PatientDAO"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Successfully Uploaded</title>






</head>
<body>
	<br>
	<br>
	<br>
	<br>


	<div class="container">
		<div id="wrapper">
			<div id="page-wrapper">
				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">

							<!-- /.panel-heading -->
							<div class="panel-body">
								<table width="100%"
									class="table table-striped table-bordered table-hover"
									id="dataTables-example">
									<caption style="text-align: center; font-size: 30px">
										<strong>Uploaded Details</strong>
									</caption>
									<%
											BufferedReader reader = (BufferedReader)request.getAttribute("Reader");
											StringBuilder output = new StringBuilder();
											String line;
											%>
									<thead>
										<tr style="background-color: #99CCFF">

											<th>Name</th>
											<th>Address</th>
											<th>City</th>
											<th>State</th>
											<th>Zip Code</th>
										</tr>
									</thead>
									<tbody>
										<%
										while ((line = reader.readLine()) != null)
										{											
										String data[] = line.split(",");
									%>
										<tr>
											<%
									for(int j=0;j<data.length;j++)
									 {
										out.print("<td> " +data[j]+ "</td> ");							 
									} 
										%>
										</tr>
										<%
											} 
									
									 	%>

									</tbody>
								</table>
								<script type="text/javascript">
							
							    $(document).ready(function() {
							        $('#dataTables-example').DataTable({
							            responsive: true
							        });
							    });
							    </script>


							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>