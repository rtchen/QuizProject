package backend;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class Achievement {
	private String achievement;
	
	private static final Map<String, Integer> creationAchievements;
	private static final Map<String, Integer> takenAchievements;
	
	static {
		takenAchievements = new HashMap<String, Integer>();
		takenAchievements.put("New Student (Taken 1 Quiz)", 1);
		takenAchievements.put("Novice Student (Taken 5 Quizzes)", 5);
		takenAchievements.put("Amateur Student (Taken 10 Quizzes)", 10);
		takenAchievements.put("Skilled Student (Taken 25 Quizzes)", 25);
		takenAchievements.put("Master Student (Taken 50 Quizzes)", 50);
	}
	
	static {
		creationAchievements = new HashMap<String, Integer>();
		creationAchievements.put("New Teacher (Created 1 Quiz)", 1);
		creationAchievements.put("Novice Teacher (Created 5 Quizzes)", 5);
		creationAchievements.put("Amateur Teacher (Created 10 Quizzes)", 10);
		creationAchievements.put("Skilled Teacher (Created 25 Quizzes)", 25);
		creationAchievements.put("Master Teacher (Created 50 Quizzes)", 50);
	}	
	
	public Achievement(ResultSet rs) {
		try {
			this.achievement = rs.getString(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Achievement(String achievement) {
		this.achievement = achievement;
	}
	
	public static Map<String, Integer> getCreationAchievements() {return creationAchievements;}
	public static Map<String, Integer> getTakenAchievements() {return takenAchievements;}
	
	public String getAchievement() {return achievement;}
	
}