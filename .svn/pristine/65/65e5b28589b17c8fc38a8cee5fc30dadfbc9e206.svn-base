package backend;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;



public class Question{

	protected static Connection con = MyDBInfo.getConnection();
	public int quizID;
	public String question;
	public String questionType;
	public int questionID;
	
    
   

	public Question(int questionID) {
		this.questionID = questionID;	
	}
	
	public Question(ResultSet rs) {
		try {
			this.quizID = rs.getInt("QuizID");
			this.questionID = rs.getInt("QuestionID");
			this.questionType = rs.getString("Question_Type");
			this.question = rs.getString("Question");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	 private static void check() {
			while (con == null) con = (Connection) new MyDBInfo().getConnection();
			
		}
	public ArrayList<String> getAnswers() {
		ArrayList<String> answerList = new ArrayList<String>();
		ResultSet rs = null;
		check();
		try {
			Statement stmt = con.createStatement();
			check();
			rs = stmt.executeQuery("SELECT * FROM answers WHERE QuestionID=" + questionID);
			while (rs.next()) {
				answerList.add(rs.getString("Answer"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return answerList;
	}
	
	public int getNumberOfParts() {
		int parts = 0;
		ResultSet rs = null;
		try {
			Statement stmt = con.createStatement();
			check();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM (SELECT DISTINCT answerID FROM answers WHERE questionID=" + questionID + ")");
			parts = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return parts;
	}
	public static String getQuestionAttempt(int question_attempt_id){
		check();
		 try {   
             ResultSet rs = con.prepareStatement("SELECT * FROM question_attempts WHERE question_attempt_id = " + question_attempt_id).executeQuery();
             if(rs.next()){
            	return rs.getString("answer");
             }
     } catch (SQLException e) {
             throw new RuntimeException();
     }
		return null;
	}
	 public static ArrayList<String> getQuestionMultipleAttempt(int question_attempt_id){
		    ArrayList<String> answers = new ArrayList<String>();
		    check();
         try {   
                 ResultSet rs = con.prepareStatement("SELECT * FROM question_attempts WHERE question_attempt_id = " + question_attempt_id).executeQuery();
                 while(rs.next()){
                	 answers.add(rs.getString("answer"));
                 }
         } catch (SQLException e) {
                 throw new RuntimeException();
         }
         return answers;
         }
 
	public String getQuestion() {return question;}
	public String getQuestionType() {return questionType;}
	
	
}
