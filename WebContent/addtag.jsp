<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<% int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Add Tag</title>
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
<form method="post" action="AddTagServlet">


<table id="tblOptions" width="400" cellspacing="6" cellpadding="6" border="0">
        <thead>
                <tr>
                       
                        <th width="400">Tags</th>
                        
                </tr>
        </thead>
        <tbody>
<%
for(int i=0;i<1;i++) {
       
%>
<tr>
       
        <td><input type="text" name="tags" style="width:100%" value=""></td>
        
</tr>
<%
 
}
%>
        </tbody>
</table>

<input type = "hidden" name = "quiz_id" value = "<%= quiz_id %>">
<input type="submit" class="small-button" value="Add Tags">
</form>
</div>
</body>
</html>