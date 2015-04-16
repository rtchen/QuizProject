<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@page import="backend.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	User currentUser = (User) session.getAttribute("currentUser");
	if (currentUser == null) 
	{  
	  response.sendRedirect("login.jsp");  
	  return;  
	}
	MessageManager mm = new MessageManager();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat();
	int numReqs = mm.numFriendRequests(currentUser.getUsername());
	int numMsgs = mm.numNewMessages(currentUser.getUsername());
	int numChals = mm.numChallenges(currentUser.getUsername());
	int numSentMsgs = mm.numSentMessages(currentUser.getUsername());
	UserManager userManager = new UserManager();
	ArrayList<String> friendsNames = currentUser.getFriends();
	ArrayList<String> userNames = userManager.getUsers();
	
	int challengeID = -1;
	double topScore= -1.0;
	String chalSubject="", challenge="";
	if (request.getParameter("challenge") != null) {
        topScore = Double.parseDouble(request.getParameter("high_score"));
        challengeID = Integer.parseInt(request.getParameter("quiz_id"));
        QuizManager quizManager = new QuizManager();
        Quiz qz = quizManager.getQuiz(challengeID);
        chalSubject = currentUser.getUsername() + " has sent you a challenge to take " + qz.getTitle() + "!";
        challenge = currentUser.getUsername() + "'s highest score was " + topScore + ". It's your turn to challenge " + currentUser.getUsername();
	}
	String friendReqSubject="", friendReq="";
	if (request.getParameter("friendrequest") != null) {
        friendReqSubject = currentUser.getUsername() + " wants to add you as a friend.";
        friendReq = "Hi. This is "+ currentUser.getUsername() + ". Nice meeting you. ";
        
	}
	 String receiver = request.getParameter("receiver");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Compose</title>
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
<ex:push key="body.content">
	<h><a href="messages.jsp">Messages (<%=numMsgs%>)</a>
	<a class="inbox-cat" href="friendRequests.jsp">Friend Requests (<%=numReqs%>)</a>
	<a class="inbox-cat" href="challenges.jsp">Challenges (<%=numChals%>)</a>
	<a class="inbox-cat" href="sentMessages.jsp">Sent Messages (<%=numSentMsgs%>)</a>
	</h>
<%if(challengeID != -1){ %>
        <h3>Send a Challenge</h3>
<%}
else if(!friendReq.equals("")){%>
		<h3>Add a Friend</h3>
<%}
else if(receiver!=null){%>
<h3>Reply</h3>
<%}
else{%>
        <h3>Compose New Message</h3>
<%}%>
        <div><form method="post" action="MessageServlet">
                <table>
                        <tr>
                        <th align="left" width="10%">To </th>
                                <td align="left">
                                <% if (receiver==null&&friendReq.equals("")) { %>        
                        
                                        <input id="receiver" name= "receiver" type="text" style="width:400px" value="" />
                                       
                                        <select id="action-select" name="type" id="friend_dropdown">
                                                <option>Select a friend</option>
                                        <% for (int i = 0; i < friendsNames.size(); i++) { 
                                        %>
                                                <option value="<%=friendsNames.get(i)%> "><%=friendsNames.get(i)%></option>
                                        <%} %>
                                        </select>
                                        <script>
                                                var textBox = document.getElementById('receiver');
                                                
                                                var dropDown = document.getElementById('friend_dropdown');
                                                dropDown.onchange = function() {
                                                        var info = dropDown.value.split(",");
                                                        textBox.value = info[0];
                                                      
                                                };
                                        </script>
                                <%}
                                else if(receiver==null&&!friendReq.equals("")) { %>
                                <input id="receiver" name= "receiver" type="text" style="width:400px" value="" />
                                       
                                        <select name="type" id="user_dropdown">
                                                <option>User Search</option>
                                        <% for (int i = 0; i < userNames.size(); i++) { 
                                        	//User u = users.get(i);
                                        	String username = userNames.get(i);
                                        	if(!friendsNames.contains(username)&&!currentUser.getUsername().equals(username)){
                                        %>
                                                <option value="<%=username%> "><%=username%></option>
                                        	<%}%>
                                        <%}%>
                                        </select>
                                        <script>
                                                var textBox = document.getElementById('receiver');
                                                
                                                var dropDown = document.getElementById('user_dropdown');
                                                dropDown.onchange = function() {
                                                        var info = dropDown.value.split(",");
                                                        textBox.value = info[0];
                                            	};
                                        </script>
                                <%}
                                else{%>
                                        <input id="receiver" name= "receiver" type="text" style="width:400px" value="<%=receiver%>" readonly/>
                                <%} %>
                                </td>
                        </tr>
                        <tr>
                                <th align="left" width="10%">Subject </th>
                                <%if (challengeID != -1) { %>
                                        <td align="left"><%=chalSubject%><input name="subject" type="hidden" value="<%=chalSubject %>"></td>
                                <%}
                                else if(!friendReq.equals("")) { %>
                                <td align="left"><%=friendReqSubject%><input name="subject" type="hidden" value="<%=friendReqSubject %>"></td>
                                <%}
                                else{%>
                                        <td align="left"><input name="subject" type="text" style="width:500px" value=""/></td>
                                <%}%>
                        </tr>
                        <tr>
                                <th align="left" width="10%">Message</th>
                                <%if (challengeID != -1) { %>
                                        <td><textarea name="message" style="width:500px;height:150px"><%=challenge%></textarea></td>
                                <%}
                                else if(!friendReq.equals("")){ %>
                                		<td><textarea name="message" style="width:500px;height:150px"><%=friendReq%></textarea></td>
                                <%}
                                else{ %>
                                        <td><textarea name="message" style="width:500px;height:150px"></textarea></td>
                                <%} %>
                        </tr>
                        <tr>
                                <th></th>
                                <%if (challengeID!= -1) { %>
                                        <td>
                                                <input type="hidden" name="quiz_id" value="<%=challengeID%>">
                                                <input type="hidden" name="high_score" value="<%=topScore %>">
                                                <input type="submit" class="small-button" name ="send_challenge" value="Send">&nbsp;&nbsp;<input id="inbox-action-button" class="small-button" type="submit" value="Cancel"/>
                                        </td>
                                <%}
                               	else if(!friendReq.equals("")) { %>
                                		 <td><input type="submit" id="inbox-action-button" class="small-button" name ="friend_request" value="Send">&nbsp;&nbsp;<input id="inbox-action-button" class="small-button" type="submit" value="Cancel"/></td>
                                <%}
                                else{%>
                                        <td><input type="submit" id="inbox-action-button" class="small-button" name ="compose_message" value="Send">&nbsp;&nbsp;<input id="inbox-action-button" class="small-button" type="submit" value="Cancel"/></td>
                                 <%}%>
                        </tr>
                </table>
        </form></div><br>
</ex:push>
</div>
</body>
</html>
