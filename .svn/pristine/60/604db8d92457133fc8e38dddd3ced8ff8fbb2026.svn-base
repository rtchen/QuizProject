<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Quiz It!</title>


</head>
<body>
	<div id="homepage">
		<span>
			<a href="home.jsp" class="logo">Quiz It!</a>
			<p class="logo-word">"Test, Learn, and Share on Quiz It!"</p>
		</span>
		
		<div id="band">
			<div id="text">
				<p>Quiz It! makes it possible for you to show off your intellectual prowess by taking quizzes on a wide range of subjects, comparing your quiz scores to friends, challenging friends to beat your score, and writing quizzes that other people can take.</p>
			</div>
			
				<%
					User currentUser = (User) session.getAttribute("currentUser");
					String value = "Login";
					String location = "window.location.href='login.jsp'";
					if (currentUser != null) {
						location = "window.location.href='index.jsp'"; 
						value = currentUser.username + "'s Account";
					}
				%>
					
			<input class="button" type="button" value=<%=value %> onclick=<%=location %>>
		</div>
	</div>
</body>
</html>