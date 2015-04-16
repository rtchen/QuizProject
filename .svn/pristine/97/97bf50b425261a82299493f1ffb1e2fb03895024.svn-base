<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<%Question currentQuestion = (Question)  request.getAttribute("question");
  QuestionAttempt qa=(QuestionAttempt) request.getAttribute("QuestionAttempt");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>

<%String qa_id = Integer.toString(qa.question_attempt_id); 
  ArrayList<String> options = QuestionAttempt.getOptions(qa.question_attempt_id);%>

<p><%=currentQuestion.question %></p>
<div>
        <% for(String option : options) { %>
        <p>
           <input type="radio" name="<%=qa.question_attempt_id %>" value="<%=option %>"> <%=option %>
               
        </p>
        <%} %>
</div>
</body>
</html>