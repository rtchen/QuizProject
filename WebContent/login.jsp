<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Login</title>
</head>
<body>
	<span>
		<a href="home.jsp" class="logo">Quiz It!</a>
		<p class="logo-word">"Test, Learn, and Share on Quiz It!"</p>
	</span>
	
	
	
<% if(request.getParameter("bad")!=null) {
		if (request.getParameter("bad").equals("1")) { %>
        <div class="error_message">
                Sorry, you have entered either the wrong username
                or password. Please try again.
        </div>
<% } else if(request.getParameter("bad").equals("2")) { 
		String prevName = request.getParameter("prev");%>
        <div class="error_message">
                Thank you <%=prevName%>! You are now logged out. Please login to continue on Quiz It!
        </div>
<% } else if(request.getParameter("bad").equals("3")) { %>
    <div class="error_message">
            You are not an administrator. Please login as an admin account to proceed.
    </div>
<% }} %>


	<div id="login-session">
		<p class="login-title">QUIZ IT! Login</p>
		<form method="post" action="LoginServlet">
			<p>Username:<input class="textfield" name="username" type="username"></p>
			<p>Password: <input class="textfield" name="password" type="password"></p><br>
			<div id="rememberme_checkbox"><input name="remember" type="checkbox" checked="true"> Remember me</div>
			<input class="button" type="submit" value="Login">
			<a href="register.jsp">Create New Account</a>
			
			
		</form>
	</div>
	
 
</body>
</html>