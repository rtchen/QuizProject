<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="backend.*, java.util.*" %>
<% int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Add Menu</title>
</head>
<body>

<div class="realheader">
		<a href="home.jsp" class="logo">Quiz It!</a>
		<p class="logo-word">"Test, Learn, and Share on Quiz It!"</p>
		<form method="post" action="LogoutServlet">
			<input type="submit" class="small-button" id="logout-button" value="Logout">
		</form>
		<a id="admin-link" href="index.jsp">Home</a>
	</div>
	
<div class="realbody">

 <p> <a href="AddFillBlank.jsp?quiz_id=<%=quiz_id %>" >Add Fill in the Blank Question</a></p>
<p>  <a href="AddQResponse.jsp?quiz_id=<%=quiz_id %>" >Add Question Response Question</a></p>
<p>  <a href="AddMultipleChoice.jsp?quiz_id=<%=quiz_id %>" >Add Multiple Choice Question</a></p>
 <p> <a href="AddPictureResponse.jsp?quiz_id=<%=quiz_id %> ">Add Picture Response Question</a></p>
  <p> <a href="AddMultiAnswer.jsp?quiz_id=<%=quiz_id %>" >Add Multiple Answers Question</a></p>
  <button class="button" onClick="window.location.href='index.jsp'">Done!</button>
   
</div>   
</body>
</html>