<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.psl.dao.ConnectionManager"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp"%>
<%@page import="com.psl.model.UserBean"%>
<%@ page language="java"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta charset="utf-8">
<title>My profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet"> -->
<style type="text/css">
.user-row {
	margin-bottom: 14px;
}

.user-row:last-child {
	margin-bottom: 0;
}

.dropdown-user {
	margin: 13px 0;
	padding: 5px;
	height: 100%;
}

.dropdown-user:hover {
	cursor: pointer;
}

.table-user-information>tbody>tr {
	border-top: 1px solid rgb(221, 221, 221);
}

.table-user-information>tbody>tr:first-child {
	border-top: 0;
}

.table-user-information>tbody>tr>td {
	border-top: 0;
}

.btn-info {
	width: 78px !important;
}

.btn-success {
	width: 78px !important;
}

input {
	border: 0;
	width: auto; /* 300px;*/
}


</style>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway:400,700">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="newstyle.css">
<link rel="stylesheet" href="style.css">

  <link rel="stylesheet" href="chosen.min.css">
  <style type="text/css" media="all">
    /* fix rtl for demo */
    .chosen-rtl .chosen-drop { left: -9000px; }
  </style>

</head>
<body>
	<br>
	<br>

	<div class="container">
		<form name="frm" method="post" action="" role="form">
			<div
				class="well col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xs-offset-2 col-sm-offset-2 col-md-offset-2 col-lg-offset-2">

				<%
    	user = (UserBean)session.getAttribute("user");
				ArrayList<String> multiFacility=(ArrayList<String>)session.getAttribute("multiFacility");
    %>
<%
	Connection conn = ConnectionManager.getConnection();
//	String query = "select distinct(userlogin.Firstname), Facility.Name from userlogin left join user_facility_mapping "+
	//		"on userlogin.id = user_facility_mapping.userId left join Facility on Facility.id = user_facility_mapping.facilityId"
//	+" where Facility.Name is not null";
	String fquery = "select distinct(Name) from Facility";
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(fquery);
	%>


				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Profile</h3>
					</div>
					<div class="panel-body">

						<div class="col-md-3 col-lg-3 hidden-xs hidden-sm">
							<img class="img-circle"
								src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100"
								alt="User Pic">
						</div>
						<div class="col-xs-2 col-sm-2 hidden-md hidden-lg">
							<img class="img-circle"
								src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=50"
								alt="User Pic">
						</div>
						<div class="container-fluid">
							<div class=" col-md-9 col-lg-9 col-xs-12  table-responsive">
								<strong><h2><%=user.getFirstName()%></h2></strong><br>
								<table class="table table-user-information col-sm-5">
									<input type="hidden" name="id" id="id"
										value="<%=user.getEmail()%>">

									<tr>
										<td>Name:</td>
										<td><input type="text" name="name" id="name"
											value="<%=user.getFirstName()%> <%=user.getLastName()%>"
											readonly="readonly"></td>
									</tr>

									<tr>
										<td>Email id:</td>
										<td><input type="text" name="email" id="email"
											value="<%=user.getEmail() %>" readonly="readonly"
											size="<%=user.getEmail().length()%>"></td>
									</tr>
									<tr>
										<td>Facility:</td>
										<%-- <%	String name = user.getFirstName();
													ResultSet rset = stmt.executeQuery(query);
													while(rset.next()){
														String dbname = rset.getString("FirstName");
														System.out.println(name);
														if(dbname.equals(name)){%> --%>
										<%-- <td><input type="text" name="facility" id="facility"
											value=<%
											for(String s:multiFacility)
											{%>										
												<%=s %>
											<%}
											%>
														
														
														
														 readonly="readonly"></td> --%>
														 <%String stb = "Hospital1 hospital2 hospital3"; %>
										<%StringBuffer stb1 = new StringBuffer();
										for(String s: multiFacility){
											stb1.append(s+" ");
										}
										%>
										<%-- <td><%for(String s: multiFacility){ %><input type="text" name="facility" id="facility"
											value= <%=s %>> <%} %></td> --%>
											
											<td id = "facility" style="display: run-in;"><input type="text" name="facility"  
											value= "<%=stb1.toString().trim() %>" size="<%=stb1.toString().trim().length() %>" readonly="readonly"></td>
										
										<td id="dropdown" style="visibility: hidden;"><select multiple name="FacilityName" 
								data-placeholder="Facility..."
								class="r-form-1-last-name form-control chosen-select col-sm-10 "
								id="r-form-1-facility"
								 >
								<%
								 while(rs.next()){%>
								 <option><%= rs.getString("Name")%></option>
								    	<% 
								    }
								%>
							</select>
											
							</td>
											
									</tr>
									<tr>
										<td>Role:</td>
										<td><input type="text" name="role" id="role"
											value="<%=user.getRole() %>" readonly="readonly"></td>
									</tr>
									<tr>
										<td>Status:</td>
										<td><input type="text" name="status" id="status"
											value="<%=user.getStatus() %>" readonly="readonly"></td>
									</tr>
								</table>

							</div>
						</div>
					</div>

					<div class="panel-footer" align="center">

						<input type="button" value="Edit" name="button1"
							class="btn btn-info" id="button1" onClick="enableDisable()">
						<input type="hidden" value="save" id="save"
							class="btn btn-success"
							onclick="javascript: form.action='ProfileController.do';" /> <a
							href="WannaChangePW.do"><button class="btn btn-warning"
								type="button">change password</button> </a> <a href=<%=home %>><button
								class="btn btn-sm btn-danger" type="button">
								<i class="glyphicon glyphicon-remove"></i>
							</button> </a>


					</div>
				</div>
			</div>
		</form>
	</div>



	<script>

function enableDisable()
{
var form = document.frm;
if(form.button1.value=="Edit")
{
	var name = document.getElementById("name");
	
form.name.readOnly = false;
document.getElementById("name").style.border='inset';
form.email.readOnly = false;
document.getElementById("email").style.border='inset';
form.facility.readOnly =false;
document.getElementById("facility").style.display="none";
//document.getElementById("dropdown").style.display="run-in";
document.getElementById("dropdown").style.visibility="visible";
document.getElementById("r_form_1_facility_chosen").style.width="100%";
var x = document.getElementById("button1");
x.type= "hidden";
var y = document.getElementById("save");
y.type= "submit";
document.getElementById("save").disabled = false;
}
}
</script>
<script src="js/chosen.jquery.min.js" type="text/javascript"></script>

  <script type="text/javascript">
    var config = {
      '.chosen-select'           : {},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:10},
      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
      '.chosen-select-width'     : {width:"100%"}
    }
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
  </script> 
 <!--  <script type="text/javascript">
 $( window ).load(function() {
	 document.getElementById("r-form-1-facility").visibility = "visible";
});
 </script>
 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</body>
</html>