<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
	String s = "";
	if(request.getAttribute("error") != null){
		s += "Invalid Login Credentials !!";  
	}
%>


<!DOCTYPE html>
<html>

<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize.min.css"
	media="screen,projection" />
<link type="text/css" rel="stylesheet" href="css/main.css" />

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>:: INV-MANAGER ::</title>
</head>

<body class="log-backg">

	<!--NavBar-->
	<nav class="blue darken-4" style="opacity: 0.6;">
		<div class="container">
			<div class="nav-wrapper">
				<a href="login.jsp" class="brand-logo white-text text-lighten-5"><i
					class="material-icons" style="font-size: 35px;">shopping_basket</i>Inv-Manager</a></a>
			</div>
		</div>
	</nav>

	<!--Login-->
	<section class="section section-login">
		<div class="container">
			<div class="row">
				<div class="col s10  m8 offset-m2 l6 offset-l3 offset-s1">
				<div class="card grey lighten-1 center">
					<span class="red-text text-darken-2 center"><b><%=s %></b></span>
				</div><br>
					<div class="card box">
						<div class="card-action blue darken-4 white-text">
							<h3 class="grey-text text-lighten-2 center">Login</h3>
						</div>
						<form action="Login" method="POST">
							<div class="card-content">
								<div class="input-field">
									<i class="material-icons prefix">email</i> <input type="email"
										id="email" name="email" class="grey-text" required /> <label
										for="username" class="grey-text">Email ID</label>
								</div>

								<div class="input-field">
									<i class="material-icons prefix">lock</i> <input
										type="password" id="password" name="password"
										class="grey-text" required /> <label for="password"
										class="grey-text">Password</label>
								</div>
								
								
								
								<div class="input-field center">
									<button type="submit" value="LOGIN"
										class="btn btn-medium blue darken-4 white-text waves-effect waves-light">
										<span class="grey-text text-lighten-2 center">Login</span> <i
											class="material-icons right grey-text text-lighten-2">send</i>
									</button>
								</div>

								<br />
								<p class="registerhere grey-text center">
									Dont have an account? <a href="registration.jsp"
										class="loginhere-link">Create an account</a>
								</p>
								<br />
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!--Import jQuery before materialize.js-->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>
	<script>
    $(document).ready(function () {
      // Custom JS  & jQuery here

      //Login-Modal
      $(".modal").modal();
    });
  </script>
</body>

</html>