<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Update Listing</title>
		<link href="css/updatelisting.css" rel="stylesheet" />
	</head>
	
	<body>
		<div class="bidbestie">
        	<h1>BidBestie</h1>
    	</div>
    	<div class="createlisting-container">
        	<h2>Update Listing</h2>
	        <form>
	            <label for="name">Name of Product:</label>
	            <input type="text" id="name" required>
	            
	            <label for="category">Category:</label>
	            <select name="categories" id="categories">
					<option value="searchByCat" selected disabled hidden>Search by category</option>
  					<option value="electronics">Electronic</option>
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
	            <input type="text" id="description" required>
	            
	            <label for="quantity">Quantity:</label>
	            <input type="number" id="quantity" required>
	            
	            <label for="buyitnow">Buy it Now price ($):</label>
	            <input type="number" id="buyitnow" required>
	            
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
	            
	            <label for="shipping">POSTAGE:</label>
	            <label for="shipping">Shipping details:</label>
	            <input type="text" id="shipping" required>
	            
	            <label for="image">ADD IMAGE:</label>
	            <label for="image">Insert image:</label>
				<input type="file" id="image" name="image" style="background-color: white;" onchange="previewImage(event)">
				<img id="imagePreview" style="display:none; max-width:100%; height:auto; margin-top:15px;"/>
	            <br></br>
	            <button type="submit" class="form-button">Submit</button><br></br>
	            <a href="viewlisting.jsp" class="form-button cancel-button">Cancel</a>
	        </form>
	    </div>
	    <script src="updatelisting.js"></script>
	</body>
</html>