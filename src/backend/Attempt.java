package backend;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;

import com.mysql.jdbc.PreparedStatement;


public class Attempt {
	public int quizID;
	public String username;
	public double points;
	public Timestamp start;
	public Timestamp end;
	public boolean finished;
	public boolean show_score;
	public boolean practice;
	public int attempts_id;
	
	private static Connection con = MyDBInfo.getConnection();
	
	
	public Attempt(ResultSet rs) {
		try {
			this.attempts_id = rs.getInt("attempts_id");
			this.quizID = rs.getInt("QuizID");
			this.username = rs.getString("Username");
			this.points = rs.getDouble("Points");
			this.start = rs.getTimestamp("Start_Time");
			this.end = rs.getTimestamp("End_Time");
			this.finished = rs.getBoolean("finished");
			this.show_score = rs.getBoolean("show_score");
			this.practice = rs.getBoolean("practice");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Attempt(int quizID, String username, int attempts_id, boolean practice) {
		this.quizID = quizID;
		this.username = username;
		this.attempts_id=attempts_id;
		this.practice = practice;
	}
	
	
	public static Attempt getAttempt(int attempts_id){
		ResultSet rs;
		check();
		try {
            PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("SELECT * FROM attempts WHERE attempts_id = " + attempts_id);
            check();
            rs= pstmt.executeQuery();
            if(!rs.next()) return null;
            
            Attempt a = new Attempt(rs.getInt("QuizID"), rs.getString("Username"),rs.getInt("attempts_id"), rs.getBoolean("practice"));
            a.start = rs.getTimestamp("Start_Time");
            a.end = rs.getTimestamp("End_Time");
            a.points = rs.getDouble("Points");
            a.show_score = rs.getBoolean("show_score");
            a.practice = rs.getBoolean("practice");
            a.finished = rs.getBoolean("finished");
            
            return a;
		} catch (SQLException e) {return null;}	
	}
	
	
	private static void check() {
		while (con == null) con = MyDBInfo.getConnection();
	}
	
	
	public static Attempt newQuizAttempt(int quiz_id,String username, boolean show_score, boolean practice) {
        Attempt attempt = null;
        int attempt_id=-1;
        check();
        try {
        	PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("INSERT INTO attempts (QuizID," +
                		" Username,Points,Start_Time,End_Time,show_score,finished, practice) VALUES (?, ?, ?, ?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, quiz_id);
            pstmt.setString(2, username);
            pstmt.setDouble(3,0);
            pstmt.setTimestamp(4,new Timestamp(System.currentTimeMillis()) );
            pstmt.setTimestamp(5,new Timestamp(System.currentTimeMillis()));
            pstmt.setBoolean(6, show_score);
            pstmt.setBoolean(7,false);
            pstmt.setBoolean(8, practice);
     
            check();
            pstmt.executeUpdate();
                
        	ResultSet rs = pstmt.getGeneratedKeys();
          	rs.next();
          	attempt_id = rs.getInt(1);
          	
           	attempt  = new Attempt(quiz_id, username,attempt_id, practice);
        } catch (SQLException e) { }
        QuizManager manager = new QuizManager();
        Quiz quiz = manager.getQuiz(quiz_id);
        ArrayList<Question> questions= quiz.getQuestions();
        for(Question q:questions){
        	new QuestionAttempt(attempt_id,q.questionID);
        	
        }
        return attempt;
	}
	
	public long getElapsedTime() {
		long millOne = start.getTime();
		long millTwo = end.getTime();
		
		return (millTwo - millOne) / 1000;
	}
	
	public  ArrayList<QuestionAttempt> getQuestionAttempt(boolean random){
		ArrayList<QuestionAttempt> qas =  new ArrayList<QuestionAttempt>();
		ResultSet rs;
		QuizManager manager = new QuizManager();
	    Quiz quiz = manager.getQuiz(quizID);
	    ArrayList<Question> questions= quiz.getQuestions();
	    for(Question q: questions){
	    	check();
	    	try{
	    		Statement stmt = con.createStatement();
	    		rs = stmt.executeQuery("SELECT * FROM question_attempts WHERE attempt_id = " + attempts_id +" AND QuestionID = "+q.questionID);
	    		if (rs.next()) {  				
	    			int question_attempt_id = rs.getInt("question_attempt_id");			
	    			QuestionAttempt qa = QuestionAttempt.getQuestionAttempt(question_attempt_id);
	    			qas.add(qa);
	    		}
	    	}catch(SQLException e){	 }
	    }
	    if(random) Collections.shuffle(qas);
		return qas;
	}
	
	
	public void updateScore (int point) {
		check();
		try {
			end = new Timestamp(System.currentTimeMillis());
			finished = true;
			this.points = point;
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("UPDATE attempts SET points = ?, End_Time = ?, finished = true WHERE attempts_id = ?");
			ps.setDouble(1, point);
			ps.setTimestamp(2,end);
			ps.setInt(3,attempts_id);
			check();
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public double getPoints() {return points;}
	public Timestamp getStartTime() {return start;}
	public Timestamp getEndTime() {return end;}
}
