package backend;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DowngradeServlet
 */
@WebServlet("/DowngradeServlet")
public class DowngradeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DowngradeServlet() {
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
		HttpSession currentSession = request.getSession();
		User user = (User) currentSession.getAttribute("currentUser");
		if (user == null || !user.is_admin) {
			currentSession.setAttribute("message", "Sorry, you are not authorized");
			response.sendRedirect("admin.jsp");
			return;
		}
		
		if(request.getParameter("userToChange") == null) {
			currentSession.setAttribute("message", "Error: form information missing");
            response.sendRedirect("admin.jsp");
            return;
        }
		UserManager.downgradeUser(request.getParameter("userToChange"));
		currentSession.setAttribute("message", request.getParameter("userToChange") + " is now regular user");
		response.sendRedirect("admin.jsp");
	}

}
