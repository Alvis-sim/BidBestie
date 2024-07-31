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
                <!-- Add categories dynamically if needed -->
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
        <span>Hi, ${fname} ${lname}!</span>
        <div class="links">
            <a href="registration.jsp">Register</a>
            <a href="login.jsp">Login</a>
            <a href="login.jsp">Sell</a>
            <a href="Product">Load</a>
            <a href="notification.jsp"><img src="images/bell.png" alt="Notifications"></a>
            <a href="watchlist.jsp"><img src="images/heart.png" alt="Watchlist"></a>
            <a href="#"><img src="images/shopping-cart.png" alt="Cart"></a>
        </div>
    </div>
    <br><br><br>
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
<!-- Checkout Summary -->
<div class="checkout-summary">
    <h2>Summary</h2>
    <p><%= cartItems != null ? cartItems.size() : 0 %> Item(s): SGD $<%= cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() : 0.00 %></p>
    <p class="total">Total: SGD $<%= cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() : 0.00 %></p>
    
    <hr><br>
    <h3>I'll Pay with:</h3>
    <br>
    <label><input type="radio" name="payment" value="stripe"> <i class="fa fa-credit-card"></i> Credit/Debit Card (Stripe)</label>
    <br><br>
    <label><input type="radio" name="payment" value="paypal"> <i class="fa fa-paypal"></i> PayPal</label>

    <form id="redirect-form" action="payment.jsp" method="post">
        <input type="hidden" name="totalAmount" value="<%= (long)(cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() * 100 : 0) %>"> <!-- Amount in cents -->
        <button type="submit" class="button buybutton">Buy for $<%= cartItems != null ? cartItems.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum() : 0.00 %></button>
    </form>
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
                <a href="www.whatsapp.com"><i class="fa fa-whatsapp"></i></a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
