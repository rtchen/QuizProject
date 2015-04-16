package backend;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import com.mysql.jdbc.PreparedStatement;

public class QuizManager {

	private  static Connection con;
	
	public QuizManager() {
		con =  MyDBInfo.getConnection();
	}
	 private void check() {
		
			while (con == null) { 
				con = MyDBInfo.getConnection();
			}
	        
		}
	public void writeReview(int stars, String username,int quiz_id, String review){
		PreparedStatement ps;
        check();
        try {
                ps = (PreparedStatement) con.prepareStatement("INSERT INTO reviews (QuizID, Username,Stars,Review) VALUES (?, ?,?,?)");
                ps.setInt(1, quiz_id);
                ps.setString(2,username);
                ps.setInt(3,stars);
                ps.setString(4,review);
                ps.executeUpdate();
        } catch (SQLException ignored) {  }
         
		
	}
	
	public void deletePracticeAttempts() {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM attempts WHERE practice=1");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteMalformedQuizzes() {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM quizzes WHERE Title=\"\"");
			stmt.executeUpdate("DELETE FROM quizzes WHERE quizzes.QuizID NOT IN (SELECT questions.QuizID FROM questions)");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<String> findQuizzes(String searchTerm) {
		ArrayList<String> quizList = new ArrayList<String>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT Title FROM quizzes WHERE Title LIKE \'%" + searchTerm + "%\'");
			while (rs.next()) {
				quizList.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizList;
	}
	
	public Quiz getQuizByTitle(String title) {
		Quiz quiz = null;
		ResultSet rs = null;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("Select * FROM quizzes WHERE Title=" + format(title));
			if (rs.next()) {
				quiz = new Quiz(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quiz;
	}
	
	public ArrayList<Quiz> getAllQuizzes() { 
		ArrayList<Quiz> quizList = new ArrayList<Quiz>();
		ResultSet rs = null;
       try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM quizzes;");
			while (rs.next()) {
				quizList.add(new Quiz(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizList;
	}
	//Gets a master list of quizzes from the database.
	public ArrayList<String> getQuizzes() {
		ArrayList<String> quizList = new ArrayList<String>();
		ResultSet rs = null;
		try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT Title FROM quizzes");
			while (rs.next()) {
				quizList.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizList;
	}
	
	public int getNumQuizzes() {
		int numQuizzes = 0;
		ResultSet rs = null;
		try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM quizzes");
			if (rs.next()) {
				numQuizzes = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return numQuizzes;
	}
	
	public int getNumAttempts() {
		int numAttempts = 0;
		ResultSet rs = null;
		try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM attempts");
			if (rs.next()) {
				numAttempts = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return numAttempts;
	}
	
	//Gets a list of quizzes that a user has created.
	public ArrayList<Quiz> getUserQuizzes(String username) {
		ArrayList<Quiz> quizList = new ArrayList<Quiz>();
		ResultSet rs = null;
        try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM quizzes WHERE Username=" + format(username));
			while (rs.next()) {
				quizList.add(new Quiz(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizList;
	}
	
	//Gets a list of quizzes that are in a category.
	public ArrayList<Quiz> getQuizzesByTag(String tag) {
		ArrayList<Quiz> quizList = new ArrayList<Quiz>();
		ResultSet rs = null;
		
		try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT QuizID FROM quiz_tags WHERE Tag=" + format(tag));
			while (rs.next()) {
				quizList.add(getQuiz(rs.getInt(1)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizList;
	}
	
	public void addTag(int id, String tag) {
		try {
			Statement stmt = con.createStatement();
			//System.out.println("INSERT INTO quiz_tags (QuizID, Tag) VALUES (" +id+", "+format(tag) +")");
			stmt.executeUpdate("INSERT INTO quiz_tags (QuizID, Tag) VALUES (" +id+", "+format(tag) +")");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//If a user wants to search the quizzes by tags, he/she can enter a list of tags
	//and this will get all the quizzes with at least one of those tags.
	public ArrayList<Quiz> getQuizzesByTags(ArrayList<String> tags) {
		ArrayList<Quiz> quizList = new ArrayList<Quiz>();
		ResultSet rs = null;
		check();
		try {
			Statement stmt = con.createStatement();
			StringBuilder query = new StringBuilder();
			query.append("SELECT DISTINCT QuizID FROM quiz-tags WHERE Tag=" + tags.get(0));
			for (int i = 1; i < tags.size(); i++) {
				query.append(" OR Tag=" + tags.get(i));
			}
			rs = stmt.executeQuery(query.toString());
			while (rs.next()) {
				quizList.add(getQuiz(rs.getInt(1)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizList;
	}
	
	//Gets a specific quiz from the quizID.
	public Quiz getQuiz(int quizID) {
		Quiz quiz = null;
		ResultSet rs = null;
		check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM quizzes WHERE QuizID=" + quizID);
			while(rs.next()){
			quiz = new Quiz(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quiz;
	}
	public ArrayList<Quiz> getPopularQuiz(){
		ArrayList<Quiz> quizzes = getAllQuizzes();
		ArrayList<Quiz> popular = new ArrayList<Quiz>();
		int size = quizzes.size();
		for (int i =0;i<size;i++){
			for(int j=i+1;j<size;j++){
			Quiz qi = quizzes.get(i);
			Quiz qj = quizzes.get(j);
		    if(qi.getRating()<qj.getRating())
		    	Collections.swap(quizzes, i, j);
			}
		}
		for(int i=0;i<size &&i<5;i++){
			Quiz q = quizzes.get(i);
			popular.add(q);
		}
		return popular;
	}
	public ArrayList<Quiz> getRecent(){
		ArrayList<Quiz> recent = new ArrayList<Quiz>();
		ResultSet rs = null;
        try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT quizID FROM quizzes ORDER BY Creation_Date DESC LIMIT 5;");
			while (rs.next()) {
				recent.add(getQuiz(rs.getInt(1)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return recent;
	}
	public ArrayList<Quiz> getMyCreated(String username){
		ArrayList<Quiz> my = new ArrayList<Quiz>();
		ResultSet rs = null;
        try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM quizzes WHERE Username = "+format(username) +" ORDER BY Creation_Date DESC LIMIT 5;");
			while (rs.next()) {
				my.add(new Quiz(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return my;
	}
	public ArrayList<Attempt> getRecentAttemptbyUser(String username){
		ArrayList<Attempt> my = new ArrayList<Attempt>();
		ResultSet rs = null;
        try {
			check();
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM attempts WHERE Username = "+format(username) +" ORDER BY Start_Time DESC LIMIT 5;");
			while (rs.next()) {
				my.add(Attempt.getAttempt(rs.getInt(1)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return my;
	}
	
	public ArrayList<Attempt> getRecentAttempt(int quizId){
		ArrayList<Attempt> my = new ArrayList<Attempt>();
		ResultSet rs = null;
        try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM attempts WHERE QuizID = "+quizId +" ORDER BY Start_Time DESC LIMIT 5;");
			while (rs.next()) {
				my.add(Attempt.getAttempt(rs.getInt(1)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return my;
	}
	
	private String format(String str) {
		return "\'" + str + "\'";
	}
	
	public void clearHistory(int quizId) {
        try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM attempts WHERE QuizID = "+quizId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
