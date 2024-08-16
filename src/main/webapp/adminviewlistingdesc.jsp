<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>

<%
    HttpSession httpSession = request.getSession(false);
    String username = (httpSession != null) ? (String) httpSession.getAttribute("adminUser") : null;
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
</head>
<body>
    <div class="header">
        <a href="adminViewListing.jsp" class="back-link">Back to Admin View</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="product-details">
            <h1>${productName}</h1>
            <div class="slideshow-and-info-container">
                <div class="slideshow-container">
                    <!-- Slideshow images here -->
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
                            <img class="demo cursor" src="" style="width:80%" onclick="currentSlide(2)" alt="Thumbnail 2">
                        </div>
                        <div class="column">
                            <img class="demo cursor" src="" style="width:80%" onclick="currentSlide(3)" alt="Thumbnail 3">
                        </div>
                    </div>
                </div>
                <div class="product-info-container">
                    <i class="fa fa-heart heart-icon" onclick="toggleLike(this)"></i>
                    <div class="info-box">
                        <h2>Product Information</h2>
                        <p><strong>Product ID:</strong> ${productID}</p>
                        <p><strong>Buy Now Price:</strong> $${buyNowPrice}</p>
                        <p><strong>Description:</strong> ${productDescription}</p>
                        <p><strong>Category:</strong> ${productCategory}</p>
                        <p><strong>Quantity:</strong> ${Quantity}</p>
                        <p><strong>Start Date:</strong> ${sDate}</p>
                        <p><strong>End Date:</strong> ${eDate}</p>
                    </div>
                </div>
            </div>
        </div>
            
        <div class="remove-listing">
            <form id="removeListingForm" action="DeleteListingServlet" method="post" onsubmit="return confirm('Are you sure you want to remove this listing?');">
                <input type="hidden" name="productID" value="${productID}">
                <button type="submit">Remove Listing</button>
            </form>
        </div>
    </div>
    
</body>
</html>
