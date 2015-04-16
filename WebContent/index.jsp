<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*, java.text.*" %>
<%
User currentUser = (User) session.getAttribute("currentUser");
if (currentUser == null) { %>
	<jsp:forward page="home.jsp"/>
<% }
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat();
UserManager manager = new UserManager();
QuizManager quizM = new QuizManager();
quizM.deletePracticeAttempts();
quizM.deleteMalformedQuizzes();
currentUser = manager.getUser(currentUser.user_id);
session.setAttribute("currentUser", currentUser);
quizM.deletePracticeAttempts();
MessageManager mm = new MessageManager();
DecimalFormat df = new DecimalFormat("#.0");
int numNews = mm.numNewNotifications(currentUser.getUsername());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title><%= currentUser.username+"'s"%></title>
</head>
<body>

	<div class="realheader">
		<a href="home.jsp" class="logo">Quiz It!</a>
		<p class="logo-word">"Test, Learn, and Share on Quiz It!"</p>
		<form method="post" action="LogoutServlet">
			<input type="submit" class="small-button" id="logout-button" value="Logout">
		</form>
		<a id="admin-link" href="admin.jsp">Admin</a>
	</div>
	
<div class="realbody">	
	
	<div class="welcome">
		<h3>Welcome <%=currentUser.username %>!</h3>
	</div>
	<% String imgSrc = (currentUser.getPhotoURL() == null ? "default_profile.jpg" : currentUser.getPhotoURL()); %>
	<img src=<%=imgSrc%> width="200px" height="200px">
	<div id="information">
		<table class="quiz-information-table" id="index-information-table">
		 <tr><th><a href="Inbox.jsp">Inbox <%="("+numNews+")"%></a></th></tr> 
		 <link rel="stylesheet" type="text/css" href="jquery.autocomplete.css" />
    	<script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    	<script src="jquery.autocomplete.js"></script>  
    	<style>
        input {
            font-size: 120%;
        }
    	</style>
    		<tr>
          <form method="post" action="MessageServlet">
          		<th>Search for User</th>
    		<td><input type="text" id="receiver" name="receiver"/></td>
    	<script>
        	$("#receiver").autocomplete("searchbox.jsp");
    	</script>
              <td><input type="submit" name="search_friends" value="Go" class="small-button"></td>
         </form> 
         	</tr>
         	<link rel="stylesheet" type="text/css" href="jquery.autocomplete.css" />
    	<script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    	<script src="jquery.autocomplete.js"></script>  
    	<style>
        input {
            font-size: 120%;
        }
    	</style>
    		<tr>
          <form method="post" action="MessageServlet">
          		<th>Search for Quizzes</th>
    		<td><input type="text" id="quiz" name="quiz"/></td>
    	<script>
        	$("#quiz").autocomplete("searchQuizBox.jsp");
    	</script>
              <td><input type="submit" name="search_Quizzes" value="Go" class="small-button"></td>
         </form> 
         	</tr>
         	<tr>
          <form method="post" action="MessageServlet">
          		<th>Search By Tag</th>
    		<td><input type="text" id="quiz_tag" name="quiz_tag"/></td>
            <td><input type="submit" name="search_Quizzes_Tag" value="Find Quizzes" class="small-button"></td>
         </form> 
         	</tr>
         	<tr>  
         		<th>Update Photo URL</th>
         <form method="post" action="ChangePhotoServlet">
         		<td><input type="text" name="photo_url"></td>
         		<td><input type="submit" value="Update Photo" class="small-button"></td>
         </form>
         	</tr>
         <form method="post" action="SeeFriendServlet">
        	 <input type="hidden" name="current-user-id" value="<%=currentUser.user_id %>">
         <tr><th>My Friends:</th> 
			<td><select id="friend-select" name="friend-user-id">
			<% ArrayList<String> friends = currentUser.getFriends(); 
			for (String friendName : friends) { 
				User friend = manager.getUser(friendName);%>
				<option value=<%=friend.user_id%>><%=friend.username %></option>
			<%} %>
			</select></td>
			<td><input type="submit" class="small-button" value="See Profile"></td>
		</tr></form>
         </table>
	</div>             
       <div class="title-band"><p>Announcements</p></div>
        <%ArrayList<Announcement> announcements = Announcement.getAnnouncements(); 
       	if (announcements != null) {
       		 for(Announcement a : announcements) { %>     
                    <div class="announcement">
                    	<table><tr>
                    	<th><%=a.subject %></th>
                    	<td class="td1"><em>
                    		<%User user = manager.getUser(a.username); %>
                    	    Posted by <a href="profile.jsp?user=<%=user.user_id%>"><%=a.username %></a> on <%=sdf.format(a.postDate) %>
                        </em></td>
              		    </tr></table>   
              		    <p><%=a.body %></p>
              		</div>
            <% } %>
        
        <% }%>
        
     <div class="title-band"><p>Most Popular Quizzes</p></div>
        <table cellpadding="3" cellspacing="3" border="0">
        <tr>
                <th>Quiz Name</th>
                <th>Rating</th>
                <th>Date Created</th>
                <th>Average Score</th>
        </tr>
        <% ArrayList<Quiz> popular = quizM.getPopularQuiz(); 
                for (int i= 0; i < popular.size(); i++) {
                   Quiz q= popular.get(i);%>
        <tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=q.id%>"><%=q.title %></a></td>
                <td align="center"><%=df.format(q.getRating()) %></td>
                <td align="center"><%= q.creationDate.toString() %></td>
                <td align="center"><%=df.format(q.getAverageScore()) %></td>
        </tr>
        <%
        }
        %>
		</table>   

		<div class="title-band"><p>Recently Created Quizzes</p></div>
        <table cellpadding="3" cellspacing="3" border="0">
        <tr>
                <th>Quiz Name</th>
                <th>Date Created</th>
                <th>Rating</th>
                <th>Average Score</th>
        </tr>
        <% ArrayList<Quiz> recent = quizM.getRecent(); 
                for (int i = 0; i < recent.size(); i++) {
                  Quiz q = recent.get(i);%>
        <tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=q.id%>"><%=q.title %></a></td>               
                <td align="center"><%= q.creationDate.toString() %></td>
                <td align="center"><%=df.format(q.getRating()) %></td>
                <td align="center"><%=df.format(q.getAverageScore()) %></td>
        </tr>
        <%
        }
        %>
</table>     
         
        <div class="title-band"><p>My Quizzes</p></div> 
        <table cellpadding="3" cellspacing="3" border="0">
        
        <%   ArrayList<Quiz> my = quizM.getMyCreated(currentUser.username); 
        if (my == null || my.isEmpty()) {%>
        	<tr><th>You haven't created a quiz yet</th></tr>
        <% } else { %>
        <tr>
                <th>Quiz Name</th>
                <th>Date Created</th>
                <th>Rating</th>
                <th>Average Score</th>
        </tr>
       	<% for (int i = 0; i < my.size(); i++) {
            Quiz q = my.get(i);%>
        <tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=q.id%>"><%=q.title %></a></td>
                <td align="center"><%=q.creationDate.toString() %></td>
                <td align="center"><%=df.format(q.getRating()) %></td>
                <td align="center"><%=df.format(q.getAverageScore()) %></td>
        </tr>
        <%
        }}
        %>
</table>
		<button class="small-button" onClick="window.location.href='AddQuizInfo.jsp'">Create New Quiz</button>
         
        <div class="title-band"><p>My Recent Attempts <a style="color: #FFD800" href="history.jsp?user=<%=currentUser.user_id %>">(Full History)</a> </p></div> 
        <table cellpadding="3" cellspacing="3" border="0">
        <tr>
                <th>Quiz Name</th>
                <th>Started</th>
                <th>Score</th>
                <th>Action</th>
        </tr>
        <%   ArrayList<Attempt> recentA = quizM.getRecentAttemptbyUser(currentUser.username); 
        for (int i = 0; i < recentA.size(); i++) {
            Attempt a = recentA.get(i);%>
            <%if (a.practice) continue; %>
        	<tr>
                <td align="left"><a href="QuizInfo.jsp?id=<%=a.quizID%>"><%=quizM.getQuiz(a.quizID).title %></a></td>
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
	<%currentUser.giveAchievements(); %>
     <div class="title-band"><p>Achievements Earned</p></div> 
             <table cellpadding="3" cellspacing="3" border="0">
        <%    
           ArrayList<String> achievements=currentUser.getAchievements();
        for (int i = 0; i < achievements.size(); i++) {
            String a = achievements.get(i);%>
        <tr>
                <td align="left"> <%=a%> </td>
         
        </tr>
        <%
        }
        %>
        </table>   
</div>
</body>
</html>