<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<title>View Listing</title>
		<link href="css/viewlisting.css" rel="stylesheet" />
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
	    	<select id="category">
	            <option value="">By Categories</option>
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
	        <input type="text" placeholder="Search for anything and everything">
	        <a href="searchResults.jsp"><button type="submit" class="search-button">Search</button></a>
	        <div class="user-func">
	            <a href="createlisting2.jsp">Sell</a>         
	            <a href="Product">Load</a>
	            <a href="logout">Logout</a>
	            <a href="#" id="bell-icon"><img src="images/bell.png" alt="Notifications"></a>
	            <a href="login.jsp"><img src="images/heart.png" alt="Image 2"></a>
	            <a href="login.jsp"><img src="images/shopping-cart.png" alt="Image 3"></a>
			</div>
	    </div>     
	</div>

    <!-- Notification drop down container -->
    <div id="notificationDropdown" class="notification-dropdown">
        <!-- Header and Filters -->
        <div class="notification-header">
            <div class="notification-filter">
                <select id="notificationFilter" onchange="filterNotifications()">
                    <option value="all">All</option>
                    <option value="new-orders">New Orders</option>
                    <option value="buyer-news">Buyer News</option>
                    <option value="important-updates">Important updates</option>
                </select>
            </div>
            <div class="right">
                <a href="viewlisting.jsp">View order details</a>
                <a href="viewfeedback.jsp">Reply Messages</a>
                <div class="batch-action">
                    <a href="#"><span id="batchAction">[Mark as read</span></a><a href="#">Delete</a>]
                </div>
            </div>
        </div>

        <!-- Notification Content -->
        <div id="notificationGrid" class="notification-grid">
            <div class="notification-item" data-category="new-orders">
                <input type="checkbox">
                <h3>New Order</h3>
                <p>Order number: #12345</p>
                <p>Time: 24/05/2024 14:32</p>
                <p>Buyer: Saamm123</p>
                <p>Product: Product A x2</p>
                <p>Total amount: 200</p>
                <p>Status: Pending</p>
            </div>
            <div class="notification-item" data-category="buyer-news">
                <input type="checkbox">
                <h3>Buyer Message</h3>
                <p>Message Time: 24/05/2024 13:00</p>
                <p>Buyer: Ammy789</p>
                <p>Message Preview: Can discount?</p>
                <p>Status: Unread</p>
            </div>
            <div class="notification-item" data-category="important-updates">
                <input type="checkbox">
                <h3>Important Update</h3>
                <p>Notice time: 2024-05-25 10:00</p>
                <p>Title: Platform Maintenance Bulletin</p>
                <p>Content Preview: The system will be maintained on May 28, 2024...</p>
                <p>Status: Read</p>
            </div>
            <!-- Add more notification items as needed -->
        </div>
        
        <div id="noNotification" class="no-notification">
            <img src="images/postbox.png" alt="NoNotification">
            No Notifications
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
			  	<a href="#">Messages</a>
			  	<a href="viewfeedback.jsp">Feedback</a>
			</div>
        <main>
            <div class="main-content">
            	<h2>Active Listing</h2><br></br>
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
                <a href="createListing2.jsp" class="create-listing">+ Create Listing</a>
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