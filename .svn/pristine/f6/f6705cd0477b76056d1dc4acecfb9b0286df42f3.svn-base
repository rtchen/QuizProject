<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="backend.*, java.util.*" %>
<% int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Add Mult-Answer</title>
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
<form method="post" action="AddQuestion">
<table width="700" cellspacing="3" cellpadding="3" border="0">
        <tr>
                <th>Question Text</th>
                <td>
                        <textarea name="question_text" style="width:500px;height:80px;"></textarea>
                </td>
        </tr>
</table>
<h3>Solutions</h3>
<table id="tblOptions" width="400" cellspacing="6" cellpadding="6" border="0">
        <thead>
                <tr>
                       
                        <th width="400">Solution Text, we add 1 point for every correct answer</th>
                        
                </tr>
        </thead>
        <tbody>
<%
for(int i=0;i<5;i++) {
       
%>
<tr>
       
        <td><input type="text" name="correct_answers" style="width:100%" value=""></td>
        
</tr>
<%
 
}
%>
        </tbody>
</table>

<input type = "hidden" name = "quiz_id" value = "<%= quiz_id %>">
<input type="hidden" name = "questionType" value="MultiAnswer">
<input type="submit" class="button" value="Add Question">
</form>
</div>
</body>
</html>