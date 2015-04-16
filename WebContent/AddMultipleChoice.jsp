<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<% int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Add Multiple Choice</title>
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
<p>Please enter all relevant information about the question here.</p>
<form method="post" action="AddQuestion">
<table width="800" cellspacing="3" cellpadding="3" border="0">
        <tr>
                <th width="150">Question Text</th>
                <td width="650">
                        <textarea name="question_text" style="width:500px;height:80px;"></textarea>
                </td>
        </tr>
</table>
<h3>Correct Options</h3>
<p>You can add one correct option and multiple incorrect options</p>

<table id="tblOptions_correct" width="700" cellspacing="6" cellpadding="6" border="0">
        <tr>
                <th width="500">Correct Options</th>
                
        </tr>
        <tbody>
  
                <tr>
                        <td><input type="text" name="correct_answers" style="width:100%"></td>
                       
                </tr>
                
        </tbody>
</table>
<h3>Incorrect Options</h3>
<p>We support Gradiance-style quizzes. You can enter multiple incorrect options
   and specify how many options to appear. The selection will be randomized every time the user
   takes the quiz.</p>

<table id="tblOptions_incorrect" width="700" cellspacing="6" cellpadding="6" border="0">
        <tr>
                <th width="500">Incorrect Options</th>
                
        </tr>
        <tbody>
                <%
                for(int i =0;i<5;i++) {
                %>
                <tr>
                        <td><input type="text" name="incorrect_answers" style="width:100%" ></td>
                        
                </tr>
                <%
                }
                %>
        </tbody>
</table>
<input type = "hidden" name = "quiz_id" value = "<%= quiz_id %>">
<input type = "hidden" name = "questionType" value ="MultiChoice">
<input type="submit" class="button" value="Add Question">
</form>
</div>
</body>
</html>