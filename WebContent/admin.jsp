
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
					<li class="active"><a href="admin.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Home">home</i></a></li>
					<li><a href="dashboard.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Dashboard">dashboard</i></a></li>
					<li><a href="login.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3"
							style="font-size: 30px;" data-tooltip="Logout">logout</i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!--Side NavBar-->
	<ul class="side-nav grey lighten-2" id="mobile-nav">
		<li class="active"><a href="admin.jsp">Home</a></li>
		<li><a href="dashboard.jsp">Dashboard</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Admin Page-->
	<section class="section section-admin">
		<div class="container">
			<div class="card-panel black" style="opacity: 0.85;">
				<div class="card-action indigo darken-4 center">
					<h3 class="grey-text text-lighten-1">
						<i class="material-icons left" style="font-size: xxx-large;">person_pin
						</i> ADMIN <i class="material-icons right"
							style="font-size: xxx-large;">person_pin </i>
					</h3>
				</div>
				<div class="row">
					<div class="col s10 offset-s1 m6 offset-m3 l4 push-l4">
						<div class="card box">
							<div class="card-image responsive-img">
								<img src="img/u1.jpg" />
							</div>
							<div class="card-action grey-text text-lighten-2 center">
								<i class="material-icons" style="font-size: xx-large;">email</i><br>
								<span class="center" style="font-size: large"><b><%=name%></b></span>
							</div>
						</div>
					</div>

				</div>
				<hr>
				<br>
				<br>
				<div class="row">
					<div class="col s10 offset-s1 m5 offset-m3 pull-m2 l3">
						<div class="card indigo darken-4 box">
							<div class="card-image">
								<img src="img/manage1.jpg" />
							</div>
							<div class="card-action center">
								<br>
								<p class="grey-text text-lighten-2"
									style="font-weight: bold; font-size: 18px;">MANAGE STOCK</p>
								<br>
							</div>
							<div class="card-action center">
								<a href="prodedit.jsp"
									class="btn-floating grey darken-4 grey-text text-lighten-2 pulse"><i
									class="fas fa-tasks grey-text text-lighten-3"
									style="font-size: large;"></i></a>

							</div>
						</div>
					</div>
					<div class="col s10 offset-s1 m5 offset-m3 push-m3 l3">
						<div class="card indigo darken-4 box">
							<div class="card-image">
								<img src="img/staples.jpg" />
							</div>
							<div class="card-action center">
								<br>
								<p class="grey-text text-lighten-2"
									style="font-weight: bold; font-size: 18px;">VIEW STOCK</p>
								<br>
							</div>
							<div class="card-action center">
								<a href="listadmin.jsp"
									class="btn-floating grey darken-4 grey-text text-lighten-2 pulse"><i
									class="fas fa-eye grey-text text-lighten-3"
									style="font-size: large;"></i></a>

							</div>
						</div>
					</div>
					<div class="col s10 offset-s1 m5 offset-m3 pull-m2 l3">
						<div class="card indigo darken-4 box">
							<div class="card-image">
								<img src="img/order1..png" />
							</div>
							<div class="card-action center">
								<br>
								<p class="grey-text text-lighten-2"
									style="font-weight: bold; font-size: 18px;">ORDER HISTORY</p>
								<br>
							</div>
							<div class="card-action center">
								<a href="orders.jsp"
									class="btn-floating grey darken-4 grey-text text-lighten-2 pulse"><i
									class="fas fa-paper-plane grey-text text-lighten-3"
									style="font-size: large;"></i></a>
							</div>
						</div>
					</div>
					<div class="col s10 offset-s1 m5 offset-m3 push-m3 l3">
						<div class="card indigo darken-4 box">
							<div class="card-image">
								<img src="img/alert1.jpg" />
							</div>
							<div class="card-action center">
								<br>
								<p class="grey-text text-lighten-2"
									style="font-weight: bold; font-size: 18px;">STOCK ALERTS</p>
								<br>
							</div>
							<div class="card-action center">
								<a href="stockalerts.jsp"
									class="btn-floating grey darken-4 grey-text text-lighten-2 pulse"><i
									class="fas fa-exclamation-circle grey-text text-lighten-3"
									style="font-size: large;"></i></a>
							</div>
						</div>
					</div>
				</div>
				<br>
				<hr>
				<br>
				<br>
				<div class="row">
					<div class="col s10 offset-s1 m8 offset-m2 l8 push-l2">
						<div href="dashboard.jsp" class="card indigo darken-4 box">
							<div class="card-action grey-text text-lighten-2 center">
								<i class="material-icons" style="font-size: xxx-large"><b>dashboard</b></i>
								<br> <a href="dashboard.jsp"
									class="btn btn-extended grey darken-4 grey-text text-lighten-3"><span
									style="font-size: large">DASHBOARD</span></a>
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
		<a href="admin.jsp " class="brand-logo grey-text text-lighten-3 "><i
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
