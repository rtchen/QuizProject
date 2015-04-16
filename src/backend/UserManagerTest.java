package backend;

import java.util.ArrayList;

import org.junit.Test;

public class UserManagerTest {

	@Test
	public void userTest() {
		UserManager manager = new UserManager();
		User user = manager.getUser("Jordan");
		MessageManager mm = new MessageManager();
		Message mtest = mm.getMessage(2);
		System.out.println("message: " + mtest.getSender());
		
		QuizManager qman = new QuizManager();
		Quiz quiz = qman.getQuiz(1);
		Quiz cities = qman.getQuizByTitle("Cities");
		ArrayList<Attempt> topAttempts = cities.getTopAttemptsFromToday();
		for (Attempt a : topAttempts) {
			System.out.println(a.points + " " + a.getElapsedTime() + " seconds");
		}
		
		System.out.println(cities.getTags());
		System.out.println("score");
		System.out.println(quiz.getHighScore("Jordan"));
		
		System.out.println();
		System.out.println("quiz title search");
		ArrayList<String> quizList = qman.findQuizzes("Citi");
		for (String s : quizList) {
			System.out.println(s);
		}

		
		System.out.println(manager.checkPassword("Jordan", "1234"));
		ArrayList<Message> messages = user.getReceivedMessages();
		for (Message m : messages) {
			System.out.println("Message: " + m.getMessage());
		}
		ArrayList<String> friends = user.getFriends();
		for (String f : friends) {
			System.out.println(f);
		}
		ArrayList<String> achievements = user.getAchievements();
		for (String a : achievements) {
			System.out.println("Achievement: " + a);
		}
		System.out.println("NumQuizzesTaken: " + user.numberOfQuizzesTaken());
		System.out.println("NumQuizzesCreated: " + user.numberOfQuizzesCreated());
	}
	
}
