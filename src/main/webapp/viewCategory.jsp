<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Optional" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/viewcategory.css"%></style>
    <title>BidBestie | View Category</title>
    <script>
        function startTimer(endDate, elementId) {
            var countDownDate = new Date(endDate).getTime();

            var x = setInterval(function() {
                var now = new Date().getTime();
                var distance = countDownDate - now;

                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                document.getElementById(elementId).innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById(elementId).innerHTML = "EXPIRED";
                }
            }, 1000);
        }
    </script>
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
            <a href="watchlist.jsp"><img src="images/heart.png" alt="Image 2"></a>
            <a href="ViewCartServlet?accountID=${accountID}"><img src="images/shopping-cart.png" alt="Image 3"></a>
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
	
	<div class="category_main">
	<div class="breadcrumb">
        <a href="Landingpage.jsp">Home</a> / <span>Products</span>
    </div>
    <h1>Products</h1>
    
    <div class="filters">
        <input type="text" placeholder="Search">
        <div class="filter-buttons">
            <button onclick="openFilterSidebar()">Filters</button>
            <button>List View</button>
            <button>Grid View</button>
        </div>
    </div>

    
    <div class="bags-grid">
        <%
            String category = Optional.ofNullable(request.getParameter("category")).orElse("").trim();
            if (!category.isEmpty()) {
                try (Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", 
                        "root", 
                        "root");
                     PreparedStatement stmt = conn.prepareStatement("SELECT productName, image, buyNowPrice, eDate FROM product WHERE productCategory=?")) {

                    stmt.setString(1, category);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            String productName = rs.getString("productName");
                            byte[] image = rs.getBytes("image");
                            double buyNowPrice = rs.getDouble("buyNowPrice");
                            String eDate = rs.getString("eDate");

                            String base64Image = image != null ? Base64.getEncoder().encodeToString(image) : "";
        %>
		<div class="bag-item">
		    <img src="<%= image != null ? "data:image/jpeg;base64," + base64Image : "images/default.jpg" %>" alt="<%= productName %>">
		    <div class="bag-details">
		        <h2><%= productName %></h2>
		        <p>Buy Now Price: <%= buyNowPrice %></p>
		        <p>Ends: <span id="timer-<%= productName.hashCode() %>"></span></p>
		        <script>
		            startTimer("<%= eDate %>", "timer-<%= productName.hashCode() %>");
		        </script>
		        <button class="status-button accepting-bids">Accepting Bids</button>
		        <div class="icons">
		            <div class="icon" data-tooltip="Number of bids">
		                <img src="images/hammer.png" alt="Number of bids">
		                <span>0</span>
		            </div>
		            <div class="icon" data-tooltip="Add to wishlist">
		                <img src="images/heart.png" alt="Add to wishlist">
		                <span>9</span>
		            </div>
		            <div class="icon" data-tooltip="Number of views">
		                <img src="images/eye_icon.png" alt="Number of views">
		                <span>15</span>
		            </div>
		        </div>
		    </div>
		</div>

        <%
                        }
                    }
                } catch (SQLException e) {
                    out.println("<p>Error loading products. Please try again later.</p>");
                    e.printStackTrace();
                }
            } else {
                out.println("<p>Category not specified.</p>");
            }
        %>
    </div>
    
    <!-- Filter Sidebar -->
    <div id="filterSidebar" class="filter-sidebar">
        <div class="filter-sidebar-content">
            <h2>Filters</h2>
            <ul class="filter-list">
                <li>Price Range <span>&rsaquo;</span></li>
                <li>Brand <span>&rsaquo;</span></li>
                <li>Gender <span>&rsaquo;</span></li>
                <li>Specifications <span>&rsaquo;</span></li>
                <li>Condition <span>&rsaquo;</span></li>
                <li>Closing Date <span>&rsaquo;</span></li>
            </ul>
            <div class="filter-actions">
                <button class="clear-all">Clear All</button>
                <button class="apply-filter">Apply Filter</button>
            </div>
        </div>
    </div>
    
    <!-- Footer Section -->
    <div class="footer">
        <div class="footer-container">
            <div class="footer-column">
                <h3>Company</h3>
                <ul>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Auction Rules</a></li>
                    <li><a href="#">Refund Return Policy</a></li>
                    <li><a href="#">User Agreement</a></li>
                    <li><a href="#">Personal Data Protection</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                    <li><a href="#">Distance Sales Contract</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Support</h3>
                <ul>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Preliminary Information Form</a></li>
                    <li><a href="#">Bank Transfer Information</a></li>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Terms and Conditions</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Product</h3>
                <ul>
                    <li><a href="#">Buy With Us</a></li>
                    <li><a href="#">Sell With Us</a></li>
                    <li><a href="#">Reviews</a></li>
                </ul>
                <br>
                <p>Email: tphelp@tpauctions.net</p>
                <div class="social-icons">
                    <a href="https://www.facebook.com"><i class="fa fa-facebook"></i></a>
                    <a href="https://www.instagram.com"><i class="fa fa-instagram"></i></a>
                    <a href="https://www.youtube.com"><i class="fa fa-youtube"></i></a>
                    <a href=" www.whatsapp.com"><i class="fa fa-whatsapp"></i></a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function openFilterSidebar() {
            document.getElementById("filterSidebar").style.width = "300px";
        }

        function closeFilterSidebar() {
            document.getElementById("filterSidebar").style.width = "0";
        }
    </script>
</body>
</html>
