<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>View Profile</title>
    <link href="css/viewaccount.css" rel="stylesheet" />
</head>

<body>
    <div class="top">
        <div class="logo">
            <h1>BidBestie</h1>
        </div>
        <div class="search">
            <select id="category">
                <option value="">Search by Category</option>
                <option value="electronics">Electronics</option>
                <option value="women-fashion">Women Fashion</option>
                <option value="men-fashion">Men Fashion</option>
                <option value="living">Living</option>
                <option value="accessories">Accessories</option>
                <option value="beauty-health">Beauty & Health</option>
                <option value="travel">Travel</option>
                <option value="sporting-goods">Sporting Goods</option>
                <option value="pet-supplies">Pet Supplies</option>
            </select>
            <input type="text" placeholder="Search...">
            <button type="submit">Search</button>
            <button type="submit">Advanced Search</button>
        </div>
    </div>

    <div class="user-info">
        <span>User!</span>
        <div class="links">
            <a href="viewaccount.jsp">My Account</a>
            <a href="register.jsp">Register</a>
            <a href="#" id="logoutLink">Logout</a> <!-- Updated logout link -->
            <a href="#"><i class="fa fa-bell"></i></a>
            <a href="#"><i class="fa fa-heart"></i></a>
            <a href="#"><i class="fa fa-shopping-cart"></i></a>
        </div>  
    </div>
    
    <!-- Main container wrapping sidebar and content -->
    <div class="main-container">
        <div class="sidenav">
            <a href="viewaccount.jsp">Profile</a>
            <a href="viewpurchases.jsp">Purchases</a>
            <button class="dropdown-btn">Selling 
                <i class="fa fa-caret-down" style="font-size:24px"></i>
            </button>
            <div class="dropdown-container">
                <a href="viewlisting.jsp">Active</a>
                <a href="#">Inventory</a>
                <a href="#">Analytics</a>
            </div>
            <a href="viewmessages.jsp">Messages</a>
            <a href="viewfeedback.jsp">Feedback</a>
        </div>
        <main>
            <div class="content">
                <h1>Profile</h1>
                <div class="profile-info">
                    <h2>Personal Information</h2>
                    <label for="first-name">First Name</label>
                    <span id="first-name">Lorem</span>
                    
                    <label for="last-name">Last Name</label>
                    <span id="last-name">Ipsum</span>
                    
                    <label for="username">Username</label>
                    <span id="username">Lorem Ipsum</span>
                    
                    <label for="email">Email</label>
                    <span id="email">LoremIpsum@ymail.com</span>
                    
                    <label for="phone">Phone number</label>
                    <span id="phone">98765432</span>
                    
                    <label for="password">Password</label>
                    <span id="password">*********</span>
                    
                    <label for="shipping">Shipping Information</label>
                    <span id="shipping">987654<br>Blk 123, ABC Avenue 4, #01-234</span>
                    
                    <button onclick="window.location.href = 'updateaccount.jsp';">Edit</button>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Logout Prompt Modal -->
    <div id="logoutPrompt" class="modal">
        <div class="modal-content">
            <p>Are you sure you want to logout?</p>
            <br>
            <div class="button-container">
                <button id="confirmLogout">Logout</button>
                <button id="cancelLogout">Cancel</button>
            </div>
        </div>
    </div>
    
    <script src="viewaccount.js"></script>
</body>
</html>
