
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.psl.dao.ConnectionManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = ConnectionManager.getConnection();
	String query = "select distinct(userlogin.Firstname), Facility.Name from userlogin left join user_facility_mapping "+
			"on userlogin.id = user_facility_mapping.userId left join Facility on Facility.id = user_facility_mapping.facilityId;";
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery(query);
	%>Shubham belongs to:     <% 
	while(rset.next()){
		String name = rset.getString("FirstName");
		if(name.equals("Shubham")){
				%>
		<em> <%=rset.getString("Name") %></em>
	<% }}
%>

</body>
</html>