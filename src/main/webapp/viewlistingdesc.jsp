<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession httpSession = request.getSession(false);
    String username = (httpSession != null) ? (String) httpSession.getAttribute("username") : null;
    String productID = request.getParameter("productID");

    if (httpSession != null && productID != null) {
        httpSession.setAttribute("productID", productID);
        System.out.println("Setting productID in session: " + productID);
    }

    String auctionWinner = (httpSession != null) ? (String) httpSession.getAttribute("auctionWinner") : null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>View Product Listing</title>
    <link rel="stylesheet" href="css/viewlistingdesc.css">
    <script src="https://js.stripe.com/v3/"></script>
<script type="text/javascript">
    var stripe, card, ws, username;

    document.addEventListener("DOMContentLoaded", function() {
        stripe = Stripe('pk_test_51PYQCORpr2L9wI5un6zMRFL5IxvSp5n58ACRSLKNmKq2K0wF8mjQYadL3Ok5oUCxXnAvYPOOOROPSzbREllmzhKn001uCrkuQp'); // Replace with your Stripe public key
        var elements = stripe.elements();

        var style = {
            base: {
                color: '#32325d',
                fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
                fontSmoothing: 'antialiased',
                fontSize: '16px',
                '::placeholder': {
                    color: '#aab7c4'
                }
            },
            invalid: {
                color: '#fa755a',
                iconColor: '#fa755a'
            }
        };

        card = elements.create('card', {style: style});
        card.mount('#card-element');

        card.addEventListener('change', function(event) {
            var displayError = document.getElementById('card-errors');
            if (event.error) {
                displayError.textContent = event.error.message;
            } else {
                displayError.textContent = '';
            }
        });

        var form = document.getElementById('payment-form');
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            stripe.createToken(card).then(function(result) {
                if (result.error) {
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                } else {
                    stripeTokenHandler(result.token);
                }
            });
        });

        function stripeTokenHandler(token) {
            var form = document.getElementById('payment-form');
            var hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);

            form.submit();
        }

        username = "<%= username %>";
        if (username && username !== "null") {
            connect();
        }
    });

    function connect() {
        if (!username) {
            alert("Username is required to join the auction.");
            return;
        }
        if (ws && ws.readyState === WebSocket.OPEN) {
            return; // If WebSocket is already open, don't create a new connection
        }
        ws = new WebSocket("ws://" + document.location.host + "<%= request.getContextPath() %>/auction/" + encodeURIComponent(username));
        ws.onmessage = function(event) {
            var log = document.getElementById("bidLog");
            log.innerHTML += event.data + "<br>";

            // Extract the bid amount from the message
            var message = event.data;
            var bidAmountRegex = /\$([0-9]+(\.[0-9]{1,2})?)/;
            var match = message.match(bidAmountRegex);

            if (match) {
                var bidAmount = parseFloat(match[1]);
                var highestBidElement = document.getElementById("highestBidAmount");
                var currentHighestBid = parseFloat(highestBidElement.innerText);

                // Update the highest bid if the new bid is higher
                if (bidAmount > currentHighestBid) {
                    highestBidElement.innerText = bidAmount.toFixed(2);
                }
            }
        };
        ws.onclose = function() {
            console.log("WebSocket connection closed");
        };
        ws.onerror = function(error) {
            console.error("WebSocket error: " + error);
        };
    }

    function handleBid() {
        if (!username || username === "null") {
            window.location.href = "login.jsp";
            return;
        }

        var bidAmount = document.getElementById("bidAmount").value;
        var productID = document.getElementById("productIDHidden").value;

        if (!bidAmount || isNaN(bidAmount) || bidAmount <= 0) {
            alert("Please enter a valid bid amount.");
            return;
        }

        var bidAmountHidden = document.getElementById("bidAmountHidden");
        var totalAmount = document.getElementById("totalAmount");

        if (bidAmountHidden === null || totalAmount === null) {
            console.error("Hidden input elements not found in the DOM.");
            return;
        }

        bidAmountHidden.value = bidAmount;
        totalAmount.value = bidAmount * 100; // Convert to cents for Stripe

        // Create Stripe token before form submission
        var form = document.getElementById('payment-form');
        stripe.createToken(card).then(function(result) {
            if (result.error) {
                var errorElement = document.getElementById('card-errors');
                errorElement.textContent = result.error.message;
                console.error("Token creation error: ", result.error.message);
            } else {
                var hiddenTokenInput = document.createElement('input');
                hiddenTokenInput.setAttribute('type', 'hidden');
                hiddenTokenInput.setAttribute('name', 'stripeToken');
                hiddenTokenInput.setAttribute('value', result.token.id);
                form.appendChild(hiddenTokenInput);

                console.log("Token and bid amount added to form, submitting form...");
                form.submit();

                // Send bid and product ID to WebSocket server after successful payment
                if (ws.readyState === WebSocket.OPEN) {
                    ws.send(JSON.stringify({bidAmount: bidAmount, productID: productID}));
                } else {
                    ws.onopen = function() {
                        ws.send(JSON.stringify({bidAmount: bidAmount, productID: productID}));
                    };
                }
            }
        });
    }

    window.onunload = function() {
        if (ws) {
            ws.close();
        }
    };

    window.onload = connect;
    function updateCountdown() {
        var eDate = new Date("<%= request.getAttribute("eDate") %>");
        var now = new Date();
        var nowUtc = new Date(Date.UTC(
            now.getUTCFullYear(), 
            now.getUTCMonth(), 
            now.getUTCDate(), 
            now.getUTCHours(), 
            now.getUTCMinutes(), 
            now.getUTCSeconds()
        ));
        var timeDifference = eDate - nowUtc;

        if (timeDifference <= 0) {
            document.getElementById('countdown').innerHTML = "Auction Ended";
            // Hide the bidding elements when the auction has ended
            document.getElementById('bidAmount').style.display = 'none';
            document.querySelector('.bidding button').style.display = 'none';

            // Optionally, you can also disable the form submission
            document.getElementById('payment-form').style.display = 'none';
            // Trigger finalization when countdown reaches zero
            finalizeAuction();
            return;
        }

        var days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
        var hours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

        document.getElementById('countdown').innerHTML =
            days + "d " +
            hours + "h " +
            minutes + "m " +
            seconds + "s ";
    }

    // Call the function every second
    setInterval(updateCountdown, 1000);

    // Initial call to display immediately
    updateCountdown();

    function finalizeAuction() {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "FinalizeAuctionServlet", true); // The servlet URL to finalize the auction
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("Auction finalized.");
            }
        };
        xhr.send("productID=" + encodeURIComponent("<%= productID %>"));
    }

</script>


</head>
<head>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style><%@include file="css/Landingpage.css"%></style>
    <title>BidBestie | Home</title>
    <link rel="icon" type="image/png" href="path/to/your/favicon.png">
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
                <a href="createListing.jsp">Sell</a>         
                <a href="Product">Load</a>
                <a href="logout">Logout</a>
                <a href="login.jsp"><img src="images/bell.png" alt="Image 1"></a>
                <a href="login.jsp"><img src="images/heart.png" alt="Image 2"></a>
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

    <!-- Main Content -->
    <div class="main-content">
        <div class="product-details">
            <h1>${productName}</h1>
            <h1>${productID}</h1>
            <div class="slideshow-and-buy-now-container">
                <div class="slideshow-container">
                    <div class="mySlides fade">
                        <div class="numbertext">1 / 3</div>
                        <img src="data:image/jpeg;base64,${base64Image}" class="slide-img" alt="Product Image 1"/>
                    </div>
                    <div class="mySlides fade">
                        <div class="numbertext">2 / 3</div>
                        <img src="images/macbook.jpg" class="slide-img" alt="Product Image 2">
                    </div>
                    <div class="mySlides fade">
                        <div class="numbertext">3 / 3</div>
                        <img src="images/nintendoswitch.jpg" class="slide-img" alt="Product Image 3">
                    </div>
                    <!-- Next and previous buttons -->
                    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                    <a class="next" onclick="plusSlides(1)">&#10095;</a>
                    <!-- Thumbnail images -->
                    <div class="row">
                        <div class="column">
                            <img class="demo cursor" src="data:image/jpeg;base64,${base64Image}" style="width:80%" onclick="currentSlide(1)" alt="Thumbnail 1">
                        </div>
                        <div class="column">
                            <img class="demo cursor" src="images/macbook.jpg" style="width:80%" onclick="currentSlide(2)" alt="Thumbnail 2">
                        </div>
                        <div class="column">
                            <img class="demo cursor" src="images/nintendoswitch.jpg" style="width:80%" onclick="currentSlide(3)" alt="Thumbnail 3">
                        </div>
                    </div>
                </div>
                <!-- to put buttons (place bid, buy, add to cart, add to watchlist -->
                <div class="buy-now-container">
                    <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
                    <div class="price-info">
                        <div class="price-box">
                            <h2>Buy Now for</h2>
                            <p class="price">$${buyNowPrice}</p>
                            <button class="place-bid">Place Bid</button>
                            <form id="addToCartForm" action="AddToCartServlet" method="post">
                                <input type="hidden" name="productID" value="${productID}">
                                <input type="hidden" name="productName" value="${productName}">
                                <input type="hidden" name="price" value="${buyNowPrice}">
                                <input type="hidden" name="imageBase64" value="${base64Image}">
                                <button id="addToCartButton" type="submit" class="place-bid">Add to cart</button>
                            </form>
                            <p class="last-sale">Last Sale: $147</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="description-container">
                <h3> Product Description </h3>
                <div class="details-container">
                    <div class="left-details">
                        <p><strong>Style</strong> M1906DA</p>
                        <br>
                        <p><strong>Colorway</strong> CASTLEROCK/HARBOR GREY/SILVER METALLIC</p>
                        <br>
                        <p><strong>Retail Price</strong> $165</p>
                        <br>
                        <p><strong>Release Date</strong> 01/06/2023</p>
                    </div>
                    <div class="right-description">
                        <div id="more-description">
                            <p>${productDescription}</p>
                        </div>
                        <a href="javascript:void(0);" onclick="toggleDescription()" id="toggleButton">Read More</a>
                    </div>
                </div>
            </div>
        </div>
        <br><br>
        <!-- Bidding Section -->
        <div class="bidding">
            <h1>Auction Bidding System with Payment</h1>
            <h1 id="highestBid">Current Highest Bid: $<span id="highestBidAmount"><%= request.getAttribute("currentBid") %></span></h1>
            <h1><div class="countdown" id="countdown"></div></h1>
                <!-- Display the winner if auction has ended -->
                <%
                    if (auctionWinner != null) {
                %>
                    <h2>Auction Ended. Winner: <%= auctionWinner %></h2>
                <%
                    }
                %>
            <div id="bidLog" style="border:1px solid black; height:300px; overflow:auto;"></div>
            <input type="text" id="bidAmount" placeholder="Enter your bid amount" />
            <button onclick="handleBid()">Place Bid</button>
            <form id="payment-form" action="processPayment" method="post">
                <div id="card-element"></div>
                <div id="card-errors" role="alert"></div>
                <input type="hidden" name="totalAmount" id="totalAmount">
                <input type="hidden" name="bidAmount" id="bidAmountHidden">
                <input type="hidden" name="productID" id="productIDHidden" value="${productID}">
                <button type="submit" style="display: none;">Submit Payment</button>
            </form>
        </div>
    </div>


    <script>
        function toggleLike(element) {
            element.classList.toggle('liked');
        }

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
            let dots = document.getElementsByClassName("demo");
            let captionText = document.getElementById("caption");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i.style.display = "none"];
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
            captionText.innerHTML = dots[slideIndex - 1].alt;
        }

        function toggleDescription() {
            var moreText = document.getElementById("more-description");
            var toggleButton = document.getElementById("toggleButton");

            if (moreText.style.display === "none" || moreText.style.display === "") {
                moreText.style.display = "block";
                toggleButton.innerHTML = "Read Less";
            } else {
                moreText.style.display = "none";
                toggleButton.innerHTML = "Read More";
            }
        }
    </script>
</body>
</html>
