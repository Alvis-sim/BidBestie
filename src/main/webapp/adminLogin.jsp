<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Include your CSS file -->
</head>
<body>
    <h2>Admin Login</h2>
    <form action="AdminLoginServlet" method="post">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
    </form>

    <%
        String status = (String) request.getAttribute("status");
        if ("failed".equals(status)) {
    %>
        <p style="color:red;">Invalid username or password</p>
    <%
        }
    %>
</body>
</html>
