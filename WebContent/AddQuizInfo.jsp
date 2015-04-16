<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<%
User currentUser = (User) session.getAttribute("currentUser");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Add a quiz</title>
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

<form method="post" action="AddQuizInfo">
                <table cellspacing="3" cellpadding="3" border="0">
                        <tr>
                                <th>Quiz Title</th>
                                <td><input name="quiz_title" type="text" size="60"  /></td>
                        </tr>
                        <tr>
                                <th>Description</th>
                                <td><textarea name="description" style="width:500px;height:150px"></textarea></td>
                        </tr>
                        <tr>
                                <th>Multiple Pages</th>
                                <td><input type="checkbox" name="multiple_pages" value = "true"> I want the quiz to have span multiple pages (one for each question).</td>
                        </tr>
                        <tr>
                                <th>Random Questions</th>
                                <td><input type="checkbox" name="random_questions" value = "true" > I want question order to be randomized.</td>
                        </tr>
                        <tr>
                                <th>Immediate Correction</th>
                                <td><input type="checkbox" name="immediate_correction" value = "true"> I want individual questions graded immediately (applicable to quizzes that span multiple pages only).</td>
                        </tr>
                        <tr>
                                <th>Practice Mode</th>
                                <td><input type="checkbox" name="practice_mode" value = "true">  I want to allow this quiz to be taken without a score.</td>
                        </tr>
                        <tr>
                           		<th></th>
                                <td><input type="submit" class="button" value="Add this Quiz"></td>
                        </tr>
                </table>
                
        </form>
</div>
</body>
</html>