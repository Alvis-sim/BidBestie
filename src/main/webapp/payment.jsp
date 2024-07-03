<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BidBestie - Payment</title>
    <link href="css/payment.css" rel="stylesheet" />
</head>
<body>
    <div class="payment-container">
        <h1>Payment Information</h1>
        <form action="processPayment" method="post">
            <div class="form-group">
                <label for="cardNumber">Card Number</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="form-group">
                <label for="cardName">Name on Card</label>
                <input type="text" id="cardName" name="cardName" required>
            </div>
            <div class="form-group">
                <label for="expiryDate">Expiry Date</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" required>
            </div>
            <div class="form-group">
                <label for="billingAddress">Billing Address</label>
                <input type="text" id="billingAddress" name="billingAddress" required>
            </div>
            <div class="form-group">
                <label for="billingZip">Billing ZIP Code</label>
                <input type="text" id="billingZip" name="billingZip" required>
            </div>
            <button type="submit" class="submit-button">Submit Payment</button>
        </form>
    </div>
    <script src="payment.js"></script>
</body>
</html>
