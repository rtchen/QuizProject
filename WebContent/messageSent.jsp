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
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Message Sent</title>
</head>
<body>
<ex:push key="body.content">
	<h><a href="messages.jsp">Messages<%if (numMsgs >0) { %>(<%=numMsgs%>)<%}%></a>&nbsp;
	<a href="friendRequests.jsp">Friend Requests <%if (numReqs >0) { %>(<%=numReqs%>)<%}%></a>&nbsp;
	<a href="challenges.jsp">Challenges <%if (numChals >0) { %>(<%=numChals%>)<%}%></a>&nbsp;
	<a href="sentMessages.jsp">Sent Messages <%if (numSentMsgs >0) { %>(<%=numSentMsgs%>)<%}%></a>
	</h>
	<form method="post" action="compose.jsp">
          <input type="submit" value="Compose" />
   </form>
	<center><h> Message Sent </h></center>
	<a id="admin-link" href="index.jsp">Home</a>
	</ex:push>
	</body>
</html>