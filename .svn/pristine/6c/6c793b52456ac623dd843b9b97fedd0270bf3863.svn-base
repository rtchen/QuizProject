package backend;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Review {

	private int quizID;
	private String reviewer;
	private int stars;
	private String review;
	
	public Review(ResultSet rs) {
		try {
			this.quizID = rs.getInt(1);
			this.reviewer = rs.getString(2);
			this.stars = rs.getInt(3);
			this.review = rs.getString(4);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Review(int quizID, String reviewer, int stars, String review) {
		this.quizID = quizID;
		this.reviewer = reviewer;
		this.stars = stars;
		this.review = review;
	}
	
	public int getQuizID() {return quizID;}
	public String getReviewer() {return reviewer;}
	public int getStars() {return stars;}
	public String getReview() {return review;}
	
}
