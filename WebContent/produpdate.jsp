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

    if(request.getParameter("submit")!=null)
    {
        String id = request.getParameter("id");
    	String productname = request.getParameter("productname");
        String quantity = request.getParameter("quantity");
        String type = request.getParameter("type");
    	String date = request.getParameter("date");
    	String price = request.getParameter("price");
        
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
        pst = con.prepareStatement("update products set pname=?,qty=?,edible=?,expdate=?,pricepu=? where id=?");
        pst.setString(1, productname);
        pst.setString(2, quantity);
        pst.setString(3, type);
        pst.setString(4, date);
        pst.setString(5, price);
        pst.setString(6, id);
        pst.executeUpdate();  
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
					<li><a href="admin.jsp">ADMIN</a></li>
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
		<li><a href="list.jsp">Products</a></li>
		<li><a href="cart.jsp">Cart</a></li>
		<li><a href="admin.jsp">Admin</a></li>
		<li><a href="orders.jsp">Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Products Section-->
	<section class="section section-update">
		<div class="container">
			<div class="row">

				<!--Update Products-->
				<div class="col s12 m8 offset-m2 l8 offset-l2">
					<div class="card grey lighten-2 box">
						<div class="card-action grey darken-4 ">
							<h5 class="grey-text text-lighten-2 center"><i class="fas fa-edit left"></i>EDIT ITEM<i class="fas fa-edit right"></i></h5>
						</div>
						<form method="POST" action="#">
						
							<%    
			                        Connection con;
			                        PreparedStatement pst;
			                        ResultSet rs;
			        
			                        Class.forName("com.mysql.jdbc.Driver");
			                        con = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
			                           
			                        String id = request.getParameter("id");
			                          
			                        pst = con.prepareStatement("select * from products where id = ?");
			                        pst.setString(1, id);
			                        rs = pst.executeQuery();
			                        
			                        while(rs.next())
			                        {
			                    
                    		%>
						
							<div class="card-content">
								<div class="input-field">
									<i class="fab fa-product-hunt prefix"></i> <input type="text" 
										id="productname" name="productname" value="<%= rs.getString("pname")%>" class="grey-text lighten-1" required />
									<label for="username" class="grey-text lighten-1">Product Name</label>
								</div>

								<div class="input-field">
									<i class="fas fa-weight prefix"></i> <input type="number"
										id="quantity" name="quantity" value="<%= rs.getString("qty")%>" class="grey-text lighten-1" required /> <label
										for="quantity" class="grey-text lighten-1">Quantity</label>
								</div>
								
								<div class="input-field">
									<i class="fas fa-question-circle prefix"></i> <input
										type="text" id="type" name="type" value="<%= rs.getString("edible")%>" class="grey-text lighten-1"
										required /> <label for="type" class="grey-text lighten-1">Edible?</label>
								</div>


								<div class="input-field">
									<i class="far fa-calendar-times prefix"></i> <input type="date"
										id="date" name="date" value="<%= rs.getString("expdate")%>" class="grey-text lighten-1" />
								</div>
								
								<div class="input-field">
									<i class="fas fa-tags prefix"></i> <input type="number" step=0.01 id="price" name="price" value="<%= rs.getString("pricepu")%>" class="grey-text lighten-1" />
								</div>
								
							<% } %>	

								<div class="input-field center">
									<input type="submit" id="submit" value="UPDATE"
										name="submit"
										class="btn btn-small btn-extended blue darken-4 white-text waves-effect waves-light left" style="margin-left:45px;">
										<a href="prodedit.jsp" class="btn btn-floating blue darken-4"> <i class="fas fa-undo grey-text text-lighten-2 tooltipped" data-tooltip = "Go Back" data-position="right"></i> </a>

								</div>
								<br> 
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>


	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="produpdate.jsp" class="brand-logo grey-text text-lighten-3"><i
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
</body class="grey">

</html>