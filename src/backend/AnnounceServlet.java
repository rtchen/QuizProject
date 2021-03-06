package backend;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AnnounceServlet
 */
@WebServlet("/AnnounceServlet")
public class AnnounceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnounceServlet() {
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
		
		if(request.getParameter("subject") == null || request.getParameter("body") == null) {
			currentSession.setAttribute("message", "Error: form information missing");
            response.sendRedirect("admin.jsp");
            return;
        }
		String subject = (String) request.getParameter("subject");
		String body = (String) request.getParameter("body");
		Announcement.postAnnouncement(subject, body, user);
		currentSession.setAttribute("message", "New announcement is posted");
		response.sendRedirect("admin.jsp");
	}

}
