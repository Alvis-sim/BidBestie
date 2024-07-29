<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Create Listing</title>
    <style><%@include file="css/createListing2.css"%></style>
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
                <input type="text" placeholder="Search..." size='50'>
                <i class="fa fa-search search-icon"></i>
            </div>
            <button type="submit">Search</button>
            <button type="submit">Advanced Search</button>
        </div>
    </div>

    <div class="user-info">
        <span>Hi, ${fname} ${lname} !</span>
        <div class="links">
            <a href="viewaccount.jsp">My Account</a>
            <a href="viewlisting.jsp">View Listing</a>
            <a href="createlisting2.jsp">Sell</a>
            <a href="logout">Logout</a>
            <a href="notification.jsp"><img src="images/bell.png" alt="Image 1"></a>
            <a href="watchlist.jsp"><img src="images/heart.png" alt="Image 2"></a>
            <a href="#"><img src="images/shopping-cart.png" alt="Image 3"></a>
        </div>
    </div>
    <br>
</div>

<div class="createlisting-container">
    <h2>Create Listing</h2>
    <br><br>
    <form action="ProcessSellProductServlet" method="post" enctype="multipart/form-data">
        <!-- Hidden field for accountID -->
        <input type="hidden" id="accountID" name="accountID" value="${accountID}">
        
        <h3>Title</h3>
        <br><br>
        <label for="name">Name of Product:</label>
        <input type="text" id="name" name="name" required>
        <br><br>
        <hr>
        <br><br>

        <h3>Product Description</h3>
        <br><br>
        <label for="category">Category:</label>
        <select name="categories" id="categories">
            <option value="searchByCat" selected disabled hidden>Search by category</option>
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

        <label for="description">Description of Product:</label>
        <textarea id="productDescription" name="description" rows="10" cols="50" required></textarea>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required>

        <label for="buyitnow">Buy it Now price ($):</label>
        <input type="number" id="buyitnow" name="buyitnow" required>
        <br><br>
        <hr>
        <br><br>
        <h3>Set Product for Auction</h3>
        <br><br>
        <div id="auctionToggleContainer">
            <label for="auctionToggle">AUCTION:</label>
            <label class="switch">
                <input type="checkbox" id="auctionToggle" name="auctionToggle">
                <span class="slider"></span>
            </label>
        </div>

        <div id="auctionFields" class="hidden">
            <label for="startingBidPrice">Starting bid price ($):</label>
            <input type="number" id="startingBidPrice" name="startingBidPrice">

            <label for="startdate">Schedule start listing date:</label>
            <input type="date" id="startdate" name="startdate">

            <label for="enddate">Schedule end listing date:</label>
            <input type="date" id="enddate" name="enddate">

            <label for="auctionDuration">Auction duration (days):</label>
            <input type="number" id="auctionDuration" name="auctionDuration"><br><br>
        </div>
        <br><br>
        <hr>
        <br><br>
        <h3>Pricing Details</h3>
        <br><br>
        
        <label for="shipping">Shipping details:</label>
        <textarea id="shippingdetails" name="shipping" rows="10" cols="50" required></textarea>
        <br><br>
        <hr>
        <br><br>
        <h3>Add Photos</h3>
        <br><br>
        
        <p>You can add up to 3 photos. Buyers want to see all details and angles.</p>
        <br>
        <br>
        <div class="photo-upload-container">
        <br>
            <input type="file" id="images" name="image" multiple onchange="previewImages(event)">
            <label for="images" class="photo-upload-label">
                <div class="photo-upload-instructions">
                    <i class="fa fa-camera"></i>
                    <span>Add photos</span>
                    <p>Click to add up to 3 photos</p>
                </div>
            </label>
            <div id="imagePreviews" class="image-previews"></div>
        </div>
        
        <br></br>
        <br><br>
        <button type="submit" class="form-button">Submit</button><br></br>
        <a href="viewlisting.jsp" class="form-button cancel-button">Cancel</a>
    </form>
</div>

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
document.getElementById('auctionToggle').addEventListener('change', function() {
    const auctionFields = document.getElementById('auctionFields');
    if (this.checked) {
        auctionFields.classList.remove('hidden');
    } else {
        auctionFields.classList.add('hidden');
    }
});

function previewImages(event) {
    const previewsContainer = document.getElementById('imagePreviews');
    const files = event.target.files;

    if (files.length > 3) {
        alert('You can upload a maximum of 3 images.');
        event.target.value = ''; // Clear the input
        return;
    }

    previewsContainer.innerHTML = '';
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.style.maxWidth = '200px';
            previewsContainer.appendChild(img);
        };
        reader.readAsDataURL(file);
    }
}
</script>
</body>
</html>
