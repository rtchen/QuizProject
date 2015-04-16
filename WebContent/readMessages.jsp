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
	QuizManager qm = new QuizManager();
	UserManager um = new UserManager();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat();
	int numReqs = mm.numFriendRequests(currentUser.getUsername());
	int numMsgs = mm.numNewMessages(currentUser.getUsername());
	int numChals = mm.numChallenges(currentUser.getUsername());
	int numSentMsgs = mm.numSentMessages(currentUser.getUsername());
	int msgID = Integer.parseInt(request.getParameter("msg_id"));
	Message m = mm.getMessage(msgID);
	mm.markRead(msgID);
	User sender = um.getUser(m.getSender());
	int quizID = -1;
	Quiz challenge= null;
	if (m.getMessageType().equals("Challenge")) {
    	quizID = m.getQuizID();
    	challenge = qm.getQuiz(quizID);
	}
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Read Messages</title>
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
   		<%if (quizID!= -1) { %>
                <tab><h3><%=sender.getUsername()%> has challenged you to take <a href="QuizInfo.jsp?id=<%=quizID%>"><%=challenge.getTitle()%></a>!</h3>
        <%} else { %>
                <tab><h3><%=m.getSubject() %></h3>
        <%} %>
        <div>
                <table cellspacing="2" cellpadding="2" border="0">
                        <tr>
                                <th align="left" width="10%">From </th>
                                <td align="left"><a href="profile.jsp?user=<%=sender.user_id%>"><%=sender.getUsername() %></a></td>
                        </tr>
                        <tr>
                                <th align="left" width="10%">Sent </th>
                                <td align="left"><%=sdf.format(m.getDate())%></td>
                        </tr>
                </table>
        </div>
        <br>
        <div>
                <tab><font size="4"><textarea readonly style="width:500px;height:150px"><%=m.getSubject()%></textarea></font></tab>
        </div>
        <br>
        <%if (quizID!= -1) { %>
                <form method="post" action="QuizInfo.jsp?id=<%=quizID%>">
                <input type="submit" value="Accept"/>
                </form>
                <form method="post" action="MessageServlet">
                        <input type="hidden" name="msg_id" value="<%=msgID%>">                  
                        <input type="submit" name="read_update" value="Delete">
         </form>
        <%} 
        else if (m.getMessageType().equals("FriendRequest")) {%>
        	 <form method="post" action="MessageServlet">
        	 <input type="hidden" name="friend" value="<%=sender.getUsername()%>"> 
             <input type="submit" name ="accept_friend" value="Accept"/>
             </form>
             <form method="post" action="MessageServlet">
                        <input type="hidden" name="msg_id" value="<%=msgID%>">                  
                        <input type="submit" name="read_update" value="Ignore">
         	</form>
		<%}
        else{%>        
        <br>
        <form method="post" action="compose.jsp">
                        <input type="hidden" name="receiver" value="<%=sender.getUsername()%>">                  
                        <input type="submit" name="compose_Message" value="Reply">
         </form>
   		<form method="post" action="MessageServlet">
                        <input type="hidden" name="msg_id" value="<%=msgID%>">                  
                        <input type="submit" name="read_update" value="Delete">       
         </form>
         <%}%>
         </tab> 
         <a id="admin-link" href="index.jsp">Home</a>
</ex:push>
</body>
</html>