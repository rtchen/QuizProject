package backend;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
             response.sendRedirect("register.jsp?missing=1");
             return;
        }
		 String username = (String) request.getParameter("username");
         String password = (String) request.getParameter("password");
         username=username.trim();
		 password=password.trim();
         if(username.length()==0 || password.length()==0) {
        	 response.sendRedirect("register.jsp?missing=1");
        	 return;
         }
         UserManager manager = new UserManager();
         if(manager.usernameExists(username)==true){
        	 response.sendRedirect("register.jsp?bad=1");
        	 return;
         }
         
		 manager.addUser(username,password);
		 User user = manager.getUser(username); 
		 HttpSession currentSession = request.getSession();
         currentSession.setAttribute("currentUser", user);
         
         response.sendRedirect("index.jsp");
		 
	}

}
