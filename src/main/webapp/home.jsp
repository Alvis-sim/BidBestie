<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BidBestie | Home</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <!-- Header Section -->
        <header>
            <div class="title">
                <h1>BidBestie</h1>
            </div>
            <div class="login-register">
                <form action="login" method="post">
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Login</button>
                </form>
                <form action="registration.jsp" method="post">
                    <button type="submit">Register</button>
                </form>
            </div>
        </header>

        <!-- Search Bar and Categories Section -->
        <div class="search-categories">
            <form action="search" method="get">
                <input type="text" name="query" placeholder="Search..." required>
                <button type="submit">Search</button>
                <select name="category">
                    <option value="all">All Categories</option>
                    <option value="electronics">Electronics</option>
                    <option value="fashion">Fashion</option>
                    <option value="home">Home</option>
                    <option value="sports">Sports</option>
                    <option value="toys">Toys</option>
                    <!-- Add more categories as needed -->
                </select>
            </form>
        </div>
    </div>
</body>
</html>