<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.registration.Product" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/viewupcoming.css"%></style>
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
            <a href="#"><img src="images/bell.png" alt="Image 1"></a>
            <a href="#"><img src="images/heart.png" alt="Image 2"></a>
            <a href="#"><img src="images/shopping-cart.png" alt="Image 3"></a>
        </div>
    </div>
</div>

<div class="upcoming-auctions">
    <h2>Upcoming Auctions</h2>
    <div class="filter-options">
        <label for="category">Category:</label>
        <select id="category-filter" onchange="filterAuctions()">
            <option value="">All Categories</option>
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

        <label for="min-price">Min Price:</label>
        <input type="number" id="min-price" placeholder="Min" oninput="filterAuctions()">

        <label for="max-price">Max Price:</label>
        <input type="number" id="max-price" placeholder="Max" oninput="filterAuctions()">
    </div>
    <br>
    <div class="upcoming-auctions-container">
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/ipad.jpg" alt="ipad">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">13d 6hrs 56mins 45sec</p>
                <p>Ipad Air Gen 2 9.7 inch display 128gb rose gold wifi</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/nintendoswitch.jpg" alt="nintendo switch">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">6d 6hrs 56mins 45sec</p>
                <p>Nintendo Console OLED Switch - White</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/chanelbag.jpg" alt="chanel bags">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">2d 4hrs 12mins 33sec</p>
                <p>CHANEL Pre-Owned 1992-1994 Diana shoulder bag</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_gucci_shoe.html">
                <img src="images/guccishoe.jpg" alt="guccishoe">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">2d 4hrs 12mins 33sec</p>
                <p>WOMEN'S RHYTON GUCCI LOGO LEATHER TRAINER size US 36</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_samsung_tv.html">
                <img src="images/tv.jpg" alt="Samsung TV">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">3d 5hrs 45mins 22sec</p>
                <p>Samsung 55" Crystal 4K UHD Smart TV UA55AU7500</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_macbook.html">
                <img src="images/macbook.jpg" alt="MacBook Pro">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">5d 11hrs 20mins 12sec</p>
                <p>MacBook Pro 16" 2021, M1 Pro, 512GB SSD</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_headphones.html">
                <img src="images/customkeyboard.jpg" alt="custom keyboard">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">7d 2hrs 45mins 55sec</p>
                <p>Fully Customizable Full Size Mechanical Keyboard</p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="viewproductreminder.jsp">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        <div class="auction">
            <a href="auction_page_watch.html">
                <img src="images/camera.jpg" alt="camera">
            </a>
            <div class="auction-details">
                <p class="auction-title">Bids Starting</p>
                <p class="auction-timer">10d 9hrs 30mins 50sec</p>
                <p>Nikon Zfc Mirrorless Camera with 16-50mm Lens </p>
                <a href="#" class="remind-me">Remind me »</a>
            </div>
        </div>
        
    </div>
    
</div>
    <div class="pagination">
        <button onclick="prevPage()">Prev</button>
        <span id="page-number">Page 1</span>
        <button onclick="nextPage()">Next</button>
    </div>

<!-- Footer Section -->
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
    const itemsPerPage = 12;
    let currentPage = 1;
    let totalPages = 10;

    document.addEventListener('DOMContentLoaded', () => {
        updatePagination();
    });

    function updatePagination() {
        const auctions = document.querySelectorAll('.auction');
        totalPages = Math.ceil(auctions.length / itemsPerPage);

        auctions.forEach((auction, index) => {
            auction.style.display = (index >= (currentPage - 1) * itemsPerPage && index < currentPage * itemsPerPage) ? 'block' : 'none';
        });

        document.getElementById('page-number').textContent = `Page ${currentPage}`;
    }

    function nextPage() {
        if (currentPage < totalPages) {
            currentPage++;
            updatePagination();
        }
    }

    function prevPage() {
        if (currentPage > 1) {
            currentPage--;
            updatePagination();
        }
    }

    function filterAuctions() {
        const category = document.getElementById('category').value.toLowerCase();
        const searchInput = document.querySelector('.search-container input').value.toLowerCase();
        const minPrice = document.getElementById('min-price').value;
        const maxPrice = document.getElementById('max-price').value;
        const auctions = document.querySelectorAll('.auction');

        auctions.forEach(auction => {
            const auctionCategory = auction.getAttribute('data-category').toLowerCase();
            const auctionText = auction.innerText.toLowerCase();
            const auctionPrice = parseFloat(auction.getAttribute('data-price'));

            const matchesCategory = !category || auctionCategory.includes(category);
            const matchesSearch = !searchInput || auctionText.includes(searchInput);
            const matchesPrice = (!minPrice || auctionPrice >= minPrice) && (!maxPrice || auctionPrice <= maxPrice);

            auction.style.display = (matchesCategory && matchesSearch && matchesPrice) ? 'block' : 'none';
        });

        currentPage = 1;
        updatePagination();
    }
</script>
</body>
</html>
