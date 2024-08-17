<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("login.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/Landingpage.css"%></style>
    <title>BidBestie | Home</title>
    <script>
        function startTimer(endDate, elementId) {
            var countDownDate = new Date(endDate).getTime();

            var x = setInterval(function() {
                var now = new Date().getTime();
                var distance = countDownDate - now;

                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                document.getElementById(elementId).innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById(elementId).innerHTML = "EXPIRED";
                }
            }, 1000);
        }

        function openWebSocket(productID) {
            // Initialize WebSocket
            let ws = new WebSocket("ws://" + document.location.host + "/auction/" + productID);

            ws.onopen = function () {
                ws.send(JSON.stringify({ action: "subscribe", productID: productID }));
            };

            ws.onmessage = function (event) {
                var log = document.getElementById("bidLog");
                if (log) {
                    log.innerHTML += event.data + "<br>";
                }
            };

            ws.onclose = function () {
                console.log("WebSocket connection closed");
            };

            ws.onerror = function (error) {
                console.error("WebSocket error: " + error);
            };
        }
    </script>
    <link rel="icon" type="image/png" href="path/to/your/favicon.png">
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
                <p>Total amount: ¥200</p>
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
    <br>
	

    <div class="banner">
        <div class="banner-content">
            <div class="banner-text">
                <h1>Best Bids In July</h1>
                <p>Bid Now And Make It Yours Today!</p>
                <button class="shop-now">Shop now</button>
            </div>
            <div class="banner-slideshow">
                <!-- Slides Container -->
                <div class="slides-container active-slide">
                    <img src="images/watches.png" alt="Watches">
                    <div class="image-text">
                        <h2>Unlock the Power of Time</h2>
                        <p>Amazing Savings Await You!</p>
                    </div>
                </div>
                <div class="slides-container">
                    <img src="images/gaming.png" alt="Gaming">
                    <div class="image-text">
                        <h2>Unlock Your Gaming Potential!</h2>
                        <p>Epic Deals Await You!</p>
                    </div>
                </div>
                <div class="slides-container">
                    <img src="images/ndp.png" alt="Shirt">
                    <div class="image-text">
                        <h2>National Day Is Coming!</h2>
                        <p>Faster Get Your Hands On It!</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br>


    <div style="text-align:center">
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
    </div>


<!-- Featured Lots Section -->
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");
        stmt = conn.createStatement();
        
        // First query: Newest products
        String sqlNewest = "SELECT productID, productName, image, buyNowPrice, eDate FROM product ORDER BY eDate DESC";
        rs = stmt.executeQuery(sqlNewest);
%>
<div class="featured-lots">
    <h2>Newest Products</h2>
    <div class="featured-lots-container">
        <%
            int counter = 0;
            while (rs.next() && counter < 8) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                byte[] image = rs.getBytes("image");
                double buyNowPrice = rs.getDouble("buyNowPrice");
                String eDate = rs.getString("eDate");
                counter++;
        %>
        <div class="lot">
            <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
            <%
                if (image != null) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(image);
            %>
            <a href="viewlistingdesc?productID=<%= URLEncoder.encode(productID, "UTF-8") %>" onclick="openWebSocket('<%= productID %>')">
                <img src="data:image/jpeg;base64,<%= base64Image %>"/>
            </a>
            <p><%= productName %></p>
            <p class="price">SGD <%= buyNowPrice %></p>
            <p>Ends: <span id="timer-<%= productName.hashCode() %>"></span></p>
            <script>
                startTimer("<%= eDate %>", "timer-<%= productName.hashCode() %>");
            </script>
        </div>
        <%
                }
            }
        %>
    </div>
    <a href="viewallfeature.jsp" class="see-all">See more newest products</a>
</div>

<%
        // Second query: Ending soon products
        String sqlEndingSoon = "SELECT productID, productName, image, buyNowPrice, eDate FROM product WHERE eDate > NOW() ORDER BY eDate ASC";
        rs = stmt.executeQuery(sqlEndingSoon);
%>
<div class="featured-lots">
    <h2>Ending Soon!</h2>
    <div class="featured-lots-container">
        <%
            counter = 0;
            while (rs.next() && counter < 8) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                byte[] image = rs.getBytes("image");
                double buyNowPrice = rs.getDouble("buyNowPrice");
                String eDate = rs.getString("eDate");
                counter++;
        %>
        <div class="lot">
            <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
            <%
                if (image != null) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(image);
            %>
            <a href="viewlistingdesc?productID=<%= URLEncoder.encode(productID, "UTF-8") %>" onclick="openWebSocket('<%= productID %>')">
                <img src="data:image/jpeg;base64,<%= base64Image %>"/>
            </a>
            <p><%= productName %></p>
            <p class="price">SGD <%= buyNowPrice %></p>
            <p>Ends: <span id="timer-<%= productName.hashCode() %>"></span></p>
            <script>
                startTimer("<%= eDate %>", "timer-<%= productName.hashCode() %>");
            </script>
        </div>
        <%
                }
            }
        %>
    </div>
    <a href="viewallfeature.jsp" class="see-all">See more products ending soon</a>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>


    <div class="Categories">
        <br>
        <h2>Categories</h2>
        <div class="items">
            <div class="item">
                <a href="DisplayCategoryServlet?category=electronics">
                    <img src="images/electronics.jpg" alt="electronics">
                </a>
                <p>Electronics</p>
            </div>
            <div class="item">
                <a href="DisplayCategoryServlet?category=women-fashion">
                    <img src="images/female_fashion.jpg" alt="Women Fashion">
                </a>
                <p>Women Fashion</p>
            </div>
            <div class="item">
                <a href="DisplayCategoryServlet?category=men-fashion">
                    <img src="images/male_fashion.jpg" alt="Men Fashion">
                </a>
                <p>Men Fashion</p>
            </div>
        </div>
        <div class="items">
            <div class="item">
                <a href="DisplayCategoryServlet?category=living">
                    <img src="images/living.jpg" alt="Living">
                </a>
                <p>Living</p>
            </div>
            <div class="item">
                <a href="DisplayCategoryServlet?category=accessories">
                    <img src="images/accessories.jpg" alt="Accessories">
                </a>
                <p>Accessories</p>
            </div>
            <div class="item">
                <a href="DisplayCategoryServlet?category=beauty-health">
                    <img src="images/beautyhealth.jpg" alt="Beauty & Health">
                </a>
                <p>Beauty & Health</p>
            </div>
        </div>
        <div class="items">
            <div class="item">
                <a href="DisplayCategoryServlet?category=travel">
                    <img src="images/travel.jpg" alt="Travel">
                </a>
                <p>Travel</p>
            </div>
            <div class="item">
                <a href="DisplayCategoryServlet?category=sporting-goods">
                    <img src="images/sporting.jpg" alt="Sporting Goods">
                </a>
                <p>Sporting Goods</p>
            </div>
            <div class="item">
                <a href="DisplayCategoryServlet?category=pet-supplies">
                    <img src="images/pet.jpg" alt="Pet Supplies">
                </a>
                <p>Pet Supplies</p>
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
    function toggleLike(element) {
        element.classList.toggle('liked');
    }

    let slideIndex = 0;
    const slides = document.querySelectorAll(".slides-container");
    const dots = document.querySelectorAll(".dot");
    const totalSlides = slides.length;

    const changeSlide = (n) => {
        slides[slideIndex].classList.remove("active-slide");
        dots[slideIndex].classList.remove("active-dot");
        slideIndex = (slideIndex + n + totalSlides) % totalSlides;
        slides[slideIndex].classList.add("active-slide");
        dots[slideIndex].classList.add("active-dot");
    };

    const showSlides = () => {
        slides[slideIndex].classList.remove("active-slide");
        dots[slideIndex].classList.remove("active-dot");
        slideIndex = (slideIndex + 1) % totalSlides;
        slides[slideIndex].classList.add("active-slide");
        dots[slideIndex].classList.add("active-dot");
        setTimeout(showSlides, 7000); // Change image every 7 seconds
    };

    const currentSlide = (n) => {
        slides[slideIndex].classList.remove("active-slide");
        dots[slideIndex].classList.remove("active-dot");
        slideIndex = n - 1;
        slides[slideIndex].classList.add("active-slide");
        dots[slideIndex].classList.add("active-dot");
    };

    // Initialize the slideshow
    showSlides();
    </script>
    	<script>
	//JavaScript to toggle notification dropdown
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
