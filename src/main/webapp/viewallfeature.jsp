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
    <style><%@include file="css/viewallfeature.css"%></style>
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

<!-- Filter Options Section -->
<div class="filter-options">
    <label for="category-filter">Category:</label>
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

<!-- Featured Lots Section -->
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC", "root", "root");
        stmt = conn.createStatement();
        String sql = "SELECT productName, image, buyNowPrice FROM product";
        rs = stmt.executeQuery(sql);

   
%>
<div class="featured-lots">
    <h2>Featured Products</h2>
    <div class="featured-lots-container">
        <%
	        while (rs.next()) {
	            String productName = rs.getString("productName");
	            byte[] image = rs.getBytes("image");
	            double buyNowPrice = rs.getDouble("buyNowPrice");
        %>
        <div class="lot">
            <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
        <%
                if (image != null) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(image);
        %>
            <a href="product_page.jsp?productName=<%= URLEncoder.encode(productName, "UTF-8") %>">
            <img src="data:image/jpeg;base64,<%= base64Image %>"/>
                
            </a>
            <p><%= productName %></p>
            <p class="price">SGD <%= buyNowPrice %></p>
            <p class="status closed">CLOSED</p>
        </div>
        <%
            }
	        	}
        %>
    </div>
    <a href="viewallfeature.jsp" class="see-all">See All</a>
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
    function toggleLike(element) {
        element.classList.toggle('liked');
    }

    function filterAuctions() {
        const category = document.getElementById('category-filter').value.toLowerCase();
        const searchInput = document.querySelector('.search-container input').value.toLowerCase();
        const minPrice = document.getElementById('min-price').value;
        const maxPrice = document.getElementById('max-price').value;
        const lots = document.querySelectorAll('.lot');

        lots.forEach(lot => {
            const lotCategory = lot.getAttribute('data-category').toLowerCase();
            const lotText = lot.innerText.toLowerCase();
            const lotPrice = parseFloat(lot.getAttribute('data-price'));

            const matchesCategory = !category || lotCategory.includes(category);
            const matchesSearch = !searchInput || lotText.includes(searchInput);
            const matchesPrice = (!minPrice || lotPrice >= minPrice) && (!maxPrice || lotPrice <= maxPrice);

            lot.style.display = (matchesCategory && matchesSearch && matchesPrice) ? 'block' : 'none';
        });

        currentPage = 1;
        updatePagination();
    }

    const itemsPerPage = 12;
    let currentPage = 1;
    let totalPages = 10;

    document.addEventListener('DOMContentLoaded', () => {
        updatePagination();
    });

    function updatePagination() {
        const lots = document.querySelectorAll('.lot');
        totalPages = Math.ceil(lots.length / itemsPerPage);

        lots.forEach((lot, index) => {
            lot.style.display = (index >= (currentPage - 1) * itemsPerPage && index < currentPage * itemsPerPage) ? 'block' : 'none';
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
</script>
</body>
</html>
