<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="backend.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
User currentUser = (User) session.getAttribute("currentUser");
UserManager userManager = new UserManager();
QuizManager quizManager=new QuizManager();
quizManager.deletePracticeAttempts();
User user = userManager.getUser(Integer.parseInt(request.getParameter("user")));
ArrayList<Attempt> history = user.getHistory(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>User History</title>
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
<div class="title-band"><p>Complete History</p></div> 
<table cellpadding="3" cellspacing="3" border="0">
	<tr>
    	<th>Quiz Name</th>
		<th>Started</th>
        <th>Score</th>
        <th>Action</th>
   	</tr>
    <% for (int i = 0; i < history.size(); i++) {
       		Attempt a = history.get(i);%>
            <%if (a.practice) continue; %>
        	<tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=a.quizID%>"><%=quizManager.getQuiz(a.quizID).title %></a></td>
                <td align="center"><%=a.start.toString() %></td>
                <td align="center"><%=a.finished ? (a.points) : "Not complete" %></td>
                <td align="center"><%=a.finished ? 
                                "<a href='result.jsp?attempt_id=" + a.attempts_id + "'>View Results</a>" : 
                                "<a href='attempt.jsp?attempt_id=" + a.attempts_id + "'>Continue</a>" %></td>
        	</tr>
        <%
        }
        %>
</table>   

</div>
</body>
</html>