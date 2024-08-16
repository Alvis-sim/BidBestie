<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Manage Categories</h1>
    
    <!-- Form to Add New Category -->
    <form method="post" action="AddCategoryServlet">
        <div>
            <label for="categoryName"></label>
            <input type="text" name="categoryName" id="categoryName" required>
        </div>
        <button type="submit">Add Category</button>
    </form>

    <h2>Existing Categories</h2>
    <ul>
        <% 
            // Fetch categories from database and display them
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");
                pst = con.prepareStatement("SELECT * FROM categories");
                rs = pst.executeQuery();
                while (rs.next()) {
                    String categoryId = rs.getString("categoryId"); // Assuming there's an ID field
                    String categoryName = rs.getString("categoryName");
                    out.println("<li>" + categoryName + 
                        " <form method='post' action='RemoveCategoryServlet' style='display:inline;'>" +
                        "<input type='hidden' name='categoryId' value='" + categoryId + "' />" +
                        "<button type='submit'>Remove</button>" +
                        "</form></li>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </ul>

    <a href="adminDashboard.jsp">Back to Dashboard</a>
</body>
</html>
