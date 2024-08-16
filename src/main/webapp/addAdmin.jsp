<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Admin</title>
    <link rel="stylesheet" href="css/admin.css"> <!-- Link to your CSS file -->
</head>
<body>
    <div class="content">
        <h2>Add New Admin</h2>

        <form action="AddAdminServlet" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn">Add Admin</button>
            </div>
        </form>

        <div class="form-group">
            <a href="adminDashboard.jsp">Back to Admin Dashboard</a>
        </div>

        <% String status = (String) request.getAttribute("status"); %>
        <% if ("success".equals(status)) { %>
            <p>Admin added successfully!</p>
        <% } else if ("error".equals(status)) { %>
            <p>Error adding admin. Please try again.</p>
        <% } %>
    </div>
</body>
</html>
