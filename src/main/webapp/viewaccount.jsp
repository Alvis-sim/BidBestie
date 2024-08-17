<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>View Profile</title>
    <style><%@include file="css/viewaccount.css"%></style>
</head>

<body>
<div class="sticky-top">
	<div class= "top-header">
		<div class="left-section">
			<div class="logo">
		        <a href="UserLanding.jsp"><img src="images/bid_bestie.png" alt="Bid Bestie Logo"></a> 
		    </div>		        	    	
	        <div class="user-info">
			    <div class="dropdown">
			        <span class="dropbtn">Hi, ${fname} ${lname} !<span class="arrow-down"></span></span> <!-- Trigger element -->
			        <div class="dropdown-content">
			            <a href="viewaccount.jsp">Profile</a>
			            <a href="viewaccount.jsp">Settings</a>
			            <a href="viewlisting.jsp">My Listings</a>			        
			    	</div>		        
				</div>				 		 	        
	    	</div> 	    	 	
	 	</div>
	 	<div class="categories">
            <a href="DisplayCategoryServlet?category=electronics">Electronics</a>
            <a href="DisplayCategoryServlet?category=women-fashion">Women Fashion</a>
            <a href="DisplayCategoryServlet?category=men-fashion">Men Fashion</a>
            <a href="DisplayCategoryServlet?category=living">Living</a>
            <a href="DisplayCategoryServlet?category=accessories">Accessories</a>
            <a href="DisplayCategoryServlet?category=beauty-health">Beauty & Health</a>
            <a href="DisplayCategoryServlet?category=sporting-goods">Sporting Goods</a>
            <a href="DisplayCategoryServlet?category=pet-supplies">Pet Supplies</a>
	    </div>		    	
	</div>	  
    <div class="search-container">
            <form action="SearchServlet" method="get">
                <select name="category">
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
                <input type="text" name="query" placeholder="Search for anything and everything...">
                <button type="submit">Search</button>
            </form>
            <div class="user-func">
	            <a href="createListing.jsp">Sell</a>                     
	            <a href="logout">Logout</a>
	            <a href="#" id="bell-icon"><img src="images/bell.png" alt="Notifications"></a>
	            <a href="watchlist.jsp"><img src="images/heart.png" alt="Image 2"></a>
	            <a href="ViewCartServlet?accountID=${accountID}"><img src="images/shopping-cart.png" alt="Image 3"></a>
			</div>
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

                    <label for="first-name">First Name:</label>
                    <span id="first-name">${fname}</span>
                    
                    <label for="last-name">Last Name:</label>
                    <span id="last-name">${lname}</span>
                    
                    <label for="username">Username:</label>
                    <span id="username">${username}</span>
                    
                    <label for="email">Email:</label>
                    <span id="email">${email}</span>
                    
                    <label for="phone">Phone number:</label>
                    <span id="phone">${mobile}</span>
                    
                    <button onclick="window.location.href = 'updateprofile.jsp';">Edit</button>
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
        
        // JavaScript to toggle notification dropdown
        document.addEventListener("DOMContentLoaded", function() {
            const bellIcon = document.getElementById("bell-icon");
            const notificationDropdown = document.getElementById("notificationDropdown");

            bellIcon.addEventListener("click", function(event) {
                event.preventDefault();
                notificationDropdown.classList.toggle("show");
            });

            // Close the dropdown if the user clicks outside of it
            window.addEventListener("click", function(event) {
                if (!bellIcon.contains(event.target) && !notificationDropdown.contains(event.target)) {
                    notificationDropdown.classList.remove("show");
                }
            });
        });

        function filterNotifications() {
            const filter = document.getElementById('notificationFilter').value;
            const notifications = document.querySelectorAll('.notification-item');

            notifications.forEach(notification => {
                if (filter === 'all' || notification.getAttribute('data-category') === filter) {
                    notification.style.display = 'block';
                } else {
                    notification.style.display = 'none';
                }
            });

            checkNotifications();
        }

        function checkNotifications() {
            const notifications = document.querySelectorAll('.notification-item');
            const noNotificationMessage = document.getElementById('noNotification');
            if (notifications.length === 0 || Array.from(notifications).every(notification => notification.style.display === 'none')) {
                noNotificationMessage.style.display = 'block';
            } else {
                noNotificationMessage.style.display = 'none';
            }
        }

        function toggleSelection(notificationItem) {
            const checkbox = notificationItem.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
            notificationItem.classList.toggle('selected', checkbox.checked);
        }
    </script>
</body>
</html>
