package backend;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

public class Quiz {

	static  Connection con =  MyDBInfo.getConnection();;
	
	public int id;
	public String creator;
	public String title;
	public String description;
	public Timestamp creationDate;
	public boolean random;
	public boolean multiPage;
	public boolean feedback;
	public boolean practice;
	public double rating;
	public boolean is_public;
	
	
	
	private final String updateQuiz = "UPDATE quizzes SET Title = ? AND Description = ? "
			+ "AND Random = ? AND Multi_Page = ? AND Feedback = ? AND Practice = ? AND is_public = ?"
			+ "WHERE QuizID = ?";
	
	//Getters and Setters
	public int getID() {return id;}	
	public String getCreator() {return creator;}
	
	public String getTitle() {return title;}
	public void setTitle(String title) {this.title = title;}
	
	public String getDescription() {return description;}
	public void setDescription(String description) {this.description = description;}
	
	public Timestamp getCreationDate() {return creationDate;}
	
	public boolean isRandom() {return random;}
	public void setRandom(boolean random) {this.random = random;}
	
	public boolean isMultiPage() {return multiPage;}
	public void setMultiPage(boolean multiPage) {this.multiPage = multiPage;}
	
	public boolean hasFeedback() {return feedback;}
	public void setFeedback(boolean feedback) {this.feedback = feedback;}
	
	public boolean hasPractice() {return practice;}
	public void setPractice(boolean practice) {this.practice = practice;}
	
	
	/* Creates an instance of a quiz that contains the basic information
	 * and options.  The questions/answers that go with the quiz can be
	 * obtained by querying the database from the Quiz class.  
	 * 
	 * */
	public Quiz(int id, String creator, String title, String description, 
				Timestamp creationDate, boolean random, boolean multiPage,
				boolean feedback, boolean practice,double rating,boolean is_public
				,boolean  immediate_correction) {
		this.id = id;
		this.creator = creator;
		this.title = title;
		this.description = description;
		this.creationDate = creationDate;
		this.random = random;
		this.multiPage = multiPage;
		this.feedback = feedback;
		this.practice = practice;
		this.rating = rating;
		this.is_public=is_public;
		
		
	}
	/*
	 private static  void check() {
			while (con == null) con = (Connection) new MyDBInfo().getConnection();
			
		}
		*/
	public Quiz(ResultSet rs) {
		try {
			
			this.id = rs.getInt(1);
			this.creator = rs.getString(2);
			this.title = rs.getString(3);
			this.description = rs.getString(4);
			this.creationDate = rs.getTimestamp(5);
			this.random = rs.getBoolean(6);
			this.multiPage = rs.getBoolean(7);
			this.feedback = rs.getBoolean(8);
			this.practice = rs.getBoolean(9);
			this.is_public = rs.getBoolean(10);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		con = new MyDBInfo().getConnection();
	}
	
	//Gets the list of questions for this quiz.
	public ArrayList<Question> getQuestions() {
		ArrayList<Question> questionList = new ArrayList<Question>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM questions WHERE QuizID=" + id);
			while (rs.next()) {
				questionList.add(new Question(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return questionList;
	}
	
	public String getTags() {
		StringBuilder tagList = new StringBuilder();
		ResultSet rs = null;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT DISTINCT Tag FROM quiz_tags WHERE QuizID="+id);
			while (rs.next()) {
				tagList.append(rs.getString(1) + " ");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tagList.toString();
	}
	
	public ArrayList<Attempt> getHistory() {
		ArrayList<Attempt> history = new ArrayList<Attempt>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM attempts WHERE QuizID=" + id + " ORDER BY Start_Time DESC");
			while (rs.next()) {
				history.add(new Attempt(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return history;
	}
	
	public double getAverageScore() {
		double avgScore = 0;
		ResultSet rs = null;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT AVG(Points) FROM attempts WHERE finished=1 AND QuizID=" + id);
			if (rs.next()) {
				avgScore = rs.getDouble(1);
			}
		} catch (SQLException e) {}
		return avgScore;
	}
	
	public int getHighScore(String username) {
		int highScore = 0;
		ResultSet rs = null;
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT MAX(Points) FROM attempts WHERE Username=" + format(username));
			if (rs.next()) {
				highScore = rs.getInt(1);
			}
		} catch (SQLException e) {}
		return highScore;
	}

	
	  public Question getQuestion(int questionID){
		  Question q=new Question(questionID);
		  ResultSet rs = null;
		  //check();
			try {
				Statement stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT * FROM questions WHERE QuestionID=" + questionID);			
				if(rs.next()){
					q.quizID = rs.getInt("QuizID");
				    q.questionType=rs.getString("Question_Type");
				    q.question = rs.getString("Question");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return q;
	  }
	  
	//Gets the list of reviews for this quiz.
	public ArrayList<Review> getReviews() {
		ArrayList<Review> reviewList = new ArrayList<Review>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM reviews WHERE QuizID=" + id);
			while (rs.next()) {
				reviewList.add(new Review(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reviewList;
	}
	
	public ArrayList<Attempt> getTopAttempts() {
		ArrayList<Attempt> attemptList = new ArrayList<Attempt>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM attempts WHERE finished=1 AND QuizID=" + id +" ORDER BY Points DESC, TIMESTAMPDIFF(Second, Start_Time, End_Time) ASC LIMIT 5");
			while (rs.next()) {
				attemptList.add(new Attempt(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return attemptList;
	}
	
	public ArrayList<Attempt> getTopAttemptsFromToday() {
		ArrayList<Attempt> attemptList = new ArrayList<Attempt>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM attempts WHERE finished=1 AND DATE(Start_Time) = DATE(NOW()) AND QuizID=" + id +" ORDER BY Points DESC, TIMESTAMPDIFF(Second, Start_Time, End_Time) ASC LIMIT 5");
			while (rs.next()) {
				attemptList.add(new Attempt(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return attemptList;
	}
	
	//Gets the list of past attempts for this quiz.
	public ArrayList<Attempt> getAttempts() {
		ArrayList<Attempt> attemptList = new ArrayList<Attempt>();
		ResultSet rs = null;
		//check();
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM attempts WHERE QuizID=" + id);
			while (rs.next()) {
				attemptList.add(new Attempt(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return attemptList;
	}
	
	public void updateQuiz() {
		//check();
		try {
			PreparedStatement pstmt = con.prepareStatement(updateQuiz);
			pstmt.setString(1, title);
			pstmt.setString(2, description);
			pstmt.setBoolean(3, random);
			pstmt.setBoolean(4, multiPage);
			pstmt.setBoolean(5, feedback);
			pstmt.setBoolean(6, practice);
			pstmt.setBoolean(7,is_public);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public double getRating(){
		ArrayList<Review> reviews = getReviews();
		int size = reviews.size();
		
		if(size==0) return 0;
		double cnt = 0;
		for (int i =0;i<size;i++){
			cnt = cnt+reviews.get(i).getStars();
		}
		
		return (double)(cnt/(double)size);
	}
	
	private String format(String str) {
		return "\'" + str + "\'";
	}
}