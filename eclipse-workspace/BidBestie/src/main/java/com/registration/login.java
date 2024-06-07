package com.registration;

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

/**
 * Servlet implementation class login
 */
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		
		if(username == null || username.equals("")) {
			request.setAttribute("status", "invalidUsername");
			dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);

		}
		if(password == null || password.equals("")) {
			request.setAttribute("status", "invalidUpwd");
			dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);

		}
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC","root", "root");
			PreparedStatement pst = con.prepareStatement("select * from users where username = ? and password = ?");
			pst.setString(1, username);
			pst.setString(2, password);
			
			ResultSet rs = pst.executeQuery();
			
			if(rs.next()) {
				
				session.setAttribute("name", rs.getString("username"));
				
				int userId = rs.getInt("accountID");
                //Store user ID in session
                session.setAttribute("userId", userId);
                
				dispatcher = request.getRequestDispatcher("index.jsp"); /* direct page after login*/
				
				
			}else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}
			dispatcher.forward(request, response);
			
			rs.close();
			pst.close();
			con.close();
		} catch (Exception e) {
			dispatcher = request.getRequestDispatcher("login.jsp");
		}
	}

}
