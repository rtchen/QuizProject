package backend;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DeleteAnnouncementServlet
 */
@WebServlet("/DeleteAnnouncementServlet")
public class DeleteAnnouncementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAnnouncementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession currentSession = request.getSession();
		User user = (User) currentSession.getAttribute("currentUser");
		if (user == null || !user.is_admin) {
			currentSession.setAttribute("message", "Sorry, you are not authorized");
			response.sendRedirect("admin.jsp");
			return;
		}
		
		if(request.getParameter("announcement_id") == null) {
			currentSession.setAttribute("message", "Error: form information missing");
            response.sendRedirect("admin.jsp");
            return;
        }
		Announcement.deleteAnnouncement(request.getParameter("announcement_id"));
		currentSession.setAttribute("message", "Announcement with id "+request.getParameter("announcement_id")+" is deleted");
		response.sendRedirect("admin.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
