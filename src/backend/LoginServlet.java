package backend;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 if(request.getParameter("username") == null || request.getParameter("password") == null) {
             response.sendRedirect("login.jsp");
             return;
        }
		 
		 String username = (String) request.getParameter("username");
         String password = (String) request.getParameter("password");
         username=username.trim();
         password=password.trim();
         
         if(username.length() == 0 || password.length()==0) {
        	 response.sendRedirect("login.jsp");
         	 return;
         }
         
         UserManager manager= new UserManager();
         if(manager.checkPassword(username,password)==false){
        	 response.sendRedirect("login.jsp?bad=1");
             return;
         }
         
        	 User user = manager.getUser(username);
        	 HttpSession currentSession = request.getSession();
             currentSession.setAttribute("currentUser", user);
             response.sendRedirect("index.jsp");
        	 
	}
	
	
	
	

}
