<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Create Listing</title>
		<link rel="stylesheet" type="text/css" href="css/createListing2.css">
	</head>
	
	<body>
		<div class="bidbestie">
        	<h1>BidBestie</h1>
    	</div>
    	<div class="createlisting-container">
        	<h2>Create Listing</h2>
	        <form action="ProcessSellProductServlet" method="post" enctype="multipart/form-data">
	            <label for="name">Name of Product:</label>
	            <input type="text" id="name" name ="name" required>
	            <input type="hidden" name="accountID" value="${accountID}"/>     
	            <label for="category">Category:</label>
    			<select name="categories" id="categories" required>
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
	            
	            <label for="productdescription">Description of Product:</label>
    			<input type="text" id="description" name="description" required>

    			<label for="productquantity">Quantity:</label>
    			<input type="number" id="quantity" name="quantity" required>

    			<label for="buyitnow">Buy it Now price ($):</label>
    			<input type="number" id="buyitnow" name="buyitnow" required>

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
        			<input type="number" id="auctionDuration" name="auctionDuration">
    			</div>
	            
	            <label for="shipping">POSTAGE:</label>
    			<label for="shipping">Shipping details:</label>
    			<input type="text" id="shipping" name="shipping" required>

    			<label for="image">ADD IMAGE:</label>
    			<label for="image">Insert image:</label>
    			<input type="file" id="image" name="image" style="background-color: white;">

    			<button type="submit">Submit</button>
		</form>
		<script>
    			document.getElementById('auctionToggle').addEventListener('change', function() {
        			const auctionFields = document.getElementById('auctionFields');
        			if (this.checked) {
           				auctionFields.classList.remove('hidden');
        			} else {
            			auctionFields.classList.add('hidden');
        			}
    			});
		</script>
	    </div>
	    
	    
	    
	</body>
</html>