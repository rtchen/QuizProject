package backend;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class MyDBInfo {
	private static final String USERNAME = "ccs108jmarcy";
	private static final String PASSWORD = "ahtahroz";
	private static final String SERVER = "mysql-user-master.stanford.edu";
	private static final String NAME = "c_cs108_jmarcy";
	
	private static Connection con;
	private static Statement stmt;
	private static int num = 0;

	public static void initialize() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + SERVER, USERNAME, PASSWORD);
			num++;
			if (num > 1) {
				System.out.println("Important Error: creating unnecessary connection");
			}
			System.out.println("NEW CONNECTION SET, #"+num);
			stmt = con.createStatement();
			stmt.executeQuery("USE " + NAME);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/*
	public MyDBInfo() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + SERVER, USERNAME, PASSWORD);
			stmt = con.createStatement();
			stmt.executeQuery("USE " + NAME);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	*/
	
	public static Connection getConnection() {
		if (con == null) {
			System.out.println("Minor Error: connection should have been set up from SessionListener, but it's not");
			initialize();
		}
		return con;
	}
	
}
