<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("login.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link href="css/Landingpage.css" rel="stylesheet" />
    <title>BidBestie | Home</title>
</head>
<body>
    <div class="top">
        <div class="logo">
            <a href="your-link-here" class="header-link"><h1>BidBestie</h1></a>
        </div>
        <div class="search">
            <select id="category">
                <option value="">Search by Category</option>
                <option value="electronics">Electronics</option>
                <option value="women-fashion">Women Fashion</option>
                <option value="men-fashion">Men Fashion</option>
                <option value="living">Living</option>
                <option value="accessories">Accessories</option>
                <option value="beauty-health">Beauty & Health</option>
                <option value="travel">Travel</option>
                <option value="sporting-goods">Sporting Goods</option>
                <option value="pet-supplies">Pet Supplies</option>
            </select>
            <input type="text" placeholder="Search...">
            <button type="submit">Search</button>
            <button type="submit">Advanced Search</button>
        </div>
    </div>

    <div class="user-info">
        <span>Hi, ${fname} ${lname} !</span>
        <div class="links">
            <a href="userprofile.jsp">My Account</a>
            <a href="logout">Logout</a>
            <a href="createListing2.jsp">Sell</a>
            <a href="viewlisting.jsp">View listing</a>
            <a href="#"><img src="images/bell.png" alt="Image 1"></a>
            <a href="#"><img src="images/heart.png" alt="Image 2"></a>
            <a href="#"><img src="images/shopping-cart.png" alt="Image 3"></a>
        </div>
        
    </div>

    <ul class="categories">
        <li><a href="DisplayCategoryServlet?category=electronics">Electronics</a></li>
        <li><a href="DisplayCategoryServlet?category=women-fashion">Women Fashion</a></li>
        <li><a href="DisplayCategoryServlet?category=men-fashion">Men Fashion</a></li>
        <li><a href="DisplayCategoryServlet?category=living">Living</a></li>
        <li><a href="DisplayCategoryServlet?category=accessories">Accessories</a></li>
        <li><a href="DisplayCategoryServlet?category=beauty-health">Beauty and Health</a></li>
        <li><a href="DisplayCategoryServlet?category=travel">travel</a></li>
        <li><a href="DisplayCategoryServlet?category=sporting-goods">Sporting Goods</a></li>
        <li><a href="DisplayCategoryServlet?category=pet-supplies">Pet Supplies</a></li>
    </ul>

        <div class="Categories">
        <h2>Categories</h2>
        <div class="items">
            <div class="item">
            	<a href="DisplayCategoryServlet?category=electronics">
          			<img src="images/smartwatch.jpg" alt="smartwatch">
        		</a>
                <p>Electronics</p>
            </div>
            <div class="item">
            	<a href="DisplayCategoryServlet?category=Women Fashion">
                	<img src="images/womenfashion.jpg" alt="iphone15">
                </a>
                <p>Women Fashion</p>
            </div>
            <div class="item">
            	<a href="DisplayCategoryServlet?category=men-fashion">
                	<img src="images/menfashion.jpg" alt="menfashion">
                	</a>
                <p>Men Fashion</p>
            </div>
            
        </div>
        <div class="items">
            <div class="item">
            	<a href="DisplayCategoryServlet?category=Living">
                	<img src="images/living.jpg" alt="living">
                </a>
                <p>Living</p>
            </div>
            <div class="item">
            	<a href="DisplayCategoryServlet?category=Accessories">
                	<img src="images/accessories.jpg" alt="accessories">
                </a>
                <p>Accessories</p>
            </div>
            <div class="item">
            	<a href="DisplayCategoryServlet?category=B&H">
                	<img src="images/beauty.jpg" alt="beauty&health">
                </a>
                <p>Beauty & Health</p>
            </div>            
        </div>
        <div class="items">            
            <div class="item">
            	<a href="DisplayCategoryServlet?category=Travel">
                	<img src="images/travel.jpg" alt="travel">
             	</a>
                <p>Travel</p>
            </div>
            <div class="item">
            	<a href="DisplayCategoryServlet?category=sporting-goods">
                	<img src="images/sporting.jpg" alt="sporting">
                </a>
                <p>Sporting Goods</p>
            </div>
             <div class="item">
             	<a href="DisplayCategoryServlet?category=Pet Supplies">
                	<img src="images/petsupplies.jpg" alt="smartwatch">
                </a>
                <p>Pet Supplies</p>
            </div>
        </div>
    </div>
</body>
</html>
