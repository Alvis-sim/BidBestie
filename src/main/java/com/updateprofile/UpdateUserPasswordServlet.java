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
import java.sql.ResultSet;

public class UpdateUserPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountIDStr = request.getParameter("accountID");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (accountIDStr != null && !accountIDStr.isEmpty() && oldPassword != null && newPassword != null && confirmPassword != null) {
            int accountID = Integer.parseInt(accountIDStr);

            if (newPassword.equals(confirmPassword)) {
                Connection con = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

                    String checkSql = "SELECT password FROM users WHERE accountID = ?";
                    PreparedStatement checkStmt = con.prepareStatement(checkSql);
                    checkStmt.setInt(1, accountID);
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next()) {
                        String currentPassword = rs.getString("password");
                        if (currentPassword.equals(oldPassword)) {
                            String updateSql = "UPDATE users SET password = ? WHERE accountID = ?";
                            PreparedStatement updateStmt = con.prepareStatement(updateSql);
                            updateStmt.setString(1, newPassword);
                            updateStmt.setInt(2, accountID);

                            int rowsUpdated = updateStmt.executeUpdate();
                            if (rowsUpdated > 0) {                            	
                            	response.sendRedirect(request.getContextPath() + "/viewaccount.jsp?profileUpdated=true");                                                               
                                //response.getWriter().println("Password updated successfully!");
                            } else {
                                response.getWriter().println("Failed to update password. User not found.");
                            }
                        } else {
                            response.getWriter().println("Old password is incorrect.");
                        }
                    } else {
                        response.getWriter().println("User not found.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Database error occurred: " + e.getMessage());
                } finally {
                    if (con != null) {
                        try {
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                response.getWriter().println("New password and confirm password do not match.");
            }
        } else {
            response.getWriter().println("Invalid input.");
        }
    }
}
