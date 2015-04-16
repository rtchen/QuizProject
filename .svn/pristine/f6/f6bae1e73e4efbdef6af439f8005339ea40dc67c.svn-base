package backend;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import com.mysql.jdbc.PreparedStatement;

public class QuestionAttempt {
	    protected static Connection con = MyDBInfo.getConnection();
         public int question_attempt_id;
         public int quiz_attempt_id;
         public int QuestionID;
         public int point = 0;
         public boolean graded;
         public String Myanswer;
         private static void check() {
 			while (con == null) con = MyDBInfo.getConnection();
 			
 		}
         public static int getQuestionID(int question_attempt_id)
         {
        	 int QuestionID=-1; 
        	 ResultSet rs;
        	 try {
				Statement stmt = con.createStatement();
				check();
				rs = stmt.executeQuery("SELECT * FROM question_attempts WHERE question_attempt_id = " +question_attempt_id);
				if(rs.next()){
					QuestionID = rs.getInt("QuestionID");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	 return QuestionID;
        	 
         }
         public static String getQuestionType (int QuestionID){
        	 String questionType=null; 
        	 ResultSet rs;
        	 check();
        	 try {
				Statement stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT * FROM questions WHERE QuestionID = " +QuestionID);
				if(rs.next()){
					questionType = rs.getString("Question_Type");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	 return questionType;
        	 
         }
         public static ArrayList<String> getOptions(int question_attempt_id){
        	 
        	 ArrayList<String> options = new ArrayList<String> ();
        	 ResultSet rs;
        	 int QuestionID = getQuestionID(question_attempt_id);
        	 check();
        	 try {
        		 Statement stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT * FROM choices WHERE QuestionID= " +QuestionID);
			     while(rs.next()){
			    	 String choice = rs.getString("Choice");
			    	 options.add(choice);
			     }
        	 } catch (SQLException e) {
				e.printStackTrace();
			}
        	 return options;
        	 
         }
         public void saveAnswer(String answer){
        	 PreparedStatement ps;
        	 check();
        	 try{
        	 ps = (PreparedStatement) con.prepareStatement("UPDATE question_attempts SET answer = \'" +answer +"\' WHERE question_attempt_id = " + question_attempt_id);
        	 ps.executeUpdate();   	 
        	 }catch (SQLException ignored) {  }
         }
         public void gradeAnswer(String[] answers){
        	 String questionType = getQuestionType(QuestionID);
        	 if(answers == null) return;
        	 if(!questionType.equals("MultiAnswer")){
        		 Myanswer = answers[0];
        		 String answer = answers[0];
        	    saveAnswer(answer);
        	 
        	 ArrayList<String> answerList = new ArrayList<String>();
     		ResultSet rs = null;
     		check();
     		try {
     			Statement stmt = con.createStatement();
     			rs = stmt.executeQuery("SELECT * FROM answers WHERE QuestionID=" + QuestionID);
     			while (rs.next()) {
            		answerList.add(rs.getString("Answer"));
     			}
     		} catch (SQLException e) {
     			e.printStackTrace();
     		}
     		if(answerList.contains(answer)){
     			point++;
     		}
     		String query = "UPDATE question_attempts SET Points = "+point+",graded = true WHERE question_attempt_id = " +question_attempt_id;
 			check();
 			try{
 				PreparedStatement ps= (PreparedStatement) con.prepareStatement(query);
 			ps.executeUpdate();
 			}catch(SQLException e){
 				e.printStackTrace();
 			}
        	 }
        	 else gradeMultiAnswer(answers);
     		
         } 
         public void gradeMultiAnswer(String[] answers){
        	 saveMultiAnswer(answers);
        	 ArrayList<String> answerList = new ArrayList<String>();
      		ResultSet rs = null;
      		check();
      		try {
      			Statement stmt = con.createStatement();
      			rs = stmt.executeQuery("SELECT * FROM answers WHERE QuestionID=" + QuestionID);
      			while (rs.next()) {
             		answerList.add(rs.getString("Answer"));
      			}
      		} catch (SQLException e) {
      			e.printStackTrace();
      		}
      		for(int i=0;i<answers.length;i++){
      		if(answerList.contains(answers[i])){
      			point++;
      		}
      		
      		}
      		if(point<0) point=0;
      			String query = "UPDATE question_attempts SET Points = "+point+", graded = true WHERE question_attempt_id = " +question_attempt_id;
      			try{
      				PreparedStatement ps= (PreparedStatement) con.prepareStatement(query);
      			ps.executeUpdate();
      			}catch(SQLException e){
      				e.printStackTrace();
      			}
        	 
         }
         public void saveMultiAnswer(String[] answers){
        	 StringBuilder buffer = new StringBuilder();
        	 buffer.append(answers[0]);
        	 for(int i = 1;i<answers.length;i++){
        		 if(answers[i].equals("")) break;
        		 buffer.append(","+answers[i]);
        	 }
        	 String answer = buffer.toString();
        	 Myanswer = answer;
        	 PreparedStatement ps;
        	 check();
        	 try{
            
        	 ps = (PreparedStatement) con.prepareStatement("UPDATE question_attempts SET answer = \'" +answer +"\' WHERE question_attempt_id = " + question_attempt_id);
        	 ps.executeUpdate();   	 
        	 }catch (SQLException ignored) {  }
        	 
         }
         public QuestionAttempt(int quiz_attempt_id,  int QuestionID) {
                 this.quiz_attempt_id = quiz_attempt_id;
                 this.QuestionID = QuestionID;
                 PreparedStatement ps;
                 check();
                 try {
                         ps = (PreparedStatement) con.prepareStatement("INSERT INTO question_attempts (attempt_id, QuestionID,Points,answer,graded) VALUES (?, ?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                         ps.setInt(1, quiz_attempt_id);
                         ps.setInt(2,QuestionID);
                         ps.setInt(3,0);
                         ps.setString(4,"");
                         ps.setBoolean(5,false);
                         ps.executeUpdate();
                         ResultSet rs = ps.getGeneratedKeys();
                         rs.next();
                         question_attempt_id = rs.getInt(1);
                 } catch (SQLException ignored) {  }
                  
         }
         public QuestionAttempt(){
        	 
         }
         public static QuestionAttempt getQuestionAttempt(int question_attempt_id){
        	 QuestionAttempt qa = new QuestionAttempt();
        	 ResultSet rs;
        	 qa.question_attempt_id= question_attempt_id;
        	 check();
        	 try{
      			Statement stmt = con.createStatement();
      			rs = stmt.executeQuery("SELECT * FROM question_attempts WHERE question_attempt_id =  " + question_attempt_id);
      			if(rs.next()){
      				qa.QuestionID = rs.getInt("QuestionID");
      				qa.quiz_attempt_id=rs.getInt("attempt_id");
      				qa.point = rs.getInt("Points");
      				qa.Myanswer=rs.getString("answer");
      				qa.graded = rs.getBoolean("graded");
      				
      			}
      		}catch(SQLException e){
      			
      		}
        	 return qa;
         }
        
         public double getPoint() {
                 return point;
         }
        

}
