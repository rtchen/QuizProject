package backend;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddQuestion
 */
@WebServlet("/AddQuestion")
public class AddQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddQuestion() {
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
		
		int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
		HashMap<String, String[]> content = new HashMap<String,String[]>();
		content = (HashMap<String, String[]>) request.getParameterMap();
		String questionType = request.getParameter("questionType");
		
		if(!questionType.equals("MultiChoice")){
			EditQuestionMethod.addVerbal(content, questionType);
		}
		else{
			EditQuestionMethod.addMultiChoice(content);
		}
		response.sendRedirect("AddMenu.jsp?quiz_id="+quiz_id);
		
		
	}

}
