package backend;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import org.junit.Test;

public class MessageManagerTest {

	public static void main(String[] args){
	
	MessageManager mm = new MessageManager();
	UserManager um = new UserManager();
	/*
	Date date = new java.util.Date();
	Timestamp currTime = new Timestamp(date.getTime());
	int ID = mm.numAllMessages();
	Message test1 = new Message("Jordan","jiawen16","Hi,how are you?",false, -1,currTime, "hi",ID, "General");
	mm.sendMessage(test1);
	ID = mm.numAllMessages();
	Message test2 = new Message("Jordan","jiawen16","Bye", false, -1,currTime, "bye",ID, "General");	
	mm.sendMessage(test2);
	ID = mm.numAllMessages();
	Message test3 = new Message( "Jordan","jiawen16","wants to add you as a friend", false, -1,currTime, "Friend Request",ID, "FriendRequest");	
	mm.sendMessage(test3);
	ID = mm.numAllMessages();
	Message test4 = new Message("Jordan", "jiawen16","sent you a quiz challenge", false, -1,currTime, "Quiz Challenge",ID, "Challenge");	
	mm.sendMessage(test4);
	System.out.println("Sent");
	

	ArrayList<Message> messagesReceived = mm.getReceivedMessages("jiawen16");;
	for (Message m : messagesReceived) {
		System.out.println(m.getSender()+" "+m.getReceiver()+" "+ m.getMessage()+" "+m.getMessageID()+" "+ m.getSubject()+" "+m.getDate()+" " +m.getMessageType());
		System.out.println("Sent Messages: " + mm.numSentMessages("jiawen16"));
		System.out.println("New Messages: " + mm.numNewMessages("jiawen16"));
		System.out.println("Friend Request: "+mm.numFriendRequests("jiawen16"));
		System.out.println("Challenges: "+mm.numChallenges("jiawen16"));
		mm.markRead(m.getMessageID());
		System.out.println("New Messages: " + mm.numNewMessages("jiawen16"));
		//mm.markUnread(m.getMessageID());
		//System.out.println("New Message: " + mm.numNewMessages("Jordan"));
	}
	*/
		
	ArrayList<Message> messagesSent = mm.getSentMessages("eve1");;
	for (Message m : messagesSent) {
		System.out.println("eve1 Message: " + m.getDate());
		mm.deleteMessage(m.getMessageID());
	}
	/*
	ArrayList<Message> messagesReceived = mm.getReceivedMessages("evelina");;
	for (Message m : messagesReceived) {
		System.out.println("evelina Message: " + m.getMessage());
		mm.deleteMessage(m.getMessageID());
	}
	
	User user = um.getUser("evan");
	ArrayList<String> friendsNames =user.getFriends();
	ArrayList<User> friends = new ArrayList<User>();
	for(String friend: friendsNames ){
		System.out.println(friend);
		user.deleteFriends(friend);
	}
	*/
	}
}
