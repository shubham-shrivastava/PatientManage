<%-- <%@page import="com.mysql.jdbc.StringUtils"%> --%>
<%@page import="com.psl.dao.ConnectionManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%@ page import="java.sql.*"%>
<%Class.forName("com.mysql.jdbc.Driver"); %>

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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Details</title>








</head>

<body class="bgimg">

	<br>
	<br>
	<br>
	<br>
	<%!

public void setNullOrString(PreparedStatement p,int index, String column) throws SQLException{
	if(column.equals("")){		
		p.setNull(index, Types.VARCHAR, column);
	}
	else{
		p.setString(index, column);
	}
}

public void setNullOrDate(PreparedStatement p,int index, String column) throws SQLException{
	if(column.equals("")){		
		p.setNull(index, Types.DATE, column);
	}
	else{
		Date d = Date.valueOf(column);
		p.setDate(index, d);
	}
}

%>

	<% 
String firstname=request.getParameter("firstname"); 
String lastname=request.getParameter("lastname"); 
System.out.println(firstname);
String facility=request.getParameter("facility"); 

String dateofadmit=request.getParameter("dateofadmit"); 
String dateofdischarge=request.getParameter("dateofdischarge"); 
System.out.println(dateofadmit);
Connection conn = ConnectionManager.getConnection();
String searchquery = "  SELECT * FROM patient "+
 "WHERE firstname = COALESCE(?,firstname) " 
+" and lastname = COALESCE(?,lastname)"+
" and facility = COALESCE(?,facility)" +
" and admitdate = COALESCE(?,admitdate)"+
" and dischargedate =  COALESCE(?,dischargedate)"; 




PreparedStatement preparedStatement =conn.prepareStatement(searchquery);
setNullOrString(preparedStatement, 1, firstname);
setNullOrString(preparedStatement, 2, lastname);
if( (!facility.isEmpty()) && !multiFacility.contains(facility))
{
	setNullOrString(preparedStatement, 3, "-1");
}
else
{
setNullOrString(preparedStatement, 3, facility);
}
setNullOrDate(preparedStatement, 4, dateofadmit);
setNullOrDate(preparedStatement, 5, dateofdischarge);
//preparedStatement.setDate(4, admitdate);
//preparedStatement.setDate(5, dischargeDate);
System.out.println(preparedStatement);
ResultSet rSet = preparedStatement.executeQuery();%>


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
										<strong>Patient Details</strong>
									</caption>
									<thead>
										<tr>
											<th>Firstname</th>
											<th>Lastname</th>
											<th>Facility</th>
											<th>Admit Date</th>
											<th>Discharge Date</th>
										</tr>
									</thead>
									<%  
										while(rSet.next()){
									%>
									<tbody>
										<tr>
											<td><%=rSet.getString("firstname") %></td>
											<td><%=rSet.getString("lastname") %></td>
											<td><%=rSet.getString("facility") %></td>
											<td class="center"><%=rSet.getString("admitdate") %></td>
											<td class="center"><%=rSet.getString("dischargedate")%></td>
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
	</div>
	<script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
</script>

</body>
</html>