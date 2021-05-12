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

<%
	if (request.getParameter("submit") != null) {

		
	String productname = request.getParameter("productname");
	String quantity = request.getParameter("quantity");
	String tquantity = request.getParameter("tquantity");
	String price = request.getParameter("price");
	String exp = request.getParameter("expdate");
	
	int x = Integer.parseInt(quantity);
	int y = Integer.parseInt(tquantity);
	int z = y - x;
	String ntqty = String.valueOf(z);
	
	String total_ppu = String.valueOf(Integer.parseInt(quantity) * Float.parseFloat(price));

	Connection con;
	PreparedStatement pst , pst1t;
	ResultSet rs;

	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
	pst = con.prepareStatement("insert into cart(item_name,qty,tqty,price,total_ppu,expdate)values(?,?,?,?,?,?)");
	pst.setString(1, productname);
	pst.setString(2, quantity);
	pst.setString(3, tquantity);
	pst.setString(4, price);
	pst.setString(5, total_ppu);
	pst.setString(6, exp);
	pst.executeUpdate();
	
	pst1t = con.prepareStatement("update products set qty=? where pname=? and expdate=?");
    pst1t.setString(1, ntqty);
    pst1t.setString(2, productname);
    pst1t.setString(3, exp);
    pst1t.executeUpdate();
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
					<li><a href="cart.jsp">CART</a></li>
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
		<li><a href="cart.jsp">Cart</a></li>
		<li><a href="yourorder.jsp">Your Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Adding To Cart Section-->
	<section class="section section-update">
		<div class="container">
			<div class="row">

				<!--Adding to Cart-->
				<div class="col s12 m8 offset-m2 l6 offset-l3">
					<div class="card grey lighten-2 box">
						<div class="card-action grey darken-4 ">
							<p class=" flow-text grey-text text-lighten-2 center" style="font-size:19px;">
								<i class="material-icons grey-text text-lighten-2 left"
									style="font-size: xx-large">add</i> ADD TO CART ? <i
									class="material-icons grey-text text-lighten-2 right"
									style="font-size: xx-large">add</i>
							</p>
						</div>
						<form method="POST" action="#">

							<%
								Connection con;
							PreparedStatement pst;
							ResultSet rs;

							Class.forName("com.mysql.jdbc.Driver");
							con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");

							String id = request.getParameter("id");

							pst = con.prepareStatement("select * from products where id = ?");
							pst.setString(1, id);
							rs = pst.executeQuery();

							while (rs.next()) {
							%>

							<div class="card-content">
								<div class="input-field">
									<i class="fab fa-product-hunt prefix"></i> <input type="text"
										id="productname" name="productname"
										value="<%=rs.getString("pname")%>"
										class="grey-text lighten-1" readonly /> <label for="username"
										class="grey-text lighten-1">Product Name</label>
								</div>

								<div class="input-field">
									<i class="fas fa-weight prefix"></i> <input type="number"
										id="quantity" name="quantity" class="grey-text lighten-1"
										required /> <label for="quantity" class="grey-text lighten-1">Quantity</label>
								</div>

								<div class="input-field">
									<i class="fas fa-weight prefix"></i> <input type="number"
										id="tquantity" name="tquantity"
										value="<%=rs.getString("qty")%>" class="grey-text lighten-1"
										readonly /> <label for="tquantity"
										class="grey-text lighten-1">Available Quantity</label>
								</div>


								<div class="input-field">
									<i class="fas fa-tags prefix"></i> <input type="number"
										step=0.01 id="price" name="price"
										value="<%=rs.getString("pricepu")%>"
										class="grey-text lighten-1" readonly /> <label for="price"
										class="grey-text lighten-1">Price Per Item</label>
								</div>
								
								<div class="input-field">
									<i class="fas fa-calendar-alt prefix"></i> <input type="text"
										id="expdate" name="expdate"
										value="<%=rs.getString("expdate")%>"
										class="grey-text lighten-1" readonly /> <label for="expdate"
										class="grey-text lighten-1">Expiry Date</label>
								</div>

								<%
									}
								%>

								<div class="input-field center">
									<input type="submit" id="submit" value="  ADD"
										name="submit"
										class="fas fa-plus-circle btn btn-extended grey darken-4 white-text waves-effect waves-light center"
										style="margin-left: 45px;"> 

								</div>
								<br>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!--Go Back Button-->
    <div class="fixed-action-btn">
        <a href="list.jsp" class="btn-floating red darken-4 btn-large tooltipped pulse" data-tooltip="Go Back" data-position="left">
            <i class="fas fa-arrow-alt-circle-left grey-text text-lighten-2" style="font-size:xx-large"></i>
        </a>
    </div>
	
	

	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="cartadd.jsp" class="brand-logo grey-text text-lighten-3"><i
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
</body class="grey">

</html>