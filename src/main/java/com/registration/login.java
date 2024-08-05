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
import java.sql.SQLException;

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
				
				int accountID = rs.getInt("accountID");
			    String fname = rs.getString("fname");
			    String lname = rs.getString("lname");		    
			    String email = rs.getString("email");
			    String mobile = rs.getString("mobile");
				
				session.setAttribute("name", rs.getString("username"));
                //Store user data in session
                session.setAttribute("accountID", rs.getString("accountID"));
                session.setAttribute("fname", rs.getString("fname"));
                session.setAttribute("lname", rs.getString("lname"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("password", rs.getString("password"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("mobile", rs.getString("mobile"));
                
                
                int itemCount = getItemCountForUser(accountID);
                session.setAttribute("itemCount", itemCount);
				dispatcher = request.getRequestDispatcher("UserLanding.jsp"); /* direct page after login*/
				
				
			}else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}
			dispatcher.forward(request, response);
			
			rs.close();
			pst.close();
			con.close();
		} catch (Exception e) {
			dispatcher = request.getRequestDispatcher("login.jsp");}
		}
		
		private int getItemCountForUser(int accountID) {
	        int itemCount = 0;
	        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie", "root", "root");
	             PreparedStatement statement = con.prepareStatement("SELECT SUM(quantity) FROM CartItems ci JOIN Cart c ON ci.cartID = c.cartID WHERE c.accountID = ?")) {
	            statement.setInt(1, accountID);
	            try (ResultSet rs = statement.executeQuery()) {
	                if (rs.next()) {
	                    itemCount = rs.getInt(1);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return itemCount;
	    }
	}