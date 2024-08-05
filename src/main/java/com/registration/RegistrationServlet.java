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

        // Validate input
        if (username == null || username.equals("") || username.length() < 4 || username.length() > 15) {
            request.setAttribute("status", "invalidUsernameLength");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }
        if (email == null || email.equals("")) {
            request.setAttribute("status", "invalidEmail");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }
        if (password == null || password.equals("") || password.length() < 3 || password.length() > 20) {
            request.setAttribute("status", "invalidPasswordLength");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }
        if (!password.equals(repassword)) {
            request.setAttribute("status", "passwordMismatch");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }
        if (mobile == null || mobile.equals("") || mobile.length() != 10) {
            request.setAttribute("status", "invalidMobile");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC", "root", "root");

            // Check if username, email, or mobile already exists
            String checkQuery = "SELECT * FROM users WHERE username = ? OR email = ? OR mobile = ?";
            try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);
                checkStmt.setString(3, mobile);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        String existingUsername = rs.getString("username");
                        String existingEmail = rs.getString("email");
                        String existingMobile = rs.getString("mobile");

                        if (username.equals(existingUsername)) {
                            request.setAttribute("status", "usernameExists");
                        } else if (email.equals(existingEmail)) {
                            request.setAttribute("status", "emailExists");
                        } else if (mobile.equals(existingMobile)) {
                            request.setAttribute("status", "mobileExists");
                        }

                        dispatcher = request.getRequestDispatcher("registration.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                }
            }

            // Insert new user
            String insertQuery = "INSERT INTO users(fName, lName, username, password, email, mobile) values(?,?,?,?,?,?)";
            try (PreparedStatement pst = con.prepareStatement(insertQuery)) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
