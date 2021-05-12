<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
String name = (String) session.getAttribute("email");
	if(name==null){
		response.sendRedirect("login.jsp");
	}
%>


<%@page import="java.sql.*"%>
<%@ page import="java.util.*" %>


<!DOCTYPE html>
<html>

<head>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/26ff23e897.js" crossorigin="anonymous"></script>
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css" media="screen,projection" />
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
                    <li class="active"><a href="yourorder.jsp">YOUR ORDERS</a></li>
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
        <li class="active"><a href="yourorder.jsp">Your Orders</a></li>
        <li><a href="login.jsp">Logout</a></li>
    </ul>

    <!--Orders Section-->
    <section class="section section-update section-orders ord">
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <div class="card grey lighten-2 box">
                        <div class="card-action grey darken-4 grey-text text-lighten-3 center">
                            <h5><i class="fas fa-history left"></i>ORDER HISTORY<i class="fas fa-history right"></i></h5>
                        </div>
                        <div class="card-content">
                        
                            <table class="centered highlight">
                                <thead>
                                    <tr>
                                    	<th>ORDER DATE & TIME</th>
                                        <th>ORDER INFO</th>
                                    </tr>
                                </thead>
                                <%
										
                                		Connection con;
										PreparedStatement pst;
										ResultSet rs;
	
										Class.forName("com.mysql.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
										
										pst = con.prepareStatement("select * from orders where cust_name = ?");
				                        pst.setString(1, name);
				                        
				                        rs = pst.executeQuery();
				                        
										while (rs.next()) {
																							
											
									%>
                                

                                <tbody>
                                    <tr>
                                        <td><%=rs.getString("order_date_time")%></td>
                                        <td><%=rs.getString("order_details")%></td>
                                    </tr>
                                </tbody>
                                <% } %>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <!--Footer-->
    <footer class="section blue darken-4 grey-text text-lighten-3 center">
        <a href="yourorder.jsp" class="brand-logo grey-text text-lighten-3"><i
			class="material-icons" style="font-size: 38px;">shopping_basket</i></span></a>
    </footer>

    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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