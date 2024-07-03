<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BidBestie - Payment</title>
    <link href="css/payment.css" rel="stylesheet" />
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body>
    <div class="payment-container">
        <h1>Payment Information</h1>
        <form id="payment-form" action="processPayment" method="post">
            <div class="form-group">
                <label for="card-element">Credit or debit card</label>
                <div id="card-element">
                    <!-- A Stripe Element will be inserted here. -->
                </div>
                <!-- Used to display form errors. -->
                <div id="card-errors" role="alert"></div>
            </div>
            <button type="submit" class="submit-button">Submit Payment</button>
        </form>
    </div>
    <script src="js/payment.js"></script>
</body>
</html>
