<%@page import="com.psl.model.Patient"%>
<%@include file="header.jsp" %>
<%@page import="com.psl.dao.ConnectionManager, com.psl.model.UserBean, java.util.ArrayList, com.psl.model.Message"%>
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
<title>Patient Data</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

 
  


</head>
<body>
	
	<script>
	$("#myalert").fadeTo(2000, 500).slideUp(500, function(){
	    $("#myalert").slideUp(500);
	});
	</script>
	<div class="container">
	<form class="form-horizontal" role="form" method="post" action="<%=home%>">
		<br>
		
		
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
									<thead>
										<tr>
										<th>Account No.</th>
											<th>Name</th>
											<th>Facility</th>
											<th>Admit Date</th>
											<th>Discharge Date</th>
										
										</tr>
									</thead>
									<tbody>
										<%
											ArrayList<Patient> arr = (ArrayList<Patient>)request.getAttribute("PatientList");
											
											for(Patient u : arr) {
												System.out.println("patient "+u);
									%>
										<tr>
										<td><a href="PatientInfo.jsp"><%=u.getAccNo() %></a></td>
											<td><%=u.getFirstName()%> <%=u.getLastName()%></td>
											<td><%=u.getFacility()%></td>
											<td><%=u.getAdmitDate()%></td>
											<td class="center"><%=u.getDischargeDate()%></td>
											
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<center><button type="button" class="btn btn-danger" onclick="cancel()">Back</button></center>
	</form>
	</div>
	<script type="text/javascript">
	function cancel(){
		window.history.back();
	}
</script>
<script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
    </script>
</body>
</html>