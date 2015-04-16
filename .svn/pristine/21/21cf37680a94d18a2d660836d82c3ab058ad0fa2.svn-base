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
if (user.user_id == currentUser.user_id) { %>
	<jsp:forward page="index.jsp"/>
<% }%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title><%=user.username %></title>
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
	<div class="title-band"><p><%=user.username %>'s Information</p></div>
	<% String imgSrc = (user.getPhotoURL() == null ? "default_profile.jpg" : user.getPhotoURL()); %>
	<img src=<%=imgSrc%> width="200px" height="200px">
	<% if (user.isFriendWith(currentUser)) { %>
		<button id="afb" class="small-button" onClick="window.location.href='FriendServlet?way=unfriend&id=<%=currentUser.user_id%>&fid=<%=user.user_id%>'">Unfriend</button>
	<% } else { %>
		<button id="afb" class="small-button" onClick="window.location.href='FriendServlet?way=friend&id=<%=currentUser.user_id%>&fid=<%=user.user_id%>'">Friend</button>
	<% } %>
	
	<div class="user-information">
		<form method="post" action="SeeFriendServlet">
			<input type="hidden" name="current-user-id" value="<%=currentUser.user_id %>">
		<table class="quiz-information-table">
			<tr><th>Name:</th> <td><%=user.username %></td></tr>	
			<tr><th>Join Date: </th> <td><%=user.getJoinDate().toString() %></td></tr>
			<tr><th>Friends:</th> 
			<td><select id="friend-select" name="friend-user-id">
			<% ArrayList<String> friends = user.getFriends(); 
			for (String friendName : friends) { 
				User friend = userManager.getUser(friendName);%>
				<option value=<%=friend.user_id%>><%=friend.username %></option>
			<%} %>
			</select></td>
			<td><input type="submit" class="small-button" value="See Profile"></td>
			</tr>
		</table>
		</form>
	</div>
	
	<div class="title-band"><p><%=user.username %>'s Quizzes</p></div> 
        <table cellpadding="3" cellspacing="3" border="0">
        <tr>
                <th>Quiz Name</th>
                <th>Date Created</th>
        </tr>
        <%   ArrayList<Quiz> my = quizManager.getMyCreated(user.username); 
        for (int i = 0; i < my.size(); i++) {
            Quiz q = my.get(i);%>
        <tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=q.id%>"><%=q.title %></a></td>
                <td align="center"><%=q.creationDate.toString() %></td>
        </tr>
        <% }%>
        </table>
        
     <div class="title-band"><p>Recent Attempts</p></div> 
        <table cellpadding="3" cellspacing="3" border="0">
        <tr>
                <th>Quiz Name</th>
                <th>Started</th>
                <th>Score</th>
                <th>Action</th>
        </tr>
        <%   ArrayList<Attempt> recentA = quizManager.getRecentAttemptbyUser(user.username); 
        for (int i = 0; i < recentA.size(); i++) {
            Attempt a = recentA.get(i);%>
        <tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=a.quizID%>"><%=quizManager.getQuiz(a.quizID).title %></a></td>
                <td align="center"><%=a.start.toString() %></td>
                 <td align="center"><%=a.finished ? (a.points) : "Not complete" %></td>
                 <td align="center"><%=a.finished ? 
                                "<a href='result.jsp?attempt_id=" + a.attempts_id + "'>View Results</a>" : 
                                "<a href='attempt.jsp?attempt_id=" + a.attempts_id + "'>Continue</a>" %></td>
        </tr>
        <% }%>
	</table>
	
	<div class="title-band"><p><%=user.username %>'s Achievements</p></div> 
        <table cellpadding="3" cellspacing="3" border="0">
        <%    ArrayList<String> achievements=user.getAchievements();
        for (int i = 0; i < achievements.size(); i++) {
            String a = achievements.get(i);%>
        <tr>
                <td align="left"> <%=a%> </td>
         
        </tr>
        <% }%>
        </table>
</div>
</body>
</html>