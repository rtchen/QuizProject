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
<p><%=currentQuestion.question %></p>
<%String qa_id = Integer.toString(qa.question_attempt_id); %>
<%for (int i=0;i<7;i++) {%>
<%="<p> <input type=\"text\" name="+ qa_id+" > </p>" %>
<%} %>
</body>
</html>