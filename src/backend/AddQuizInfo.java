package backend;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddQuizInfo
 */
@WebServlet("/AddQuizInfo")
public class AddQuizInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddQuizInfo() {
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
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		String title = request.getParameter("quiz_title");
		String description = request.getParameter("description");
		String multi = request.getParameter("multiple_pages");
		Boolean multi_pages=false;
		if(multi!=null){
			multi_pages = true;
		}
		String random = request.getParameter("random_questions");
		Boolean random_questions = false;
		if(random!=null){
			random_questions=true;
		}
		String immediate = request.getParameter ("immediate_correction");
		Boolean immediate_correction = false;
		if(immediate!=null){
			
			immediate_correction=true;
		}
		String practice = request.getParameter("practice_mode");
		Boolean practice_mode=false;
		if(practice!=null){
			practice_mode=true;
		}
		
		int quiz_id = EditQuestionMethod.addQuizInfo(currentUser.username,title, description,multi_pages,random_questions,
			immediate_correction,practice_mode);
		response.sendRedirect("AddMenu.jsp?quiz_id="+quiz_id);
		currentUser.giveAchievements();
		
		
		
		
		
	}

}
