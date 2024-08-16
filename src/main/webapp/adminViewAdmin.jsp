<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Admins</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file -->
    <style>
        /* Inline styles for quick customization, consider moving to styles.css */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .btn {
            display: inline-block;
            padding: 5px 10px;
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            margin-right: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .remove-btn {
            background-color: #dc3545;
        }
        .remove-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <header>
        <h1>View Admins</h1>
    </header>
    <div class="container">
        <a href="adminDashboard.jsp" class="btn">Back to Dashboard</a>
        <table>
            <thead>
                <tr>
                    <th>Admin ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Operation</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String loggedInAdmin = (String) session.getAttribute("adminUser");

                    if (loggedInAdmin != null && loggedInAdmin.equals("adminj")) {
                        Connection con = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

                            String sql = "SELECT adminID, username, email FROM adminT";
                            pst = con.prepareStatement(sql);
                            rs = pst.executeQuery();

                            while (rs.next()) {
                                String adminID = rs.getString("adminID");
                                String username = rs.getString("username");
                                String email = rs.getString("email");

                                out.println("<tr>");
                                out.println("<td>" + adminID + "</td>");
                                out.println("<td>" + username + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>");
                                out.println("<form action='RemoveAdminServlet' method='post'>");
                                out.println("<input type='hidden' name='adminID' value='" + adminID + "'/>");
                                out.println("<button type='submit' class='btn remove-btn'>Remove</button>");
                                out.println("</form>");
                                out.println("</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    } else {
                        out.println("<tr><td colspan='4'>You do not have permission to view this page.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
