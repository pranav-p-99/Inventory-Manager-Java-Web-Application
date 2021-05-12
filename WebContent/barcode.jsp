
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
	if(session.getAttribute("email")==null){
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
<link type="text/css" rel="stylesheet" href="css/qurries.css" />
<script type="text/javascript" src="js/materialize.min.js"></script>


<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>:: E-MART :: INVENTORY MANAGER ::</title>
</head>

<body class="grey darken-1 prod-body">

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
		<li><a href="home.jsp">Home</a></li>
		<li><a href="listadmin.jsp">Products</a></li>
		<li><a href="dashboard.jsp">Dashboard</a></li>
		<li><a href="orders.jsp">Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--All Products-->
	<section class="section section-allProducts">
		<div class="container">
			<div class="row">
				<div class="col s12">
					<div class="card box">
						<div class="card-action center grey darken-4 grey-text text-lighten-2">
							<h4><i class="fas fa-barcode left"></i>
							BARCODE
							<i class="fas fa-barcode right"></i></h4>
						</div>
						<%
								Connection con;
								PreparedStatement pst;
								ResultSet rs;
	
								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
	
								String item = request.getParameter("item");
	
								pst = con.prepareStatement("select * from barcode where item = ?");
								pst.setString(1, item);
								rs = pst.executeQuery();
	
								while (rs.next()) {
						%>
						<div class="card-content center grey lighten-2">
							<h5 class="grey lighten-1">PRODUCT NAME : <%=rs.getString("item") %></h5> <br>
							<img alt="my image" src="Barcode?value=<%= rs.getString("code") %>">
						</div>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	</section>



	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="listadmin.jsp" class="brand-logo grey-text text-lighten-3"><i
			class="material-icons" style="font-size: 38px;">shopping_basket</i></span></a>
	</footer>

	<!--Import jQuery before materialize.js-->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
	<script>
		$(document).ready(function() {

			//Side-Nav
			$(".button-collapse").sideNav();
			

		});
	</script>
</body>

</html>