<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Register</title>
</head>
<body>

	<span>
		<h class="logo">Quiz It!</h>
		<p class="logo-word">"Test, Learn, and Share on Quiz It!"</p>
	</span>

 <% if(request.getParameter("bad") != null) { %>
        <div class="error_message">
                <strong>Account Exists:</strong> Sorry, an account with the username you
                have specified already exists. Please try again.
        </div>
        <% } %>
        <% if(request.getParameter("missing") != null) { %>
        <div class="error_message">
                <strong>Information Missing:</strong> Sorry, some required information is missing.
                Please try again.
        </div>
        <% } %>
        
        
        <div id="login-session">
		<p class="login-title">QUIZ IT! Create Account</p>
		<form method="post" action="RegisterServlet">
			<p>Username:<input class="textfield" name="username" type="username"></p>
			<p>Password: <input class="textfield" name="password" type="password"></p><br>
			<input class="button" type="submit" value="Register Now">
			<a href="login.jsp">Already a User? Login</a>
			
		</form>
		</div>
        
</body>
</html>