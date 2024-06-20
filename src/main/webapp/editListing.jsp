<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Listing</title>
    <link rel="stylesheet" type="text/css" href="css/editListing.css">
</head>
<body>
    <div class="bidbestie">
        <h1>BidBestie</h1>
    </div>
    <div class="editlisting-container">
        <h2>Edit Listing</h2>
        <form action="ProcessEditProductServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" id="productID" name="productID" value="${product.id}">
            <input type="hidden" id="accountID" name="accountID" value="${sessionScope.accountID}">
            <label for="name">Name of Product:</label>
            <input type="text" id="name" name="name" value="${product.name}" required>
            <label for="category">Category:</label>
            <select name="categories" id="categories" required>
                <option value="electronics" <c:if test="${product.category == 'electronics'}">selected</c:if>>Electronic</option>
                <option value="women-fashion" <c:if test="${product.category == 'women-fashion'}">selected</c:if>>Women Fashion</option>
                <option value="men-fashion" <c:if test="${product.category == 'men-fashion'}">selected</c:if>>Men Fashion</option>
                <option value="living" <c:if test="${product.category == 'living'}">selected</c:if>>Living</option>
                <option value="accessories" <c:if test="${product.category == 'accessories'}">selected</c:if>>Accessories</option>
                <option value="beauty-health" <c:if test="${product.category == 'beauty-health'}">selected</c:if>>Beauty & Health</option>
                <option value="travel" <c:if test="${product.category == 'travel'}">selected</c:if>>Travel</option>
                <option value="sporting-goods" <c:if test="${product.category == 'sporting-goods'}">selected</c:if>>Sporting Goods</option>
                <option value="pet-supplies" <c:if test="${product.category == 'pet-supplies'}">selected</c:if>>Pet Supplies</option>
            </select>
            <label for="productdescription">Description of Product:</label>
            <input type="text" id="description" name="description" value="${product.description}" required>
            <label for="productquantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" value="${product.quantity}" required>
            <label for="buyitnow">Buy it Now price ($):</label>
            <input type="number" id="buyitnow" name="buyitnow" value="${product.buyitnow}" required>
            <label for="shipping">Shipping details:</label>
            <input type="text" id="shipping" name="shipping" value="${product.shipping}" required>
            <label for="image">Insert image:</label>
            <input type="file" id="image" name="image" style="background-color: white;">
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
