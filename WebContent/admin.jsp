<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
User currentUser = (User) session.getAttribute("currentUser");
String message = (String) session.getAttribute("message");
if (message == null) message = "Welcome Administrator " + currentUser.username + "!";
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat();
UserManager manager = new UserManager();
QuizManager quizM = new QuizManager();
if (currentUser == null) {%>
	<jsp:forward page="login.jsp"/>
<% } else if (!currentUser.is_admin) { %>
	<jsp:forward page="login.jsp?bad=3"/>
<% }%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Admin</title>
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
	<div class="welcome">
		<h3><%=message %></h3>
		<% session.setAttribute("message", null); %>
	</div>

	<div class="title-band"><p>Announcements</p></div>
	<%ArrayList<Announcement> announcements = Announcement.getAnnouncements(); %>
        <% for(Announcement a : announcements) { %>     
                <div class="announcement">
                	<table><tr>
                	<th><%=a.subject %></th>
                	<td class="td1"><em>
                		<%User user = manager.getUser(a.username); %>
                	    Posted by <a href="profile.jsp?user=<%=user.user_id%>"><%=a.username %></a> on <%=sdf.format(a.postDate) %>
                    </em></td>
                    <td><a class="delete-link" href="DeleteAnnouncementServlet?announcement_id=<%=a.announcement_id %>">Delete</a></td>
          		    </tr></table>   
          		    <p><%=a.body %></p>
          		</div>
        <% } %>
    
    <div id="announce-form">
     	<form method="post" action="AnnounceServlet">
     		Subject:<input id="announce-subject" type="text" name="subject"> 
     		<input type="submit" class="small-button" value="Post New Announcement"><br>
     		<textarea rows="4" cols="60" name="body">Enter text here...</textarea>
			
		</form>
    </div>
    
    <div class="title-band"><p>Site Statistics</p></div>
   	<div class="announcement">
   		<table> 
   		<tr>
   		<th>Quizzes Created:</th>
   		<td class="td1"><%=quizM.getNumQuizzes() %></td>
   		</tr>
   		<tr>
   		<th>Quizzes Taken:</th>
   		<td class="td1"><%=quizM.getNumAttempts() %></td>
   		</tr>
   		<tr>
   		<th>Number of Users:</th>
   		<td class="td1"><%=manager.getNumUsers() %></td>
   		</tr>
   		</table>
   	
   	</div>
   
   
    <div class="title-band"><p>User Accounts</p></div>
    	<div class="promote-form">
    	
    		<form method="post" action="RemoveUserServlet">
    			<table>	<tr>
    			<th>Remove user account:</th>
     			<td class="td1"><select name="userToChange">
     				<% ArrayList<String> users = manager.getUsers();
     				if (users!=null) {
     				for (String username: users) {
     					User user = manager.getUser(username);%>
     					<option value=<%=username%>><%=username %></option>
     				<% }%>
				</select></td>
     			<td class="td2"><input type="submit" class="small-button" value="Remove"></td>
     			</tr></table>
			</form>
    		
    		<form method="post" action="PromoteServlet">
    			<table>	<tr>
    			<th>Promote selected user to Administrator:</th>
     			<td class="td1"><select name="userToChange">
     				<% for (String username: users) {
     					User user = manager.getUser(username); 
     					if (!user.is_admin) {%>
     					<option value=<%=username%>><%=username %></option>
     					<% }%>
     				<% }%>
				</select></td>
     			<td class="td2"><input type="submit" class="small-button" value="Promote"></td>
     			</tr></table>
			</form>
			
			<form method="post" action="DowngradeServlet">
				<table>	<tr>
    			<th>Downgrade selected Administrator to regular user:</th>
				<td class="td1"><select name="userToChange">
     				<% for (String username: users) {
     					User user = manager.getUser(username); 
     					if (user.is_admin) {%>
     					<option value=<%=username%>><%=username %></option>
     					<% }%>
     				<% }}%>
				</select></td>
     			<td class="td2"><input type="submit" class="small-button" value="Downgrade"></td>
     			</tr></table>
			</form>
		</div>
		
		<div class="title-band"><p>Quizzes</p></div>
		<%ArrayList<Quiz> quizzes = quizM.getAllQuizzes(); %>
        <% for(Quiz q : quizzes) { %>
                <div class="announcement">
                	<table><tr>
                	<th><a href="QuizInfo.jsp?id=<%=q.id%>"><%=q.title %></a></th>
                	<td class="td1"><em>
                		<%User user = manager.getUser(q.creator); %>
                	    Created by <a href="profile.jsp?user=<%=user.user_id%>"><%=q.creator %></a> on <%=sdf.format(q.creationDate) %>
                    </em></td>
                    <td class="td2"><a href="QuizInfo.jsp?id=<%=q.id%>">Clear History</a></td>
                    <td><a href="DeleteQuizServlet?quiz_id=<%=q.id %>">Delete</a></td>
          		    </tr></table>   
          		    <p><%=q.description %></p>
          		 </div>
        <% } %>
</div>
</body>
</html>