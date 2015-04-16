<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<%
User currentUser = (User) session.getAttribute("currentUser");
QuizManager manager=new QuizManager();
int attempt_id = Integer.parseInt(request.getParameter("attempt_id"));
Attempt a= Attempt.getAttempt(attempt_id);
int quiz_id=a.quizID;
Quiz currentQuiz = manager.getQuiz(quiz_id);
ArrayList<QuestionAttempt> qas = a.getQuestionAttempt(false);
currentUser.checkHighScoreAchievement(quiz_id, a.points, attempt_id);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="global.css">
<title>Result</title>
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
     <div>
        
        <h4>You started this quiz on <%=a.start.toString() %> and completed it on <%=a.end.toString() %>.
        
        <br>You have scored a total of <em><u><%=a.points %></u></em> points on this quiz.
     
        </h4>
</div>
     <%for(QuestionAttempt qa:qas) { 
    	 request.setAttribute("QuizAttempt",a);
    	 request.setAttribute("QuestionAttempt",qa);
	 
	 int QuestionID  = qa.QuestionID;
	 Question question = currentQuiz.getQuestion(QuestionID);
	 request.setAttribute("question",question);
	 request.setAttribute("questionType",question.questionType);%>
    <jsp:include page="${requestScope['questionType']}.jsp" />
    
   <h4>Solutions</h4>
   <%ArrayList<String> answers = question.getAnswers(); %>
   <div style="margin-top:10px">we accepted the following answers:
    <% for(String answer :answers) { %>
     <%=answer %>/
      <% } %>
    </div>
  
   <h4>Your answer</h4>
 <div style="margin-top:10px">
     <%=qa.Myanswer %>     
 </div>
  <%} %>
  <button class="button" id="button1" onClick="window.location.href='index.jsp'">Homepage</button>
  <div id="fake-button"></div>
  <form method="post" action="compose.jsp">
                        <input type="hidden" name="quiz_id" value="<%=currentQuiz.id %>">
                        <input type="hidden" name="high_score" value="<%=currentQuiz.getHighScore(currentUser.getUsername())%>">                       
                        <input type="submit" class="button" id="button3" name="challenge" value="Send a Challenge">
         </form>
         
</div>
</body>
</html>