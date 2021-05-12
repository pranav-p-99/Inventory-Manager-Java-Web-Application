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
<%@ page
	import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException,java.time.LocalDate,java.time.temporal.ChronoUnit"%>

<%@page import="java.sql.*,java.util.*"%>

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
					<li><a href="orders.jsp">ORDERS</a></li>
					<li><a href="login.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Logout">logout</i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!--Side NavBar-->
	<ul class="side-nav grey lighten-1" id="mobile-nav">
		<li><a href="admin.jsp">Home</a></li>
		<li><a href="listadmin.jsp">Products</a></li>
		<li><a href="dashboard.jsp">Dashboard</a></li>
		<li><a href="orders.jsp">Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Products Section-->
	<section class="section section-update">
		<div class="container">
			<div class="row">

				<!--New Products-->
				<div class="col s12 m6 offset-m3 l4 pull-l1">
					<div class="card grey lighten-3 box">
						<div class="card-action grey darken-4 ">
							<h5 class="grey-text text-lighten-2 center" style="font-size:20px;"><i class="fas fa-boxes left"></i>PRODUCT<i class="fas fa-boxes right"></i></h5>
						</div>
						<form action="<%= request.getContextPath() %>/AddProductsServlet" method="POST">
							<div class="card-content">
								<div class="input-field">
									<i class="fas fa-cookie-bite prefix"></i> <input type="text"
										id="productname" name="productname"
										class="grey-text lighten-1" required /> <label
										for="productname" class="grey-text lighten-1">Product
										Name</label>
								</div>

								<div class="input-field">
									<i class="fas fa-weight prefix"></i> <input type="number"
										id="quantity" name="quantity" class="grey-text lighten-1"
										required /> <label for="quantity" class="grey-text lighten-1">Quantity</label>
								</div>

								<div class="input-field">
									<i class="fas fa-question-circle prefix"></i> <input
										type="text" id="type" name="type" class="grey-text lighten-1"
										required /> <label for="type" class="grey-text lighten-1">Edible?</label>
								</div>


								<div class="input-field">
									<i class="far fa-calendar-times prefix"></i> <input type="date" id="date" name="date" class="grey-text lighten-1" />
								</div>
								
								<div class="input-field">
									<i class="fas fa-tags prefix"></i> <input type="number" step=0.01 id="price" name="price" class="grey-text lighten-1" />
									<label
										for="price" class="grey-text lighten-1">Price Per Item</label>
								</div>

								<div class="input-field center">
									<input type="submit" id="submit" value="ADD PRODUCT"
										name="submit"
										class="btn btn-small btn-extended blue darken-4 white-text waves-effect waves-light">

								</div>
								<br>
							</div>
						</form>
					</div>
				</div>

				<!--View-->
				<div class="col s12 m10 offset-m1 l8">
					<div class="card-panel grey lighten-1 center box">

						<table class="centered striped" id="myTable">
							<thead class="grey">
								<tr>
									<th>PRODUCT</th>
									<th>QUANTITY</th>
									<th>EDIBLE?</th>
									<th>EXPIRY DATE</th>
									<th>PRICE PER UNIT (Rs.)</th>
									<th></th>
									
								</tr>
							</thead>
							<tbody>
						
							<%
								Connection con;
							PreparedStatement pst;
							ResultSet rs;

							Class.forName("com.mysql.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");

							String query = "select * from products where qty > 0";
							Statement st = con.createStatement();

							rs = st.executeQuery(query);

							while (rs.next()) {
								String id = rs.getString("id");
								String x = rs.getString("expdate");
								LocalDate date = LocalDate.parse(x);
								LocalDate today = LocalDate.now();
								if(date.compareTo(today) > 0){
							%>	
								<tbody>

								<tr>
									<td><%=rs.getString("pname")%></td>
									<td><%=rs.getString("qty")%></td>
									<td><%=rs.getString("edible")%></td>
									<td><%=rs.getString("expdate")%></td>
									<td><%=rs.getString("pricepu")%></td>
									<td><a href="produpdate.jsp?id=<%=id%>" class="tooltipped" data-tooltip="Edit Product"> <i
											class="material-icons green-text text-darken-3" style="font-weight:bold;">edit</i>
									    </a>
									    <a href="proddelete.jsp?id=<%=id%>" class="tooltipped" data-tooltip="Remove Product"> <i
											class="material-icons red-text text-darken-3" style="font-weight:bold;">close</i>
										</a>
										
									</td>
								</tr>

								<%
									}else{
								%>
								
								<tr class="red lighten-4">
									<td><%=rs.getString("pname")%></td>
									<td><%=rs.getString("qty")%></td>
									<td><%=rs.getString("edible")%></td>
									<td><%=rs.getString("expdate")%></td>
									<td><%=rs.getString("pricepu")%></td>
									<td><a href="produpdate.jsp?id=<%=id%>" class="tooltipped" data-tooltip="Edit Product"> <i
											class="material-icons green-text text-darken-3" style="font-weight:bold;">edit</i>
									    </a>
									    <a href="proddelete.jsp?id=<%=id%>" class="tooltipped" data-tooltip="Remove Product"> <i
											class="material-icons red-text text-darken-3" style="font-weight:bold;">close</i>
										</a>
										
									</td>
								</tr>
							</tbody>
								
								
								<%}} %>
								

						</table>
					</div>
				</div>

			</div>
		</div>
	</section>


	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="prodedit.jsp" class="brand-logo grey-text text-lighten-3"><i
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

			//Modal
			$('.modal').modal();
			
			
		});
	</script>
</body>

</html>