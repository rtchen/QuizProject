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
<link rel="stylesheet" type="text/css" href="global.css">
<title>Inbox</title>
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
	<form method="post" action="compose.jsp">
          <input class="small-button" type="submit" value="Compose" />
   </form>
	<%
       ArrayList<Message> messages = currentUser.getReceivedMessages();
       if (messages.isEmpty()) {
               %><center><h> No new mail! </h></center><% 
       } else {
     %>
        <form method="post" action="MessageServlet">
        <fieldset style="border:0 none;">
        <table >
        		<tbody>
            	<%        
					for(int i = 0; i < messages.size(); i++) {
                        Message msg = messages.get(i);
                        if(msg.getMessageType().equals("General")){
                        UserManager userManager = new UserManager();
                        String senderName = msg.getSender();
                        User sender = userManager.getUser(senderName);
                        if(sender!=null){
                        	
                		%>
                	 <tr>
                     	<td align="left" width="7%" >
                    	 <input type="checkbox" id="checkbox<%=i%>" name="check" value="<%=msg.getMessageID()%>"></td>
                     	<%if (!msg.unread()) {%>
                    	 	<td align="left" width="22%"><a href="profile.jsp?user=<%=sender.user_id%>"><b><%=sender.getUsername() %></b></a></td>
                     	 	<td align="left" width="49%"><a href="readMessages.jsp?msg_id=<%=msg.getMessageID()%>"><b><%=msg.getSubject()%></b></a></td>
                     		<td align="right" width="20%"><b><%=sdf.format(msg.getDate())%></b></td>
                     	<%} 
                     	else {%>
                      		<td align="left" width="22%"><a href="profile.jsp?user=<%=sender.user_id%>"><%=sender.getUsername()%></a></td>
                     	 	<td align="left" width="49%"><a href="readMessages.jsp?msg_id=<%=msg.getMessageID()%>"><%=msg.getSubject()%></a></td>
                     		<td align="right" width="20%"><%=sdf.format(msg.getDate())%></td>
                         	<%}%>
                      </tr> 
                      <%}%>
                      <%}%>         
                 <% }%>
        	</tbody>
        </table>
        </fieldset>
                           <hr>
                                        <div> Select:&nbsp;&nbsp;<a href="javascript:;" onclick="checkAll(this)" >All</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" id="checknone">None</a>
                                        <span style="float:right"><b>Selected Messages :&nbsp;&nbsp;&nbsp;</b>
                                        <select id="action-select" name="update_type">
                                                <option value="delete">Delete Messages</option>
                                                <option value="read">Mark as Read</option>
                                                <option value="unread">Mark as Unread</option>
                                        </select>
                                                <input type="hidden" name="quiz_id" value="s">
                                                <input class="small-button" id="inbox-action-button" type="submit" name="inbox_update" value="Update"></span>
                                        </div>
                <%                
                        }
                %>
             
        <script type="text/javascript">
                function checkAll(link) {
                        var inputs = document.getElementsByTagName('input');
                        for (var i=0; i < inputs.length; i++) {
                                if (inputs[i].type == 'checkbox') {
                                        inputs[i].checked = true;
                                }
                        }
                }

                $(function () {
                        $('#checknone').click(function () {
                            $('fieldset').find(':checkbox').attr('checked', false);
                            return true;
                        });
                });
        </script>
        <a id="admin-link" href="index.jsp">Home</a>
</ex:push>

</div>       
</body>
</html>