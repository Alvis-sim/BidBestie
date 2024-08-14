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
            <span>Hi, Guest!</span>
            <div class="links">
                <a href="registration.jsp">Register</a>
                <a href="login.jsp">Login</a>
                <a href="login.jsp">Sell</a>
                <a href="Product">Load</a>
                <a href="notification.jsp"><img src="images/bell.png" alt="Image 1"></a>
                <a href="#"><img src="images/heart.png" alt="Image 2"></a>
                <a href="#"><img src="images/shopping-cart.png" alt="Image 3"></a>
            </div>
        </div>
        <br><br><br>
    </div>
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
