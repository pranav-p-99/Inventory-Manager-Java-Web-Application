
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page
	import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException,java.time.LocalDate,java.time.temporal.ChronoUnit"%>

<!DOCTYPE html>
<html>

<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/26ff23e897.js"
	crossorigin="anonymous"></script>
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize.min.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet" href="css/main.css" />
<link type="text/css" rel="stylesheet" href="css/qurries.css" />



<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>:: E-MART :: INVENTORY MANAGER ::</title>
</head>

<body class="grey prod-body">
	<!--NavBar-->
	<nav class="blue darken-4">
		<div class="container">
			<div class="nav-wrapper">
				<a href="admin.jsp" class="brand-logo grey-text text-lighten-3"><i
					class="material-icons" style="font-size: 35px;">shopping_basket</i>Inv-Manager</a>
				<a href="#" data-activates="mobile-nav" class="button-collapse">
					<i class="material-icons grey-text text-lighten-5">menu</i>
				</a>
				<ul class="right hide-on-med-and-down">
					<li><a href="admin.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3 "
							style="font-size: 30px;" data-tooltip="Home">home</i></a></li>
					<li><a href="listadmin.jsp">PRODUCTS</a></li>
					<li><a href="dashboard.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3 "
							style="font-size: 30px;" data-tooltip="Dashboard">dashboard</i></a></li>
					<li class="active"><a href="orders.jsp">ORDERS</a></li>
					<li><a href="login.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Logout">logout</i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!--Side NavBar-->
	<ul class="side-nav grey lighten-1" id="mobile-nav">
		<li><a href="home.jsp">Home</a></li>
		<li><a href="listadmin.jsp">Products</a></li>
		<li><a href="dashboard.jsp">Dashboard</a></li>
		<li class="active"><a href="orders.jsp">Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!-- Section Alerts -->

	<section class="section section-update ord">
		<div class="container">
			<div class="row">
				<div class="col s12">
					<div class="card">
						<div
							class="card-action grey darken-4 grey-text text-lighten-2 center">
							<h5>
								<i class="material-icons left" style="font-size: xx-large;">add_alert</i>STOCK
								ALERTS<i class="material-icons right"
									style="font-size: xx-large;">add_alert</i>
							</h5>
						</div>
						<div class="card-tabs">
							<ul class="tabs tabs-fixed-width">
								<li class="tab grey"><a class="active tooltipped "
									href="#test4 " data-tooltip="Stock Expiration Status ">
										<h5>
											<i class="fas fa-calendar-times grey-text text-darken-4 "></i>
										</h5>
								</a></li>
								<li class="tab grey"><a href="#test5 " class="tooltipped "
									data-tooltip="Stock Quantity Status ">
										<h5>
											<i class="fas fa-battery-quarter grey-text text-darken-4 "></i>
										</h5>
								</a></li>
							</ul>
						</div>
						<div class="card-content grey lighten-1">
							<div id="test4">
								<div class="card">
									<div class="card-tabs">
										<ul class="tabs tabs-fixed-width">
											<li class="tab indigo darken-4"><a
												class="active tooltipped" href="#test6"
												data-tooltip="Approaching Expiration">
													<h5>
														<i
															class="fas fa-exclamation-circle grey-text text-lighten-1"></i>
													</h5>
											</a></li>
											<li class="tab indigo darken-4"><a href="#test7"
												class="tooltipped" data-tooltip="Expired">
													<h5>
														<i
															class="fas fa-skull-crossbones grey-text text-lighten-1"></i>
													</h5>
											</a>
											<li>
										</ul>
									</div>
									<div class="card-content grey lighten-2">
										<div id="test6">
											<table class="centered highlight">
												<thead class="grey lighten-1">
													<tr>
														<th>PRODUCT NAME</th>
														<th>EXPIRY DATE</th>
														<th>DAYS TO EXPIRY</th>
													</tr>
												</thead>

												<%
													Connection con1;
													PreparedStatement pst1;
													ResultSet rs1;
				
													Class.forName("com.mysql.jdbc.Driver");
													con1 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
													
													String query1 = "SELECT * FROM products WHERE expdate = DATE_ADD(CURDATE(), INTERVAL 3 DAY) or expdate = DATE_ADD(CURDATE(), INTERVAL 2 DAY) or expdate = DATE_ADD(CURDATE(), INTERVAL 1 DAY) ORDER BY expdate ASC";
													Statement st1 = con1.createStatement();
													
				
													rs1 = st1.executeQuery(query1);
													
				
													while (rs1.next()) {
														String x = rs1.getString("expdate");
														LocalDate date = LocalDate.parse(x);
														LocalDate today = LocalDate.now();
														long noOfDaysBetween = ChronoUnit.DAYS.between(today, date);
												%>

												<tbody>
													<tr>
														<td><%=rs1.getString("pname")%></td>
														<td><%=rs1.getString("expdate")%></td>
														<td><%=noOfDaysBetween%></td>
													</tr>
													<% } %>
												</tbody>
											</table>

										</div>
										<div id="test7">
											<table class="centered highlight">
												<thead class="grey lighten-1">
													<tr>
														<th>PRODUCT NAME</th>
														<th>EXPIRED DATE</th>

													</tr>

												</thead>
												<%
													Connection con2;
													PreparedStatement pst2;
													ResultSet rs2;
				
													Class.forName("com.mysql.jdbc.Driver");
													con2 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
													
													String query2 = "SELECT * FROM products WHERE expdate <= DATE(NOW()) ORDER BY expdate DESC";
													Statement st2 = con2.createStatement();
													
				
													rs2 = st2.executeQuery(query2);
													
				
													while (rs2.next()) {
														
												%>

												<tbody>
													<tr>
														<td><%= rs2.getString("pname") %></td>
														<td><%= rs2.getString("expdate") %></td>

													</tr>

													<% } %>
												</tbody>
											</table>

										</div>
									</div>
								</div>
							</div>
							<div id="test5">
								<div class="card">
									<div class="card-tabs">
										<ul class="tabs tabs-fixed-width">
											<li class="tab indigo darken-4"><a
												class="active tooltipped" href="#test8"
												data-tooltip="Less Stock">
													<h5>
														<i class="fas fa-star-half-alt grey-text text-lighten-1"></i>
													</h5>
											</a></li>
											<li class="tab indigo darken-4"><a href="#test9"
												class="tooltipped" data-tooltip="Out Of Stock">
													<h5>
														<i class="fas fa-ban grey-text text-lighten-1"></i>
													</h5>
											</a>
											<li>
										</ul>
									</div>
									<div class="card-content grey lighten-2">
										<div id="test8">
											<table class="centered highlight">
												<thead class="grey lighten-1">
													<tr>
														<th>PRODUCT NAME</th>
														<th>STOCK REMAINING</th>
													</tr>
												</thead>
												<%
													Connection con3;
													PreparedStatement pst3;
													ResultSet rs3;
				
													Class.forName("com.mysql.jdbc.Driver");
													con3 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
													
													String query3 = "SELECT * FROM products WHERE qty > 0 and qty <= 50 ORDER BY qty ASC";
													Statement st3 = con3.createStatement();
													
				
													rs3 = st3.executeQuery(query3);
													
				
													while (rs3.next()) {
														
												%>

												<tbody>
													<tr>
														<td><%=rs3.getString("pname") %></td>
														<td><%=rs3.getString("qty") %></td>
													</tr>
													<% } %>

												</tbody>
											</table>

										</div>
										<div id="test9">
											<table class="centered highlight">
												<thead class="grey lighten-1">
													<tr>
														<th>PRODUCT NAME</th>

													</tr>
												</thead>
												<%
													Connection con4;
													PreparedStatement pst4;
													ResultSet rs4;
				
													Class.forName("com.mysql.jdbc.Driver");
													con4 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
													
													String query4 = "SELECT * FROM products WHERE qty = 0";
													Statement st4 = con4.createStatement();
													
				
													rs4 = st4.executeQuery(query4);
													
				
													while (rs4.next()) {
														 String temp = rs4.getString("pname");
														 if(temp == null) break;
														 else{
														
												%>

												<tbody>
													<tr>
														<td><%= rs4.getString("pname") %></td>

													</tr>
													<% }} %>

												</tbody>
											</table>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>



	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="stockalert.jsp" class="brand-logo grey-text text-lighten-3"><i
			class="material-icons" style="font-size: 38px;">shopping_basket</i></span></a>
	</footer>

	<!--Import jQuery before materialize.js-->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>
	<script>
		$(document).ready(function() {

			//Side-Nav
			$(".button-collapse").sideNav();
			
						
		});
	</script>

</body>

</html>