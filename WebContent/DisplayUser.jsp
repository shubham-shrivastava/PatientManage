
<%@page import="java.sql.*"%>
<%@include file="header.jsp"%>
<%@page
	import="com.psl.dao.ConnectionManager, com.psl.model.UserBean, java.util.ArrayList, com.psl.model.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
UserBean userBean1 = (UserBean)session.getAttribute("user");
if (userBean1.getFirstName() == null) {
   request.setAttribute("Error", "Session has ended.  Please login.");
   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
   rd.forward(request, response);
}
%>


<html>
<head>
<title>Admin Data</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>


<body>

	<% Message message= (Message)request.getAttribute("name");
		

if(message!=null)
{
	
%>
	<div class="alert alert-<%=message.isSuccessful()?"success":"danger"%>"
		id="myalert">
		<strong><%=message.getMsg() %></strong>
	</div>
	<%} %>
	<script>
	$("#myalert").fadeTo(2000, 500).slideUp(500, function(){
	    $("#myalert").slideUp(500);
	});
	</script>
	
	<%
	Connection conn = ConnectionManager.getConnection();
	String query = "select distinct(userlogin.Firstname), Facility.Name from userlogin left join user_facility_mapping "+
			"on userlogin.id = user_facility_mapping.userId left join Facility on Facility.id = user_facility_mapping.facilityId"
	+" where Facility.Name is not null";
	Statement stmt = conn.createStatement();
	
	%>
	
	<div class="container">
		<form class="form-horizontal" role="form" method="post" name="myform">
			<br> <button value="Add New User"
				class="btn btn-primary btn-lg pull-right"
				style="position: relative;"
				onclick="javascript: form.action='registration.jsp';" >Add New User</button> <br>
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

												<th>Name</th>
												<th>Email</th>
												<th>Facility</th>
												<th>Role</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody>
											<%
							ArrayList<UserBean> userBeanList = (ArrayList<UserBean>)request.getAttribute("UserList");

							for (UserBean userBean :userBeanList ) {
								
						%>

											<tr>

												<td><%=userBean.getFirstName()%> <%=userBean.getLastName()%></td>
												
								 				<td><%=userBean.getEmail()%></td>
													<td><%
													String name = userBean.getFirstName();
													ResultSet rset = stmt.executeQuery(query);
													while(rset.next()){
														String dbname = rset.getString("FirstName");
														System.out.println(name);
														if(dbname.equals(name)){													
														%>													
												<%=rset.getString("Name") %>
												<%}
														
														}%></td>
												
												<td><%=userBean.getRole()%></td>
												<td>
													<div class="checkbox">
														<%
										String status, val;
											if (userBean.getStatus().equals("Active")) {
												status = "De-Activate";
												val = "Deactive";
											} else {
												status = "Activate";
												val = "Active";
											}
									%>

														<label><input type="checkbox" name="status[]"
															<%=userBean.getFirstName().equals(user.getFirstName()) ? "disabled='disabled'" : ""%>
															id="checked1" value="<%=userBean.getId()%> <%=val%>"><%=status%></label>



													</div>

												</td>

											</tr>
											<%
							}
						%>
										</tbody>

									</table>
									<!-- /.table-responsive -->

									<script type="text/javascript">
                            $(document).ready(function(){
                            	//$('#update').disabled=true;
                            	document.getElementById("update").disabled = true;

                                $('input[type="checkbox"]').click(function(){
                                    if($("[name='status[]']:checked").length > 0){
                                    	document.getElementById("update").disabled = false;
                                        //$('#update').show();
                                    }
                                    else if($("[name='status[]']:checked").length==0){
                                    	//$('#update').hide();
                                    	//alert($("[name='status[]']:checked").length);
                                    	document.getElementById("update").disabled = true;

                                    }
                                    
                                });
                            });
								</script>

									<input type="submit" id="update" value="Update"
										class="btn btn-success pull-right"
										onclick="javascript: form.action='updated.do';">

								</div>
								<!-- /.panel-body -->
							</div>
							<!-- /.panel -->


						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	
	<script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
    </script>
</body>

</html>