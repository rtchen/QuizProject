package backend;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;

public class Announcement {
	public int announcement_id;
    public String username;
    public Timestamp postDate;
    public String subject;
    public String body;
	
    
    private static Connection con = MyDBInfo.getConnection();
    /*
    static {
    	con = (Connection) MyDBInfo.getConnection();
    }
    */
    /*
    private static void check() {
		while (con == null) con = (Connection) new MyDBInfo().getConnection();
		
	}
	*/
	
    
    private final static String insertIntoAnnouncements = "INSERT INTO announcements" 
		+ "(username, postDate, subject, body) VALUES"
		+ "(?,?,?,?)";
	
    public Announcement(int announcement_id) {
        this.announcement_id = announcement_id;
        
        try {
        	Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM `announcements` WHERE `announcement_id` = " + announcement_id);
            if(!rs.next()) throw new RuntimeException();
             username = rs.getString("username");
             postDate = rs.getTimestamp("postDate");
             subject = rs.getString("subject");
             body = rs.getString("body");
        } catch (SQLException e) {
        	e.printStackTrace();
        }
     }
    
    
    
    public static ArrayList<Announcement> getAnnouncements() {
    	/*check();*/
        try {
                PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT announcement_id FROM announcements ORDER BY postDate DESC");
                ResultSet rs = ps.executeQuery();
                ArrayList<Announcement> ant = new ArrayList<Announcement>();
               while(rs.next()) {
                        ant.add(new Announcement(rs.getInt("announcement_id")));
                }
                
                return ant;
        } catch (SQLException e) { return null; }
    }
	
    public static void postAnnouncement(String subject, String body, User user) {
    	try {
			PreparedStatement pstmt = con.prepareStatement(insertIntoAnnouncements);
			pstmt.setString(1, user.username);
			pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(3, subject);
			pstmt.setString(4, body);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
    public static void deleteAnnouncement(String id) {
    	try {
    		Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM `announcements` WHERE `announcement_id` = " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
}
