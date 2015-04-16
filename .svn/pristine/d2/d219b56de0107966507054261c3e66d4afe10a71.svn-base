package backend;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Answer {
	private Connection con;
	
	private int quizID;
	private int questionID;
	private int answerID;
	private String answer;
	private boolean correct;
	
	public Answer(ResultSet rs) {
		try {
			this.quizID = rs.getInt(1);
			this.questionID = rs.getInt(2);
			this.answerID = rs.getInt(3);
			this.answer = rs.getString(4);
			this.correct = rs.getBoolean(5);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		con = new MyDBInfo().getConnection();
	}
	
	public Answer(int quizID, int questionID, int answerID, String answer, boolean correct) {
		this.quizID = quizID;
		this.questionID = questionID;
		this.answerID = answerID;
		this.answer = answer;
		this.correct = correct;
		con = new MyDBInfo().getConnection();
	}
	
	public String getAnswer() {return answer;}
	public boolean isCorrect() {return correct;}
}
