<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="backend.*, java.util.*, java.text.*" %>
<%
QuizManager qm = new QuizManager();
String query = request.getParameter("q");
ArrayList<String> searchResult = qm.findQuizzes(query);
if(!searchResult.isEmpty()){
	for(String qz: searchResult)
		 out.println(qz);
}
else out.println("No result found");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

</body>
</html>