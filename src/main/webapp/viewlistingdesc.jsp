<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession httpSession = request.getSession(false);
    String username = (httpSession != null) ? (String) httpSession.getAttribute("username") : null;
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
        var stripe, card;

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
        });

        function connect() {
            var username = "<%= username %>";
            if (!username) {
                alert("Username is required to join the auction.");
                return;
            }
            var ws = new WebSocket("ws://" + document.location.host + "<%= request.getContextPath() %>/auction/" + encodeURIComponent(username));
            ws.onmessage = function(event) {
                var log = document.getElementById("bidLog");
                log.innerHTML += event.data + "<br>";
            };
            ws.onclose = function() {
                console.log("WebSocket connection closed");
            };
            ws.onerror = function(error) {
                console.error("WebSocket error: " + error);
            };
        }

        function handleBid() {
        	var username = "<%= username %>";
            if (!username || username === "null") {
                window.location.href = "login.jsp";
                return;
            }
            var bidAmount = document.getElementById("bidAmount").value;
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
                }
            });
        }
        window.onload = connect;
    </script>
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
            <span>${fname} ${lname}!</span>
            <div class="links">
                <a href="viewaccount.jsp">My Account</a>
                <a href="logout">Logout</a>
                <a href="#"><i class="fa fa-bell"></i></a>
                <a href="#"><i class="fa fa-heart"></i></a>
                <a href="#"><i class="fa fa-shopping-cart"></i></a>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="product-details">
            <h1>${productName}</h1>
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
                                <button id="addToCartButton" type="submit" class="button cartbutton">Buy Now</button>
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
            <div id="bidLog" style="border:1px solid black; height:300px; overflow:auto;"></div>
            <input type="text" id="bidAmount" placeholder="Enter your bid amount" />
            <button onclick="handleBid()">Place Bid</button>
			<form id="payment-form" action="processPayment" method="post">
			    <div id="card-element"></div>
			    <div id="card-errors" role="alert"></div>
			    <input type="hidden" name="totalAmount" id="totalAmount">
			    <input type="hidden" name="bidAmount" id="bidAmountHidden">
			    <button type="submit" style="display: none;">Submit Payment</button>
			</form>
        </div>
    </div>
    <!-- Featured Lots Section -->
    <div class="related-lots">
        <h2>Related Products</h2>
        <div class="related-lots-container">
            <div class="lot">
                <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
                <a href="product_page_iphone15.html">
                    <img src="images/iphone15.jpg" alt="iPhone 15 Pro">
                </a>
                <p>iPhone 15 Pro, 256Gb - Blue Titanium</p>
                <p>Lowest Ask</p>
                <p class="price">SGD 1220</p>
                <div class="last-sale">Last Sale: $91</div>
            </div>
            <div class="lot">
                <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
                <a href="product_page_jersey.html">
                    <img src="images/jersey.jpg" alt="mbappe">
                </a>
                <p>Mbappe # 10 Soccer Jersey, Shorts + Socks Jersey Kit</p>
                <p>Lowest Ask</p>
                <p class="price">SGD 220</p>
                <div class="last-sale">Last Sale: $91</div>
            </div>
            <div class="lot">
                <a href="product_page_cat_litter.html">
                    <img src="images/catlitter.jpg" alt="cat litter">
                </a>
                <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
                <p>XLAIQ Smart Self-Cleaning Cat Litter Box, 1-10kg Cats</p>
                <p>Lowest Ask</p>
                <p class="price">SGD 1000</p>
                <div class="last-sale">Last Sale: $91</div>
            </div>
            <div class="lot">
                <a href="product_page_vancleef_earring.html">
                    <img src="images/vancleef_earring.jpg" alt="Van Cleef Arpels Alhambra earrings">
                </a>
                <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
                <p>Van Cleef Arpels Alhambra earrings white-gold pearl</p>
                <p>Lowest Ask</p>
                <p class="price">SGD 3000</p>
                <div class="last-sale">Last Sale: $91</div>
            </div>
        </div>
        <a href="AllFeaturedLots.jsp" class="see-all">See All</a>
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
                    <a href="https://www.whatsapp.com"><i class="fa fa-whatsapp"></i></a>
                </div>
            </div>
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
                slides[i].style.display = "none";
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
