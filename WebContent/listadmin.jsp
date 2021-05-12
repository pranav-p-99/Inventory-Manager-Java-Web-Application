
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
					<li class="active"><a href="listadmin.jsp">PRODUCTS</a></li>
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
		<li class="active"><a href="listadmin.jsp">Products</a></li>
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
						<div class="card-action grey darken-4">
							<h5 class="center grey-text text-lighten-2"
								style="font-weight: bold;">
								<i class="fas fa-stream left"></i>PRODUCT LIST<i
									class="fas fa-stream right"></i>
							</h5>
						</div>
						<div class="card-tabs">
							<ul class="tabs tabs-fixed-width grey lighten-3"
								style="overflow: hidden;">
								<li class="tab"><a class="active" href="#test4"> <span
										class="grey-text text-darken-3"
										style="font-weight: bold; font-size: medium;">Total
											Stock</span>
								</a></li>
								<li class="tab"><a href="#test5"> <span
										class="green-text text-darken-3"
										style="font-weight: bold; font-size: medium;">Edible</span>
								</a></li>
								<li class="tab"><a href="#test6"> <span
										class="red-text text-darken-3"
										style="font-weight: bold; font-size: medium;">Non
											Edible</span>
								</a></li>
							</ul>
						</div>
						<div class="card-content grey lighten-2">
							<div id="test4">
								<form action="" method="GET">
								<input type="text" name="q" placeholder="Search For A Product..">
								</form>
								<table class="centered highlight">
									<thead class="grey">
										<tr>
											<th>PRODUCT</th>
											<th>QUANTITY</th>
											<th>EXPIRY DATE</th>
											<th>PRICE PER ITEM (Rs.)</th>
											<th></th>
										</tr>
									</thead>

									<%
										Connection con;
										PreparedStatement pst;
										ResultSet rs;
										
										Class.forName("com.mysql.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
										
										String q1 = request.getParameter("q");
										
										
										String query = null;
										
										if(q1 != null){
											query="select * from products where pname like '%"+q1+"%' and expdate > DATE(NOW()) ";
										}else{
											query="select * from products where qty > 0 and expdate > DATE(NOW())";
										}
										Statement st = con.createStatement();
	
										rs = st.executeQuery(query);
	
										while (rs.next()) {
											String id = rs.getString("id");
									%>


									<tbody>
										<tr>
											<td><%=rs.getString("pname")%></td>
											<td><%=rs.getString("qty")%></td>
											<td><%=rs.getString("expdate")%></td>
											<td><%=rs.getString("pricepu")%></td>
											<td><a class="btn grey darken-3 tooltipped" data-tooltip="Show Barcode" data-position="right"
												href="barcode.jsp?item=<%=rs.getString("pname")%>"> <i
													class="fas fa-barcode grey-text text-lighten-3" style="font-size:xx-large;"></i>
											</a></td>
										</tr>

										<%
											}
										%>


									</tbody>
								</table>
							</div>


							<div id="test5">
								
								<table class="centered highlight">
									<thead class="grey">
										<tr>
											<th>PRODUCT</th>
											<th>QUANTITY</th>
											<th>EXPIRY DATE</th>
											<th>PRICE PER ITEM (Rs.)</th>
											<th></th>
										</tr>
									</thead>

									<%
										Connection con1;
										PreparedStatement pst1;
										ResultSet rs1;
	
										Class.forName("com.mysql.jdbc.Driver");
										con1 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
										
										String q2 = request.getParameter("q");
										
										String edible = "Yes";
	  
										pst1 = con1.prepareStatement("select * from products where edible = ? and expdate > DATE(NOW())");
				                        pst1.setString(1, edible);
				                        
				                        rs1 = pst1.executeQuery();
										
										
	
										while (rs1.next()) {
											String id = rs1.getString("id");
									%>


									<tbody>
										<tr>
											<td><%=rs1.getString("pname")%></td>
											<td><%=rs1.getString("qty")%></td>
											<td><%=rs1.getString("expdate")%></td>
											<td><%=rs1.getString("pricepu")%></td>
											<td><a class="btn grey darken-3 tooltipped" data-tooltip="Show Barcode" data-position="right"
												href="barcode.jsp?item=<%=rs1.getString("pname")%>"> <i
													class="fas fa-barcode grey-text text-lighten-3" style="font-size:xx-large;"></i>
											</a></td>
											
										</tr>

										<%
											}
										%>


									</tbody>
								</table>

							</div>


							<div id="test6">
								<table class="centered highlight">
									<thead class="grey">
										<tr>
											<th>PRODUCT</th>
											<th>QUANTITY</th>
											<th>EXPIRY DATE</th>
											<th>PRICE PER ITEM (Rs.)</th>
											<th></th>
										</tr>
									</thead>

									<%
										Connection con2;
										PreparedStatement pst2;
										ResultSet rs2;
	
										Class.forName("com.mysql.jdbc.Driver");
										con2 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
	
										String ed = "No";
										
				                          
				                        pst2 = con2.prepareStatement("select * from products where edible = ? and expdate > DATE(NOW())");
				                        pst2.setString(1, ed);
				                        rs2 = pst2.executeQuery();
										
										
	
										while (rs2.next()) {
											String id = rs2.getString("id");
									%>


									<tbody>
										<tr>
											<td><%=rs2.getString("pname")%></td>
											<td><%=rs2.getString("qty")%></td>
											<td><%=rs2.getString("expdate")%></td>
											<td><%=rs2.getString("pricepu")%></td>
											<td><a class="btn grey darken-3 tooltipped" data-tooltip="Show Barcode" data-position="right"
												href="barcode.jsp?item=<%=rs2.getString("pname")%>"> <i
													class="fas fa-barcode grey-text text-lighten-3" style="font-size:xx-large;"></i>
											</a></td>
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
	</section>




	<!-- Add Product Button -->
	<div class="fixed-action-btn">
		<a href="prodedit.jsp"
			class="btn-floating red darken-3 btn-large tooltipped modal-trigger pulse"
			data-tooltip="Add Products" data-position="left"> <i
			class="fas fa-plus grey-text text-lighten-1"></i>
		</a>
	</div>



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