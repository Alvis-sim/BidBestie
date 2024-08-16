<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
        .dashboard {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .dashboard-item {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 30%;
            box-sizing: border-box;
            margin-bottom: 20px;
        }
        h2 {
            margin-top: 0;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .logout-btn {
            background-color: #dc3545;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <header>
        <h1>Admin Dashboard</h1>        
        <a href="logout" class="btn logout-btn">Logout</a>
           
    </header>
    <div class="container">
        <div class="dashboard">
            <!-- Manage Products -->
            <div class="dashboard-item">
                <h2>Manage Products</h2>
                <p>View and manage all products listed in the system.</p>
                <a href="adminViewListing.jsp" class="btn">View Listings</a>
            </div>
            
            <!-- Manage Users -->
            <div class="dashboard-item">
                <h2>Manage Users</h2>
                <p>View and manage user accounts and their details.</p>
                <a href="adminViewUsers.jsp" class="btn">View Users</a>
                <a href="addAdmin.jsp" class="btn">Add New Admin</a>
            </div>
            <!-- View Admins (Conditional) -->
            <%
                
                String loggedInAdmin = (String) session.getAttribute("adminUser");

                if (loggedInAdmin != null && loggedInAdmin.equals("adminj")) {
            %>
            <div class="dashboard-item">
                <h2>Manage Admins</h2>
                <p>View and manage admin accounts in the system.</p>
                <a href="adminViewAdmin.jsp" class="btn">View Admins</a>
            </div>
            <%
                }
            %>
            
            <!-- Add New Category -->
            <div class="dashboard-item">
                <h2>Add New Category</h2>
                <p>Add new categories to the product catalog.</p>
                <a href="manageCategories.jsp" class="btn">Add Category</a>
            </div>

            

            

            <!-- Logout Button -->
            
        </div>
    </div>
</body>
</html>
