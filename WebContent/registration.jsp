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
<title>:: INV-MANAGER ::</title>
</head>

<body class="x">
	<!--NavBar-->
	<nav class="blue darken-4" style="opacity: 0.6;">
		<div class="container">
			<div class="nav-wrapper">
				<a href="login.jsp" class="brand-logo white-text text-lighten-5"><i
					class="material-icons" style="font-size: 35px;">shopping_basket</i>Inv-Manager</a>
			</div>
		</div>
	</nav>

	<!--Registration-->
	<section class="regis-class">
		<div class="container">
			<div class="row">
				<div class="col s12 m8 l6">
					<div class="card box">
						<div class="card-action blue darken-4 white-text">
							<h3 class="grey-text text-lighten-2 center">REGISTER</h3>
						</div>


						<form id="form" action="Registration" method="POST" onsubmit="return myFunction()">

							<div class=" card-content">

								<div class="input-field">
									<i class="material-icons prefix">account_circle</i> <input
										type="text" id="name" name="name"
										class="grey-text transparent" required /> <label for="name"
										class="grey-text">Name</label>
								</div>

								<div class="input-field">
									<i class="material-icons prefix">email</i> <input type="email"
										id="email" name="email" class="grey-text transparent" required />
									<label for="email" class="grey-text">Email ID</label>
								</div>

								<div class="input-field">
									<i class="material-icons prefix">account_circle</i> <input
										type="text" id="username" name="username"
										class="grey-text transparent" required /> <label
										for="username" class="grey-text">Username</label>
								</div>

								<div class="input-field">
									<i class="material-icons prefix">phone</i> <input type="text"
										id="phone" name="phone" class="grey-text transparent" required />
									<label for="phone" class="grey-text">Phone no.</label>
								</div>

								<div class="input-field">
									<i class="material-icons prefix">lock</i> <input
										type="password" id="password" name="password"
										class="grey-text transparent" required /> <label
										for="password" class="grey-text">Password</label>
								</div>


								<div class="input-field">
									<i class="material-icons prefix">lock</i> <input
										type="password" id="password1" name="password1"
										class="grey-text transparent" required /> <label
										for="password1" class="grey-text">Confirm Password</label>
								</div>

								<div class="input-field center">
									<button type="submit" value="Register" id="button"
										class="btn btn-medium blue darken-4 white-text waves-effect waves-light">
										<span class="grey-text text-lighten-2 center">Submit</span> <i
											class="material-icons right grey-text text-lighten-2">send</i>
									</button>
								</div>
								<br>
								<p class="loginhere grey-text center">
									Have already an account ? <a href="login.jsp"
										class="loginhere-link">Login here</a>
								</p>
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
    	
    });
 	
    var password=document.getElementById("password");

    password.onblur=function()
    {
    	  var lowerCaseLetters = /[a-z]/g;
    	  var numbers = /[0-9]/g;
    	  var upperCaseLetters = /[A-Z]/g;


    	  if(password.value.match(lowerCaseLetters)&&password.value.match(upperCaseLetters)&& password.value.match(numbers)&&password.value.length >= 8) {  
    	  	
    	  } 
    	  else
    		  {	
    		  
    		  	alert("Password Not Strong Enough!\r\nPassword length should be 8 characters with one Uppercase letter and one digit..");
    		
    		  }
    	}
    
	
    var password1=document.getElementById("password1");

    password1.onblur=function()
    {
    	// Validate lowercase letters
    	  if(password.value!==password1.value){
    		  alert("Passwords Do Not Match!");
    	  }
    	  else{

    	  }
    }
  </script>

	
</body>

</html>