<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("login.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link href="css/Landingpage.css" rel="stylesheet" />
    <title>BidBestie | Home</title>
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
        <span>Hi, ${fname} ${lname} !</span>
        <div class="links">
            <a href="userprofile.jsp">My Account</a>
            <a href="logout">Logout</a>
            <a href="createListing2.jsp">Sell</a>
            <a href="viewlisting.jsp">View listing</a>
            <a href="#"><img src="images/bell.png" alt="Image 1"></a>
            <a href="#"><img src="images/heart.png" alt="Image 2"></a>
            <a href="#"><img src="images/shopping-cart.png" alt="Image 3"></a>
        </div>
        
    </div>

    <ul class="categories">
        <li><a href="Electronics">Electronics</a></li>
        <li><a href="Women Fashion">Women Fashion</a></li>
        <li><a href="men-fashion">Men Fashion</a></li>
        <li><a href="Living">Living</a></li>
        <li><a href="Accessories">Accessories</a></li>
        <li><a href="B&H">Beauty & Health</a></li>
        <li><a href="Travel">Travel</a></li>
        <li><a href="Sporting Goods">Sporting Goods</a></li>
        <li><a href="Pet Supplies">Pet Supplies</a></li>
    </ul>

    <div class="section popular-destinations">
        <h2>Popular Destinations</h2>
        <div class="items">
            <div class="item">
                <img src="images/smartwatch.jpg" alt="smartwatch">
                <p>Smartwatch</p>
            </div>
            <div class="item">
                <img src="images/iphone15.jpg" alt="iphone15">
                <p>Iphone 15</p>
            </div>
            <div class="item">
                <img src="images/pc.jpg" alt="pc">
                <p>PC</p>
            </div>
        </div>
    </div>

    <div class="section top-products">
        <h2>Top Products</h2>
        <div class="items">
            <div class="item">
                <img src="images/laptop.jpg" alt="Flergump">
                <p>Laptop</p>
                <span>$123.45</span>
            </div>
            <div class="item">
                <img src="images/tv.jpg" alt="Wibblo">
                <p>Television</p>
                <span>$98.76</span>
            </div>
            <div class="item">
                <img src="images/keyboard.jpeg" alt="iphone15">
                <p>keyboard</p>
                <span>$1222.34</span>
            </div>
        </div>
    </div>
</body>
</html>
