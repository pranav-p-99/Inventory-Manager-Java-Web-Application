
<%
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
String name = (String) session.getAttribute("email");
if (name == null) {
	response.sendRedirect("login.jsp");
}
%>

<%@ page import="java.sql.*"%>

<%
	Connection con;
PreparedStatement pst,pst1;
ResultSet rs;

String id = null;
String email = null;
String uname = null;
String phone = null;

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");

pst = con.prepareStatement("select * from users where name = ?");
pst.setString(1, name);
rs = pst.executeQuery();

while (rs.next()) {
	id = rs.getString("id");
	email = rs.getString("email");
	uname = rs.getString("username");
	phone = rs.getString("phone");
}

Statement st = con.createStatement();
rs = st.executeQuery("select count(*) from users");
String users = null;
while (rs.next()) {
	users = rs.getString(1);
}

rs = st.executeQuery("select count(*) from orders");
String orders = null;
while (rs.next()) {
	orders = rs.getString(1);
}

rs = st.executeQuery("select count(*) from products");
String products = null;
while (rs.next()) {
	products = rs.getString(1);
}

rs = st.executeQuery("select count(*) from orders");
String def = null;
while (rs.next()) {
	orders = rs.getString(1);
}

String edible = null;	  
pst1 = con.prepareStatement("select count(*) from products where edible = ?");
pst1.setString(1, "Yes");
rs = pst1.executeQuery();
while (rs.next()) {
	edible = rs.getString(1);
}

String nonedible = null;	  
pst1 = con.prepareStatement("select count(*) from products where edible = ?");
pst1.setString(1, "No");
rs = pst1.executeQuery();
while (rs.next()) {
	nonedible = rs.getString(1);
}

String query1 = "SELECT COUNT(*) FROM products WHERE expdate = DATE_ADD(CURDATE(), INTERVAL 3 DAY) or expdate = DATE_ADD(CURDATE(), INTERVAL 2 DAY) or expdate = DATE_ADD(CURDATE(), INTERVAL 1 DAY)";
rs = st.executeQuery(query1);
String nearexp = null;
while (rs.next()) {
	nearexp = rs.getString(1);	
}

String query2 = "SELECT COUNT(*) FROM products WHERE expdate <= DATE(NOW())";
rs = st.executeQuery(query2);
String exp = null;
while (rs.next()) {
	exp = rs.getString(1);
}

String query3 = "SELECT COUNT(*) FROM products WHERE qty > 0 and qty <= 50";
rs = st.executeQuery(query3);
String ls = null;
while (rs.next()) {
	ls = rs.getString(1);
}

String query4 = "SELECT COUNT(*) FROM products WHERE qty = 0";
rs = st.executeQuery(query4);
String ns = null;
while (rs.next()) {
	ns = rs.getString(1);
}

%>


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

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>:: E-MART :: INVENTORY MANAGER ::</title>
</head>

<body class="try">
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
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Home">home</i></a></li>
					<li><a href="listadmin.jsp">PRODUCTS</a></li>

					<li class="active"><a href="dashboard.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
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
	<ul class="side-nav grey lighten-2" id="mobile-nav">
		<li><a href="admin.jsp">Home</a></li>
		<li><a href="listadmin.jsp">Products</a></li>

		<li class="active"><a href="dashboard.jsp">Dashboard</a></li>
		<li><a href="orders.jsp">Orders</a></li>

		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!-- Dashboard -->
	<section class="section section-admin">
		<div class="container">
			<div class="card-panel black" style="opacity: 0.85;">
				<div class="card-action indigo darken-4 center">
					<h3 class="grey-text text-lighten-1">
						<i class="material-icons left" style="font-size: xxx-large;">dashboard
						</i> DASHBOARD <i class="material-icons right"
							style="font-size: xxx-large;">dashboard</i>
					</h3>
				</div>
				<br> <br>
				<div class="row">
					<div class="col l5 offset-l1 m6 offset-3 s6 ">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">people</i></b>
									<br /> <span style="font-size: large;"><b>CUSTOMERS</b></span>
									<br /> <span style="font-size: x-large;"><b><%=users%></b></span>
								<div class="progress grey lighten-1 ">
									<div class="determinate black " style="width: 30%;"></div>
								</div>
								</p>
							</div>
						</div>
					</div>
					<div class="col l5 m6 offset-3 s6 ">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">local_shipping</i></b>
									<br /> <span style="font-size: large;"><b>ORDERS</b></span> <br />
									<span style="font-size: x-large;"><b><%=orders%></b></span>
								<div class="progress grey lighten-1 ">
									<div class="determinate black " style="width: 10%;"></div>
								</div>
								</p>
							</div>
						</div>
					</div>
				</div>
				<br>
				<hr>
				<br> <br>
				<div class="row">
					<div class="col l4 offset-l4 m6 offset-m3 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">local_grocery_store</i></b>
									<br /> <span style="font-size: large;"><b>PRODUCTS</b></span>
									<br /> <span style="font-size: x-large;"><b><%=products %></b></span>
								<div class="progress grey lighten-1 ">
									<div class="determinate black " style="width: 20%;"></div>
								</div>
								</p>
							</div>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col l4 m4 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">cake</i></b>
									<br /> <span style="font-size: large;"><b>EDIBLE</b></span> <br />
									<span style="font-size: x-large;"><b><%=edible %></b></span>

								</p>
							</div>
						</div>
					</div>
					<div class="col l4 m4 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">av_timer</i></b>
									<br /> <span style="font-size: large;"><b>NEARING
											EXPIRY</b></span> <br /> <span style="font-size: x-large;"><b><%=nearexp %></b></span>

								</p>
							</div>
						</div>
					</div>
					<div class="col l4 m4 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons" style="font-size: xxx-large;">report</i></b>
									<br /> <span style="font-size: large;"><b>LESS
											STOCK</b></span> <br /> <span style="font-size: x-large;"><b><%=ls %></b></span>

								</p>
							</div>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col l4 m4 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">format_color_fill</i></b>
									<br /> <span style="font-size: large;"><b>NON-EDIBLE</b></span>
									<br /> <span style="font-size: x-large;"><b><%=nonedible %></b></span>

								</p>
							</div>
						</div>
					</div>
					<div class="col l4 m4 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons " style="font-size: xxx-large;">timer_off</i></b>
									<br /> <span style="font-size: large;"><b>EXPIRED</b></span> <br />
									<span style="font-size: x-large;"><b><%=exp %></b></span>

								</p>
							</div>
						</div>
					</div>
					<div class="col l4 m4 s8 offset-s2">
						<div class="card box indigo darken-4 ">
							<div class="card-action center grey-text text-lighten-1 ">
								<p>
									<b><i class="material-icons" style="font-size: xxx-large;">remove_circle</i></b>
									<br /> <span style="font-size: large;"><b>OUT OF
											STOCK</b></span> <br /> <span style="font-size: x-large;"><b><%=ns %></b></span>

								</p>
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
	<footer class="section blue darken-4 grey-text text-lighten-3 center ">
		<a href="dashboard.jsp" class="brand-logo grey-text text-lighten-3 "><i
			class="material-icons " style="font-size: 38px;">shopping_basket</i></a>
	</footer>

	<!--Import jQuery before materialize.js-->
	<script type="text/javascript "
		src="https://code.jquery.com/jquery-3.2.1.min.js "></script>
	<script type="text/javascript " src="js/materialize.min.js "></script>
	<script>
		$(document).ready(function() {
			//Side-Nav
			$(".button-collapse ").sideNav();

		});
	</script>
</body>
</html>
