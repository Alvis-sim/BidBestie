<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>

<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/notification.css"%></style>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <title>BidBestie | Notification</title>
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
    <br><br>

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
            <a href="#">View order details</a>
            <a href="viewfeedback.jsp">Reply Messages</a>
            <div class="batch-action">
                <a href="#"><span id="batchAction">[Mark as read</span></a><a href="#">Delete</a>]
            </div>
        </div>
    </div>

    <div id="notificationGrid" class="notification-grid">
        <!-- notification blocks -->
      	<div class="notification-item" data-category="new-orders" onclick="toggleSelection(this)">
            <input type="checkbox">
            <h3>New Order</h3>
            <p>Order number: #12345</p>
            <p>Time: 24/05/2024 14:32</p>
            <p>Buyer: Saamm123</p>
            <p>Product: Product A x2</p>
            <p>Total amount: ¥200</p>
            <p>Status: Pending</p>
        </div>
        <div class="notification-item" data-category="buyer-news" onclick="toggleSelection(this)">
            <input type="checkbox">
            <h3>Buyer Message</h3>
            <p>Message Time: 24/05/2024 13:00</p>
            <p>Buyer: Ammy789</p>
            <p>Message Preview: Can discount?</p>
            <p>Status: Unread</p>
        </div>
        <div class="notification-item" data-category="important-updates" onclick="toggleSelection(this)">
            <input type="checkbox">
            <h3>Important Update</h3>
            <p>Notice time: 2024-05-25 10:00</p>
            <p>Title: Platform Maintenance Bulletin</p>
            <p>Content Preview: The system will be maintained on May 28, 2024...</p>
            <p>Status: Read</p>
        </div>
        <div class="notification-item" data-category="important-updates" onclick="toggleSelection(this)">
            <input type="checkbox">
            <h3>Important Update</h3>
            <p>Notice time: 2024-05-21 19:00</p>
            <p>Title: Platform Maintenance Bulletin</p>
            <p>Content Preview: The system will be maintained on May 28, 2024...</p>
            <p>Status: Read</p>
        </div>
        <!-- more notification -->
    </div>
    
    <div id="noNotification" class="no-notification">
    	<img src="images/postbox.png" alt="NoNotification">
        No Notifications
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            checkNotifications();
        });

        function checkNotifications() {
            const notifications = document.querySelectorAll('.notification-item');
            const noNotificationMessage = document.getElementById('noNotification');
            if (notifications.length === 0) {
                noNotificationMessage.style.display = 'block';
            } else {
                noNotificationMessage.style.display = 'none';
            }
        }

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

        function toggleSelection(notificationItem) {
            const checkbox = notificationItem.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
            notificationItem.classList.toggle('selected', checkbox.checked);
        }
    </script>
       
</body>
</html>