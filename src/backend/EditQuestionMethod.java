package backend;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.HashMap;

import com.mysql.jdbc.PreparedStatement;

public class EditQuestionMethod {
	 protected static Connection con = MyDBInfo.getConnection();
	 private static void check() {
			while (con == null) con =  MyDBInfo.getConnection();
			
		}
	 public static int addQuizInfo(String username,String title, String description,Boolean multi,
			 Boolean random, Boolean immediate ,Boolean practice){
		 int quiz_id=-1;
		check();
		ResultSet rs=null;
		 PreparedStatement ps=null;
		 try {
		        ps = (PreparedStatement) con.prepareStatement("INSERT INTO quizzes (Username, Title, Description, Creation_Date, Random, Multi_Page, Feedback, Practice, is_public) VALUES (?,?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
				ps.setString(1,username);
				ps.setString(2,title);
				ps.setString(3,description);
				ps.setTimestamp(4,new Timestamp(System.currentTimeMillis()));
				ps.setBoolean(5, random);
				ps.setBoolean(6,multi);
				ps.setBoolean(7,immediate);
				ps.setBoolean(8,practice);
				ps.setBoolean(9,true);
				ps.executeUpdate();		
				rs = ps.getGeneratedKeys();
				 if(rs.next())
	             quiz_id = rs.getInt(1);
			
		} catch (SQLException e) {
		} 
		 return quiz_id;
	 }
	 
	 public static  void addVerbal(HashMap<String,String[]> map,String questionType){
		 int quiz_id = Integer.parseInt(map.get("quiz_id")[0]);
		 String question = map.get("question_text")[0];
		 String[] answers = map.get("correct_answers");
		 int questionID=-1;
		 if(question.equals("")) return;
		 ResultSet rs = null;
		  PreparedStatement ps=null;
		 try {
			 check();
		      ps = (PreparedStatement) con.prepareStatement("INSERT INTO questions (QuizID,Question_Type,Question) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS);
		     ps.setInt(1,quiz_id);
		     ps.setString(2,questionType);
		     ps.setString(3,question);
		     ps.executeUpdate();
		     rs = ps.getGeneratedKeys();
		     if(rs.next()){
             questionID= rs.getInt(1);
		     }
		 }
		 catch (SQLException e) {}
		 for(int i=0;i<answers.length;i++){
			 if(answers[i].equals("")) continue;		
			 try {
				 check();
			     ps = (PreparedStatement) con.prepareStatement("INSERT INTO answers (QuestionID,Answer) VALUES (?,?)");
			     ps.setInt(1,questionID);
			     ps.setString(2,answers[i]);
			     
			     ps.executeUpdate();
			 }
			 catch (SQLException e) {}
		 }
		   
		 }
		 public static void addMultiChoice(HashMap<String,String[]> map){
			 int quiz_id = Integer.parseInt(map.get("quiz_id")[0]);
			 String question = map.get("question_text")[0];
			 String answer = map.get("correct_answers")[0];
			 if(answer.equals("")) return ;
			 int questionID=-1;
			 try {
				 check();
			     PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO questions (QuizID,Question_Type,Question) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS);
			     ps.setInt(1,quiz_id);
			     ps.setString(2,"MultiChoice");
			     ps.setString(3,question);
			     ps.executeUpdate();
			     ResultSet rs = ps.getGeneratedKeys();
			     if(rs.next())
	             questionID= rs.getInt(1);
			 }
			 catch (SQLException e) {
				}
			 
               check();
				 try {
				     PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO answers (QuestionID,Answer) VALUES (?,?)");
				     ps.setInt(1,questionID);
				     ps.setString(2,answer);
				     ps.executeUpdate();
				 }
				 catch (SQLException e) {
					}
				 check();
				 try {
				     PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO choices (QuestionID,Choice) VALUES (?,?)");
				     ps.setInt(1,questionID);
				     ps.setString(2,answer);
				     check();
				     ps.executeUpdate();
				 }
				 catch (SQLException e) {}
				 String[] incorrect = map.get("incorrect_answers");
				 for(int i=0;i<incorrect.length;i++){
					 if(incorrect[i].equals("")) continue;
					 check();
					 try {
					     PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO choices (QuestionID,Choice) VALUES (?,?)");
					     ps.setInt(1,questionID);
					     ps.setString(2,incorrect[i]);
					     check();
					     ps.executeUpdate();
					 }
					 catch (SQLException e) {}
				 }
				
	 }
	 
	 
	 
	 
	 
}
