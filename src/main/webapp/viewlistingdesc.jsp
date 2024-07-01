<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BidBestie-Landing Page</title>
    <link href="css/viewlistingdesc.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
      <div class="top">
        <div class="logo">
            <a href="UserLanding.jsp"><h1>BidBestie</h1></a>
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
        <span>${fname} ${lname}</span>
        <div class="links">
            <a href="viewaccount.jsp">My Account</a>
            <a href="logout">Logout</a>
            <a href="#"><i class="fa fa-bell"></i></a>
            <a href="#"><i class="fa fa-heart"></i></a>
            <a href="#"><i class="fa fa-shopping-cart"></i></a>
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

	<!-- Main Content -->
    <div class="main-content">
    	<br></br>
        <h2>Laptop XYZ Ultrabook</h2>
        <div class="content">
            <div class="image-placeholder">
                <!-- Image placeholder -->
                <div class="row">
				  <div class="column">
				    <img src="images/laptop.jpg" alt="l1" width="500" height="400">
				  </div>
				  <div class="column">
				    <img src="images/laptop2.jpg" alt="l2" width="500" height="400">
				  </div>
				  <div class="column">
				    <img src="images/laptop3.png" alt="l3" width="500" height="400">
				  </div>
				</div>
            </div>
            <div class="description">
                <h3>Description of items...</h3>
                <p>The XYZ Ultrabook is a sleek, powerful laptop designed for professionals and students alike. Featuring a 14-inch Full HD display, the Ultrabook delivers vibrant visuals and sharp details. Powered by the latest Intel Core i7 processor, 16GB of RAM, and a 512GB SSD, this laptop ensures smooth performance and fast data access.</p>
                <br></br>
                <button class="button bidbutton">Place Bid</button><br></br>
                <button class="button buybutton">Buy for $123.45</button><br></br>
                <button class="button cartbutton">Add to cart</button><br></br>
                <button class="button watchbutton">Add to watchlist</button><br></br>
            </div>
        </div>
        <div class="shipping-reviews">
            <div class="shipping">
                <h3>Shipping Detail...</h3>
                <p>Free economy postage to worldwide.</p>
            </div>
            <div class="reviews">
                <h3>Reviews...</h3>
                <p>UserABC: Very nice product! </p>
                <p>UserXYZ: Fast delivery! Excellent :D</p>
            </div>
            <div class="rating">
                <h3>Rating...</h3>
                <span>★★★★☆</span>
            </div>
        </div>
    </div>
	
    <!-- Logout Prompt Modal -->
    <div id="logoutPrompt" class="modal">
        <div class="modal-content">
            <p>Are you sure you want to logout?</p>
            <div class="button-container">
                <button id="confirmLogout">Logout</button>
                <button id="cancelLogout">Cancel</button>
            </div>
        </div>
    </div>

    <script src="viewlistingdesc.js"></script>
</body>
</html>
