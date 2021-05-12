
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
PreparedStatement pst;
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

pst = con.prepareStatement("select count(*) from orders where cust_name = ? order by order_date_time ");
pst.setString(1, name);

rs = pst.executeQuery();
String orders = null;
while (rs.next()) {
	orders = rs.getString(1);
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

<!--   
<script type="text/javascript">
	function preventBack() {
		window.history.forward();
	}
	setTimeout("preventBack()", 0);
	window.onunload = function() {
		null;
	};
</script> 
-->

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>:: E-MART :: INVENTORY MANAGER ::</title>
</head>

<body class="try">
	<!--NavBar-->
	<nav class="blue darken-4">
		<div class="container">
			<div class="nav-wrapper">
				<a href="#" class="brand-logo grey-text text-lighten-3"><i
					class="material-icons" style="font-size: 35px;">shopping_basket</i>Inv-Manager</a>
				<a href="#" data-activates="mobile-nav" class="button-collapse">
					<i class="material-icons grey-text text-lighten-5">menu</i>
				</a>
				<ul class="right hide-on-med-and-down">
					<li class="active"><a href="home.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Home">home</i></a></li>
					<li><a href="login.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Logout">logout</i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!--Side NavBar-->
	<ul class="side-nav grey lighten-2" id="mobile-nav">
		<li class="active"><a href="home.jsp">Home</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Section Menu-->
	<section class="section section-admin">
		<div class="container">
			<div class="card-panel black" style="opacity: 0.85;">
				<div class="row">
					<div class="col l4 m6 offset-m3 s10 offset-s1">
						<div class="card box">
							<div class="card-image responsive-img">
								<img src="img/u1.jpg" />
							</div>
							<div class="card-action grey-text text-lighten-1 center">
								<h5>
									USER : <%=name%></h5>
								<br />
							</div>
							
						</div>

					</div>
					<div class="col l8 m6 offset-m3 s10 offset-s1">
						<div class="row" style="margin-top: 30px;">

							<div class="col l5 push-l1 m10 offset-m1 s12">
								<div class="card indigo darken-4 box">
									<div class="card-action center grey-text text-lighten-2">
								<div>
									<h5>USER DETAILS</h5>
									<hr>
									<br>
									<p>
										USERNAME :
										<%=uname%></p>
									<p>
										EMAIL ID :
										<%=email%></p>
									<p>
										PHONE NO. :
										<%=phone%></p>
								</div>
									</div>
								</div>

							</div>
							<div class="col l5 push-l1 m10 offset-m1 s12">
								<div class="card indigo darken-4 box" style="margin-top:12px;">
									<div class="card-action center">
										<p class="grey-text text-lighten-2">
											<span
												style="font-size: x-large;"><b> <i class="material-icons grey-text text-lighten-2"
												style="font-size: xx-large;">local_shipping</i> <br> ORDERS</b></span> <br /> <span
												style="font-size: xx-large;"><b><%=orders%></b></span>
										<div class="progress grey lighten-1 ">
											<div class="determinate black " style="width: 10%;"></div>
										</div>
										</p>
										
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 30px;">

							<div class="col l5 push-l1 m10 offset-m1 s12">
								<div class="card indigo darken-4 box">
									<div class="card-image">
										<img src="img/staples.jpg" />
									</div>
									<div class="card-action center">
										<br>
										<p class="grey-text text-lighten-2"
											style="font-weight: bold; font-size: 18px;">VIEW PRODUCTS</p>
										<br>
									</div>
									<div class="card-action center">
										<a href="list.jsp"
											class="btn-floating grey darken-4 grey-text text-lighten-2 pulse"><i
											class="fas fa-eye grey-text text-lighten-3"
											style="font-size: large;"></i></a>

									</div>

								</div>

							</div>
							<div class="col l5 push-l1 m10 offset-m1 s12">
								<div class="card indigo darken-4 box">
									<div class="card-image">
										<img src="img/order1..png" />
									</div>
									<div class="card-action center">
										<br>
										<p class="grey-text text-lighten-2"
											style="font-weight: bold; font-size: 18px;">YOUR ORDERS</p>
										<br>
									</div>
									<div class="card-action center">
										<a href="yourorder.jsp"
											class="btn-floating grey darken-4 grey-text text-lighten-2 pulse"><i
											class="fas fa-paper-plane grey-text text-lighten-3"
											style="font-size: large;"></i></a>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 20px;">
							<div class="col l10 pull-l1 offset-l2 m12 s12">
								<a href="#abtus"
									class=" box btn btn-extended indigo darken-4 grey-text text-lighten-2 modal-trigger"
									style="font-weight: bold;">ABOUT US!</a>
							</div>
						</div>
											</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Confirm Modal -->
	<div id="abtus" class="modal grey darken-4" style="opacity: 0.8;">
		<div class="container">
			<div class="slider">
				<ul class="slides">
					<li><img src="img/m1.jpg" style="filter: brightness(90%);">
						<div class="caption right-align black-text">
							<h3>ABOUT US!</h3>
							<p class="right-align black-text" style="font-size: large;">
								<span style="font-weight: bold;">INV-MANAGER</span> is an
								efficient<br> Web Application that allows <br>users to
								manage their <br> inventories efficiently.<br>Swipe to
								check<br> features provided <br> <span
									style="font-size: xxx-large; font-weight: bold;">&RightArrow;</span>
							</p>

						</div></li>
					<li><img src="img/m3.jpg" style="filter: brightness(50%);">
						<div class="caption right-align grey-text text-lighten-2">
							<h3>STOCK MANAGEMENT</h3>
							<p class="grey-text text-lighten-3" style="font-size: large;">
								&diamondsuit; Add/Remove Products <br> &diamondsuit; Update
								Products <br>
							</p>
						</div></li>
					<li><img src="img/m4.jpg" style="filter: brightness(50%);">
						<div class="caption left-align grey-text text-lighten-2">
							<h3>CATEGORIZE STOCK</h3>
							<p class="grey-text text-lighten-3" style="font-size: large;">
								&diamondsuit; Eible/Non-Edible <br> &diamondsuit;
								Defective/Non_defective etc.. <br>
							</p>
						</div></li>
					<li><img src="img/m5.jpg" style="filter: brightness(50%);">
						<div class="caption right-align grey-text text-lighten-2">
							<h3>ORDER HISTORY</h3>
							<p class="grey-text text-lighten-3" style="font-size: large;">
								&diamondsuit; Track Your Order Details <br>

							</p>
						</div></li>
					<li><img src="img/m6.jpg" style="filter: brightness(50%);">
						<div class="caption right-align grey-text text-lighten-2">
							<h3>STOCK ALERTS</h3>
							<p class="grey-text text-lighten-3" style="font-size: large;">
								&diamondsuit; Expiration Alerts <br> &diamondsuit; Out Of
								Stock Alerts <br> &diamondsuit; Defect Alerts <br>

							</p>
						</div></li>
					<li><img src="img/m7.jpg" style="filter: brightness(50%);">
						<div class="caption left-align grey-text text-lighten-2">
							<h3>ADDITIONAL FEATURES</h3>
							<p class="grey-text text-lighten-3" style="font-size: large;">
								&diamondsuit; Fully Functioning Cart <br> &diamondsuit;
								Invoive Generation <br> &diamondsuit; Barcode Generation <br>

							</p>
						</div></li>
				</ul>
			</div>
		</div>
	</div>


	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="home.jsp" class="brand-logo grey-text text-lighten-3"><i
			class="material-icons" style="font-size: 38px;">shopping_basket</i></a>
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

			//Slider
			$('.slider').slider({
				indicators : true,
				transition : 500,
				interval : 3000
			});
		});
	</script>
</body>
</html>