package com.updateprofile;

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
import java.sql.SQLException;


public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "root";

    // JDBC variables for opening and managing connection
    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String mobile = request.getParameter("contact");
        String username = request.getParameter("username");

        if (email != null && mobile != null && username != null) {
            try {
                String updateQuery = "UPDATE users SET email = ?, mobile = ? WHERE username = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
                preparedStatement.setString(1, email);
                preparedStatement.setString(2, mobile);
                preparedStatement.setString(3, username);

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                	// Store updated email and mobile in session
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setAttribute("mobile", mobile);
                    //response.getWriter().println("Profile updated successfully!");
                	// Redirect to userprofile.jsp upon successful update
                    response.sendRedirect(request.getContextPath() + "/viewaccount.jsp?profileUpdated=true");
                    return; // Exit from the servlet method after redirection
                } else {
                    response.getWriter().println("Failed to update profile. User not found.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Database error occurred: " + e.getMessage());
            }
        } else {
            response.getWriter().println("Invalid input.");
        }
    }

    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
