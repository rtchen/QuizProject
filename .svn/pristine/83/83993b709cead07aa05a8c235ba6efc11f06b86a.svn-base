<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<% User currentUser = (User) session.getAttribute("currentUser");
String username = currentUser.username;
int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Write Review</title>
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

<h3>Question</h3>
<form method="post" action="RateQuiz">
<table width="700" cellspacing="3" cellpadding="3" border="0">
        <tr>
                <th>Write your review</th>
                <td>
                        <textarea name="review" style="width:500px;height:80px;"></textarea>
                </td>
        </tr>
</table>
<h3>Stars</h3>
<select name="stars" id="star-num-select">
     				<% for(int i =0;i<=5;i++){ %>     					
     					<option value=<%=i%>><%=i %></option>
     				<% }%>
</select>

<input type = "hidden" name = "username" value = "<%=username %>">
<input type = "hidden" name = "quiz_id" value = "<%=quiz_id %>">
<input type="submit" class="small-button" value="Submit this Review">
</form>

</div>
</body>
</html>