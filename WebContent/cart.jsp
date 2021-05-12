<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
	if((String)session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*"%>

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
				<a href="home.jsp" class="brand-logo grey-text text-lighten-3"><i
					class="material-icons" style="font-size: 35px;">shopping_basket</i>Inv-Manager</a>
				<a href="#" data-activates="mobile-nav" class="button-collapse">
					<i class="material-icons grey-text text-lighten-5">menu</i>
				</a>
				<ul class="right hide-on-med-and-down">
					<li><a href="home.jsp"><i
							class="tooltipped material-icons grey-text text-lighten-3 "
							style="font-size: 30px;" data-tooltip="Home">home</i></a></li>
					<li><a href="list.jsp">PRODUCTS</a></li>
					<li class="active"><a href="cart.jsp">CART</a></li>
					<li><a href="yourorder.jsp">YOUR ORDERS</a></li>
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
		<li><a href="list.jsp">Products</a></li>
		<li class="active"><a href="cart.jsp">Cart</a></li>
		<li><a href="yourorder.jsp">Your Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Products Section-->
	<section class="section section-update ord">
		<div class="container">
			<div class="row">


				<!-- View Cart -->
				<div class="col s12">
					<div class="card grey lighten-2 box">
						<div
							class="card-action grey darken-4 grey-text text-lighten-3 center">
							<h5 style="font-family: monospace;" style="font-weight: bold;">
								<i class="fas fa-shopping-cart left"></i> CART <i
									class="fas fa-shopping-cart right"></i>
							</h5>
						</div>
						<div class="card-stacked">
							<div class="card-content">
							<div class="card-action">
								<p class="grey lighten-1"><span style="font-weight: bold;">CUSTOMER NAME&MediumSpace;&MediumSpace; : &MediumSpace;&MediumSpace; <%=session.getAttribute("email") %></span></p>
							</div>
								<table class="centered highlight">
									<thead>
										<tr style="font-size: 13px;">
											<th>#</th>
											<th>ITEM NAME</th>
											<th>RATE PER UNIT (Rs.)</th>
											<th>QUANTITY</th>
											<th>TOTAL PRICE (Rs.)</th>
											<th></th>
										</tr>
									</thead>
									<%
											Connection con1;
											PreparedStatement pst1;
											ResultSet rs1,rs2;
				
											Class.forName("com.mysql.jdbc.Driver");
											con1 = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
				
											String query1 = "select * from cart";
											Statement st1 = con1.createStatement();
											rs1 = st1.executeQuery(query1);
											float total = 0;
				
											while (rs1.next()) {
												String item_no = rs1.getString("item_no");
												total += Float.parseFloat(rs1.getString("total_ppu"));
									%>

									<tbody>
										<tr>
											<td><%=rs1.getString("item_no")%></td>
											<td><%=rs1.getString("item_name")%></td>
											<td><%=rs1.getString("price")%></td>
											<td><%=rs1.getString("qty")%></td>
											<td><%=rs1.getString("total_ppu")%></td>
											<td>
												<!-- 
												<a href="cartedit.jsp?item_no=<%=item_no%>"> <i
												class="material-icons green-text text-darken-2 tooltipped" data-tooltip="Edit Quantity" style="font-weight:bold;">edit</i>
												</a>
												 -->
												<a href="cartdelete.jsp?item_no=<%=item_no%>"> <i
												class="material-icons red-text text-darken-2 tooltipped" data-tooltip="Remove From Cart" style="font-weight:bold;">close</i>
												</a>
																								
											</td>
										</tr>

										<% } %>
									</tbody>
								</table>

							</div>
							<div class="card-action">
								<div class="right" style="margin-top: 10px;">
									<p class="grey lighten-1">
										<span style="font-weight: bold;">&MediumSpace; GRAND
											TOTAL : &MediumSpace;&MediumSpace; Rs.&MediumSpace; <%=total%>/-
											&MediumSpace;</span>
									</p>
									
								</div>
								<br> <br> <br>  
								<div class="center">
									<a href="#geninv" class="btn red darken-4 modal-trigger"><i
									class="fas fa-chevron-circle-right left"></i>PLACE ORDER
									</a>
									<!-- 
									<a href="clearcart.jsp" class="btn-floating blue darken-4 tooltipped" data-tooltip="Clear Cart"><i
									class="fas fa-trash left" style="font-size:large;"></i></a>
									-->
								</div> <br>
								
																
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
	<!-- Confirm Modal -->
	<div id="geninv" class="modal transparent">
    	<div class="card">
    		<div class="card-action green darken-4 center grey-text text-lighten-2">
    			<h5><i class="fas fa-check-circle left"></i>ORDER PLACED<i class="fas fa-check-circle right"></i></h5>
    		</div>
    		<div class="card-content center grey lighten-1">
    			<a href="orderdetails.jsp" class="btn blue darken-4 modal-trigger grey-text text-lighten-2"> <i
									class="fas fa-file-invoice left"></i>GENERTATE INVOICE
									</a>	
    		</div>
    	</div>
  	</div>

	<!--Add More Button-->
	<div class="fixed-action-btn">
		<a href="list.jsp"
			class="btn-floating red darken-4 btn-large tooltipped pulse"
			data-tooltip="Add More?" data-position="left"> <i
			class="fas fa-arrow-alt-circle-left grey-text text-lighten-2"
			style="font-size: xx-large"></i>
		</a>
	</div>



	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="cart.jsp" class="brand-logo grey-text text-lighten-3"><i
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