

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
		
		String id = request.getParameter("accountID");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		String repassword = request.getParameter("re_pass");
		String mobile = request.getParameter("contact");
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC","root", "root");
			pst = con.prepareStatement("SELECT * FROM users WHERE accountID = userID ");
			rs = pst.executeQuery();
			

			 if (rs.next()) {
	                String name = rs.getString("name");
	                String email1 = rs.getString("email");
	                String phone = rs.getString("phone");

	                request.setAttribute("name", name);
	                request.setAttribute("email", email1);
	                request.setAttribute("phone", phone);
	            }
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("registration.jsp");
			if (rowCount > 0) {
				request.setAttribute("status", "success");	
			}else {
				request.setAttribute("status", "failed");
			}
			
			dispatcher.forward(request, response);
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
		request.getRequestDispatcher("/showData.jsp").forward(request, response);
	}
	

}
