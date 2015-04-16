package backend;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.SQLException;



public class Message {

	private String sender;
	private String receiver;
	private String message; 
	private boolean unread;
	private int quizID;
	private Timestamp date;
	private String subject;
	private int messageID;
	private String messageType;
	 
	
	public Message(String sender, String receiver,String message, boolean unread, int quizID,Timestamp timestamp, String subject,int messageID, String messageType) {
		this.sender = sender;
		this.receiver = receiver;
		this.message = message;
		this.unread = unread;
		this.quizID = quizID;
		this.date = timestamp; 
		this.subject =  subject;
		this.messageID = messageID;
		this.messageType = messageType;
	}
	
	public Message(ResultSet rs) {
		try {
			this.sender = rs.getString(1);
			this.receiver = rs.getString(2);
			this.message = rs.getString(3);
			this.unread = rs.getBoolean(4);
			this.quizID = rs.getInt(5);
			this.date = rs.getTimestamp(6); 
			this.subject =  rs.getString(7);
			this.messageID = rs.getInt(8);
			this.messageType = rs.getString(9);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	public String getSender() {return sender;}
	public String getReceiver() {return receiver;}
	public String getMessage() {return message;}
	public boolean unread() {return unread;}
	public int getQuizID() {return quizID;}
	public Timestamp getDate() {return date;}
	public String getSubject() {return subject;}
	public String getMessageType() {return messageType;}
	public int getMessageID() {return messageID;}
	
	
	
}
