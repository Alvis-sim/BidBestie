<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<title>Create Listing</title>
		<style><%@include file="css/viewlisting.css"%></style>
	</head>
	
	<body>
       <div class="top">
        <div class="logo">
            <a href="UserLanding.jsp">
    	<img src="images/bid_bestie.png" alt="Bid Bestie Logo">
		</a>
        </div>
       <div class="search">
            <select id="category">
                <option value="">Search by Category</option>
                <option value="electronics">Electronics</option>
                <option value="women-fashion">Women Fashion</option>
                <option value="men-fashion">Men Fashion</option>
                <option value="living">Living</option>
                <option value="accessories">Accessories</option>
                <option value="beauty-health">Beauty and Health</option>
                <option value="travel">Travel</option>
                <option value="sporting-goods">Sporting Goods</option>
                <option value="pet-supplies">Pet Supplies</option>
            </select>
            <div class="search-container">
               <input type="text" placeholder="Search...">
                <i class="fa fa-search search-icon"></i>
            </div>
            <button type="submit">Search</button>
            <button type="submit">Advanced Search</button>
        </div>
    </div>

    <div class="user-info">
        <span>User!</span>
        <div class="links">
            <a href="viewaccount.jsp">My Account</a>
            <a href="logout">Logout</a> <!-- Updated logout link -->
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
	            <div class="main-content">
	            	<h1>Active Listing</h1>
	                <form class="search-form" method="get" action="#">
			            <input type="text" class="navbar-search" name="search" placeholder="Search Active Listings..." />
			            <button type="submit" class="navbar-button">Search</button>
			        </form><br></br>
	                <table>
	                    <thead>
	                        <tr>
	                            <th>Name</th>
	                            <th>Type of Listing</th>
	                            <th>Current Price</th>
	                            <th>Bids</th>
	                            <th>Time left</th>
	                            <th>Action</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr>
	                            <td>ABC</td>
	                            <td>Buy It Now</td>
	                            <td>$25.00</td>
	                            <td>-</td>
	                            <td>-</td>
	                            <td><a href="viewlistingdesc.jsp">Details</a> | <a href="updatelisting.jsp">Update</a> | <a href="#">Delete</a></td>
	                        </tr>
	                        <tr>
	                            <td>DEF</td>
	                            <td>Auction</td>
	                            <td>$100.00</td>
	                            <td>3</td>
	                            <td>3 days</td>
	                            <td><a href="#">Details</a> | <a href="updatelisting.jsp">Update</a> | <a href="#">Delete</a></td>
	                        </tr>
	                        <tr>
	                            <td>XYZ</td>
	                            <td>Auction</td>
	                            <td>$250.00</td>
	                            <td>10</td>
	                            <td>7 days</td>
	                            <td><a href="viewlistingdesc.jsp">Details</a> | <a href="updatelisting.jsp">Update</a> | <a href="#">Delete</a></td>
	                        </tr>
	                    </tbody>
	                </table>
	                <a href="createListing.jsp" class="create-listing">+ Create Listing</a>
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
	    
	    <script src="viewlisting.js"></script>
	    
	     <script>
    var dropdown = document.getElementsByClassName("dropdown-btn");
    var i;

    for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
            } else {
                dropdownContent.style.display = "block";
            }
        });
    }
    
    </script>
	    
	</body>
</html>