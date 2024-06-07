

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class UserProfileServelet
 */
@WebServlet("/userprofile")
public class UserProfileServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		class login extends HttpServlet {
		    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		        HttpSession session = request.getSession(false);
		        if (session != null) {
		            int userId = (Integer) session.getAttribute("userId");
		            response.getWriter().println("User ID: " + userId);
		        } else {
		            response.getWriter().println("User ID not found in session.");
		        }
		    }
		}

		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC","root", "root");
			pst = con.prepareStatement("SELECT * FROM users WHERE accountID = 1 ");
			rs = pst.executeQuery();
			

			 if (rs.next()) {
	                String fname = rs.getString("fname");
	                String lname = rs.getString("lname");
	                String email = rs.getString("email");
	                String mobile = rs.getString("phone");

	                request.setAttribute("fname", fname);
	                request.setAttribute("lname", lname);
	                request.setAttribute("email", email);
	                request.setAttribute("mobile", mobile);
	            }
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		request.getRequestDispatcher("/userprofile.jsp").forward(request, response);
	}
	

}
