<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*" %>
<%
User currentUser = (User) session.getAttribute("currentUser");
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<body>
     <% if(currentUser != null) {%>
        <div>
                <form method="post" action="CreateQuizServlet">
                        <input type="submit" value="CreateQuiz"/>
                </form>
        </div>
      <%}%>
      <p>Here is a list of all the quizzes </p>  
      <%QuizManager manager=new QuizManager();
         ArrayList<Quiz> list= manager.getAllQuizzes();
         if(list != null) {
             for(Quiz quiz : list) {%>
                         <div>
                                 <div> <a href="QuizInfo.jsp?id=<%=quiz.id%>"><%=quiz.title %></a></div>
                                 <div><%=quiz.getQuestions().size() %> questions</div>
                         </div>
               <% }%>
        <% }%>
         
        
        
        
        
        
</body>
</html>