<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/viewproductreminder.css"%></style>
    <title>BidBestie | Upcoming Auctions</title>
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
            <select id="category" onchange="filterAuctions()">
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
                <input type="text" placeholder="Search..." onkeyup="filterAuctions()">
                <i class="fa fa-search search-icon"></i>
            </div>
            <button type="submit" onclick="filterAuctions()">Search</button>
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
</div>

<br>

<div class="container">
    <div class="row">
        <div class="column">
            <div class="product-header">
                <h2>Nintendo Switch Console OLED</h2>
                <br>
                <div class="slideshow-container">
                    <div class="mySlides fade">
                        <img src="images/nintendoswitch.jpg" alt="Nintendo Switch Console OLED">
                    </div>
                    <div class="mySlides fade">
                        <img src="images/nintendoswitch2.jpg" alt="Nintendo Switch Console OLED">
                    </div>
                    <div class="mySlides fade">
                        <img src="images/joycon.jpg" alt="Joycon">
                    </div>
                    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                    <a class="next" onclick="plusSlides(1)">&#10095;</a>
                </div>
                <br>
                <div class="dot-container">
                    <span class="dot" onclick="currentSlide(1)"></span> 
                    <span class="dot" onclick="currentSlide(2)"></span> 
                    <span class="dot" onclick="currentSlide(3)"></span> 
                </div>
            </div>
        </div>
        <div class="column">
        <div class="product-info">
                <h3>Product Details</h3>
                <ul>
                    <li><strong>Color:</strong> White</li>
                    <li><strong>Retail Price:</strong> $350</li>
                    <li><strong>Release Date:</strong> 05/25/2024</li>
                    <li><strong>Included Accessories:</strong> Joycon, Charger, HDMI cable</li>
                </ul>
            </div>
            <hr>
            <div class="product-description">
                <h3>Product Description</h3>
                <p>100% Authentic Guaranteed</p>
            </div>
            <div class="product-description">
                <h3>Shipping</h3>
                <p>Japan Post or FedEx or DHL (tracked & insured)(5-10days)</p>
            </div>
            <div class="product-description">
                <h3>International Buyers - Please Note</h3>
                <p>Import duties, taxes, and charges are not included in the item price or shipping cost. These charges are the buyer's responsibility.
                Please check with your country's customs office to determine what these additional costs will be prior to bidding or buying.
                These charges are normally collected by the delivering freight (shipping) company or when you pick the item up.)</p>
            </div>
            <br>
            <a href="#" class="remind-me">Remind Me</a>    
        </div>
    </div>
</div>
    
<br>

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
                <a href="https://www.whatsapp.com"><i class="fa fa-whatsapp"></i></a>
            </div>
        </div>
    </div>
</div>

<script>
    let slideIndex = 1;
    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("mySlides");
        let dots = document.getElementsByClassName("dot");
        if (n > slides.length) {slideIndex = 1}
        if (n < 1) {slideIndex = slides.length}
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex-1].style.display = "block";
        dots[slideIndex-1].className += " active";
    }
</script>
</body>
</html>