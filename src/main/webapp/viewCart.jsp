<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cart.CartItem" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/shoppingcart.css">
    <title>BidBestie | Shopping Cart</title>
    <link rel="icon" type="image/png" href="path/to/your/favicon.png">
    <script src="https://js.stripe.com/v3/"></script>
    <style>
        /* Custom styling for Stripe Elements */
        .StripeElement {
            box-sizing: border-box;
            height: 40px;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: white;
            box-shadow: 0 1px 3px 0 #e6ebf1;
            transition: box-shadow 150ms ease;

            width: 100%;
        }

        .StripeElement--focus {
            box-shadow: 0 1px 3px 0 #cfd7df;
        }

        .StripeElement--invalid {
            border-color: #fa755a;
        }

        .StripeElement--webkit-autofill {
            background-color: #fefde5 !important;
        }

        .hidden {
            display: none;
        }
    </style>
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

<!-- Checkout Container -->
<div class="checkout-container">
    <div class="checkout-info">
        <h2>Checkout</h2>
        <div class="section personal-info">
            <h3>Confirm Your Personal Information:</h3>
            <div class="info-content">
                <div class="info-text">
                    <p>Aefh Olef</p>
                    <p>13/08, 36 ABC Ave, Singapore, 123456</p>
                    <p>6753 0000</p>
                    <a href="#">Change</a>
                </div>
            </div>
        </div>
        <div class="section item-info">
            <h3>Confirm Your Item(s):</h3>
            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                if (cartItems != null && !cartItems.isEmpty()) {
                    for (CartItem item : cartItems) {
            %>
            <div class="item">
                <div class="checkbox-image">
                    <input type="checkbox" name="selectedItems" value="<%= item.getcartItemID() %>">
                    <img src="data:image/jpeg;base64,<%= item.getImageBase64() %>" alt="Product Image" class="item-image">
                </div>
                <div class="details">                    
                    <p><strong><%= item.getProductName() %></p>                    
                    <p>SGD $<%= item.getPrice() %></p>                   
                    
                </div>
                <div class="quantity-container">
                    <div class="quantity">
                        <label for="quantity<%= item.getcartItemID() %>">Qty:</label>
                        <select id="quantity<%= item.getcartItemID() %>" name="quantity<%= item.getcartItemID() %>">
                            <option value="1" <%= item.getQuantity() == 1 ? "selected" : "" %>>1</option>
                            <option value="2" <%= item.getQuantity() == 2 ? "selected" : "" %>>2</option>
                            <!-- Add more quantities as needed -->
                        </select>
                        <form action="RemoveCartItemServlet" method="post">
                        <input type="hidden" name="productID" value="<%= item.getcartItemID() %>"/>
                        <input type="submit" value="Remove" class="remove-btn"/>
                    </form>
                    </div>
                    <p>Returns Accepted</p>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p>Your cart is empty.</p>
            <%
                }
            %>
        </div>
    </div>
</div>   
<!-- Checkout Summary -->
<div class="checkout-summary">
    <h2>Summary</h2>
    <p><%= cartItems != null ? cartItems.size() : 0 %> Item(s): SGD $<%= cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() : 0.00 %></p>
    <p class="total">Total: SGD $<%= cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() : 0.00 %></p>
    
    <hr><br>
    <h3>I'll Pay with:</h3>
    <br>
    <label><input type="radio" name="payment" value="stripe" onclick="showStripeForm()"> <i class="fa fa-credit-card"></i> Credit/Debit Card (Stripe)</label>
    <br><br>
    <label><input type="radio" name="payment" value="paypal" onclick="hideStripeForm()"> <i class="fa fa-paypal"></i> PayPal</label>

    <!-- Stripe Payment Form -->
    <div id="stripe-form" class="hidden">
        <form id="payment-form" action="processPayment" method="post">
            <input type="hidden" name="totalAmount" value="<%= (long)(cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() * 100 : 0) %>"> <!-- Amount in cents -->
            <div class="form-group">
                <label for="card-element">Credit or debit card</label>
                <div id="card-element">
                    <!-- A Stripe Element will be inserted here. -->
                </div>
                <!-- Used to display form errors. -->
                <div id="card-errors" role="alert"></div>
            </div>
            <button id="pay-button">Pay</button>
        </form>
    </div>
</div>

<script>
    function showStripeForm() {
        document.getElementById('stripe-form').classList.remove('hidden');
    }

    function hideStripeForm() {
        document.getElementById('stripe-form').classList.add('hidden');
    }
</script>

<script src="js/payment.js"></script>

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
            <p>Email: bidbestie@gmail.com</p>
            <div class="social-icons">
                <a href="https://www.facebook.com"><i class="fa fa-facebook"></i></a>
                <a href="https://www.instagram.com"><i class="fa fa-instagram"></i></a>
                <a href="https://www.youtube.com"><i class="fa fa-youtube"></i></a>
                <a href="www.whatsapp.com"><i class="fa fa-whatsapp"></i></a>
            </div>
        </div>
    </div>
</div>

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
