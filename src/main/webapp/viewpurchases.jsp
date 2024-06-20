<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Purchases</title>
    <link href="css/viewpurchases.css" rel="stylesheet" />
</head>
<body>
    <div class="top">
        <div class="logo">
            <a href="userLanding.jsp"><h1>BidBestie</h1></a>
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
        <span>User!</span>
        <div class="links">
            <a href="viewaccount.jsp">My Account</a>
            <a href="register.jsp">Register</a>
            <a href="#" id="logoutLink">Logout</a>
            <a href="#"><i class="fa fa-bell"></i></a>
            <a href="#"><i class="fa fa-heart"></i></a>
            <a href="#"><i class="fa fa-shopping-cart"></i></a>
        </div>  
    </div>

    <!-- Main container wrapping sidebar and content -->
    <div class="main-container">
        <div class="sidenav">
            <a href="viewaccount.jsp">Profile</a>
            <a href="#">Purchases</a>
            <button class="dropdown-btn">Selling 
                <i class="fa fa-caret-down" style="font-size:24px"></i>
            </button>
            <div class="dropdown-container">
                <a href="viewlisting.jsp">Active</a>
                <a href="#">Inventory</a>
                <a href="#">Analytics</a>
            </div>
            <a href="viewmessages.jsp">Messages</a>
			<a href="viewfeedback.jsp">Feedback</a>
        </div>
        <main>
            <div class="content">
                <h1>Purchases</h1>
                <div class="purchases-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>ID</th>
                                <th>Type of Listing</th>
                                <th>Price</th>
                                <th>Shipping Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Product A</td>
                                <td>12</td>
                                <td>Buy It Now</td>
                                <td>$123.45</td>
                                <td>Delivered</td>
                            </tr>
                            <tr>
                                <td>Product B</td>
                                <td>23</td>
                                <td>Auction</td>
                                <td>$89.70</td>
                                <td>Shipped</td>
                            </tr>
                            <tr>
                                <td>Product C</td>
                                <td>34</td>
                                <td>Auction</td>
                                <td>$67.35</td>
                                <td>Out for delivery</td>
                            </tr>
                            <tr>
                                <td>Product D</td>
                                <td>45</td>
                                <td>Auction</td>
                                <td>Bidding in-progress</td>
                                <td>-</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <script>
    var dropdown = document.getElementsByClassName("dropdown-btn");
    var i;

    for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
            } else {
                dropdownContent.style.display = "block";
            }
        });
    }
    
    
    </script>
</body>
</html>
