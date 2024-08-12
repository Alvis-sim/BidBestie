package com.registration;

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
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		String repassword = request.getParameter("re_pass");
		String mobile = request.getParameter("contact");
		
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		if(username == null || username.equals("")) {
			request.setAttribute("status", "invalidName");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			return;
		}
		if(email == null || email.equals("")) {
			request.setAttribute("status", "invalidEmail");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			return;
		} else if(!password.equals(repassword)) {
			request.setAttribute("status", "invalidCfmPW");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			return;
		}
		if(password == null || password.equals("")) {
			request.setAttribute("status", "invalidUpwd");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			return;
		}
		if(mobile == null || mobile.equals("")) {
			request.setAttribute("status", "invalidMobile");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			return;
		} else if(mobile.length() < 8) {
			request.setAttribute("status", "invalidMobileLength");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			return;
		}

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

			// Check if username or email already exists
			PreparedStatement pstCheckUserEmail = con.prepareStatement("SELECT * FROM users WHERE username = ? OR email = ?");
			pstCheckUserEmail.setString(1, username);
			pstCheckUserEmail.setString(2, email);
			ResultSet rsUserEmail = pstCheckUserEmail.executeQuery();
			if (rsUserEmail.next()) {
				request.setAttribute("status", "taken");
				dispatcher = request.getRequestDispatcher("registration.jsp");
				dispatcher.forward(request, response);
				return;
			}

			// Insert new user
			PreparedStatement pst = con.prepareStatement("INSERT INTO users(fname, lname, username, password, email, mobile) values(?, ?, ?, ?, ?, ?)");
			pst.setString(1, fname);
			pst.setString(2, lname);
			pst.setString(3, username);
			pst.setString(4, password);
			pst.setString(5, email);
			pst.setString(6, mobile);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("registration.jsp");
			if (rowCount > 0) {
				request.setAttribute("status", "success");	
			} else {
				request.setAttribute("status", "failed");
			}
			
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
