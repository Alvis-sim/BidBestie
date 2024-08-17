<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.registration.Product" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/watchlist.css"%></style>
    <title>BidBestie | Watch List</title>
    <link rel="icon" type="image/png" href="path/to/your/favicon.png">
</head>
<body>
<div class="sticky-top">
    <div class="top-header">
        <div class="left-section">
            <div class="logo">
                <a href="UserLanding.jsp"><img src="images/bid_bestie.png" alt="Bid Bestie Logo"></a>
            </div>
            <div class="user-info">
                <div class="dropdown">
                    <span class="dropbtn">Hi, ${fname} ${lname} !<span class="arrow-down"></span></span>
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
            <a href="createListing.jsp">Sell</a>
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
<br><br><br>

<div class="watchlist-container">
    <h1>Watchlist</h1>
    <div class="watchlist-grid">
        <% 
            List<Product> watchlist = (List<Product>) request.getAttribute("watchlist");
            if (watchlist != null && !watchlist.isEmpty()) {
                for (Product product : watchlist) {
        %>
            <div class="watchlist-item" onclick="location.href='productDetails.jsp?id=<%= product.getId() %>'">
                <img src="<%= product.getImagePath() %>" alt="<%= product.getName() %>">
                <div class="delete-icon" onclick="event.stopPropagation(); location.href='RemoveFromWatchlistServlet?productID=<%= product.getId() %>'"></div>
                <div class="watchlist-details">
                    <h2><%= product.getName() %></h2>
                    <p>Product ID: <%= product.getId() %></p>
                    <p>Price: $<%= product.getPrice() %></p>
                    <p>Date Added: <%-- Date and time information should be managed appropriately --%></p>
                    <p><%-- Calculate and display the time since added --%></p>
                </div>
            </div>
        <% 
                }
            } else {
        %>
            <div class="no-more-lots">
                <p>No items in your watchlist.</p>
            </div>
        <% 
            }
        %>
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
</script>

</body>
</html>
