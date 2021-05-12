
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
%>


<%@page import="java.sql.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "data.Pdfgen"  %>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
 <%
 
 Pdfgen.sendMail();
 String date = new java.util.Date().toLocaleString();
 String x[] = date.split(",");
 String y = x[0];
 String z = x[1].substring(0,5) + x[1].substring(8,x[1].length());
 String name =(String) session.getAttribute("email"); 
  
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
		<li><a href="admin.jsp">Admin</a></li>
		<li><a href="yourorder.jsp">Your Orders</a></li>
		<li><a href="login.jsp">Logout</a></li>
	</ul>

	<!--Invoice Section-->
	<section class="section section-invoice">
		<div class="container">
			<div class="row">
				<div class="col s12">
					<div  id="inv" class="card-panel grey lighten-4">
						<div class="card-action grey lighten-1"
							style="border: 1px solid #333;">
							<h4 class="center">INVOICE</h4>
						</div>
						<div class="card-action center">
							<br />
							<p class="left grey lighten-2"
								style="margin-left: 50px; padding-left: 30px; padding-right: 30px;">
								<b>ORDER DATE &MediumSpace;&MediumSpace;:&MediumSpace;&MediumSpace;</b> <%=y %>
							</p>
							<br /> <br />
							<p class="left grey lighten-2"
								style="margin-left: 50px; padding-left: 30px; padding-right: 30px;">
								<b>ORDER TIME &MediumSpace;&MediumSpace;:&MediumSpace;&MediumSpace;</b> <%=z %>
							</p>
							<br /> <br />
							<p class="left grey lighten-2"
								style="margin-left: 50px; padding-left: 30px; padding-right: 30px;">
								<b>CUSTOMER NAME &MediumSpace;&MediumSpace;:&MediumSpace;&MediumSpace;</b> <%=name %>
							</p>
							<br /> <br />
							<br />
							<p style="padding-bottom: 5px; padding-top: 5px;">
								<b class="center grey lighten-2"
									style="padding-left: 70px; padding-right: 70px; padding-top: 6px; padding-bottom: 6px;">PRODUCTS
									LIST</b>
							</p>
						</div>
						<br />
						<div class="card-content"
							style="padding-left: 10px; padding-right: 10px;">
							<table class="centered grey lighten-2">
								<thead>
									<tr>
										<th>#</th>
										<th>ITEM NAME</th>
										<th>PRICE (Rs.)</th>
										<th>QUANTITY</th>
										<th>AMOUNT (Rs.)</th>
									</tr>
								</thead>
								
								<%
								Connection con;
								PreparedStatement pst;
								ResultSet rs;

								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
								Statement st = con.createStatement();
																
								String query = "select * from cart";
								
								
								float amount = 0;
								
								rs = st.executeQuery(query);

								while (rs.next()) {
									amount += Float.parseFloat(rs.getString("total_ppu"));
								%>

								<tbody>
									<tr>
										<td><%=rs.getString("item_no") %></td>
										<td><%=rs.getString("item_name") %></td>
										<td><%=rs.getString("price") %></td>
										<td><%=rs.getString("qty") %></td>
										<td><%=rs.getString("total_ppu") %></td>
									</tr>
									<%}%>
								</tbody>
							</table>
							<br />
							<br />
							<div class="card-action">
								<p class="right grey lighten-2"
									style="padding-left: 30px; padding-right: 30px; padding-top: 6px; padding-bottom: 6px;">
									<b>TOTAL AMOUNT : </b> Rs. <%=amount %>/-
								</p>
								<br /> <br />
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</section>
	
	


	<!--Footer-->
	<footer class="section blue darken-4 grey-text text-lighten-3 center">
		<a href="invoice.jsp" class="brand-logo grey-text text-lighten-3"><i
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
<script>
var doc = new jsPDF();
var card = document.querySelector('#inv');
doc.fromHTML(card,2,2);
doc.save("Invoice.pdf");

doc.fromHTML();

</script>

</html>

<%
Connection con1;
PreparedStatement pst1;
ResultSet rs1;

Class.forName("com.mysql.jdbc.Driver");
con1 = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
pst1 = con1.prepareStatement("truncate table cart");
pst1.executeUpdate();


%>