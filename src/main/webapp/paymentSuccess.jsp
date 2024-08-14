<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success</title>
    <link rel="stylesheet" type="text/css" href="css/success.css">
    <script>
        function startCountdown() {
            var countdown = 10;
            var countdownElement = document.getElementById("countdown");
            var timer = setInterval(function() {
                countdown--;
                countdownElement.innerHTML = countdown;
                if (countdown <= 0) {
                    clearInterval(timer);
                    window.location.href = "UserLanding.jsp";
                }
            }, 1000);
        }
    </script>
</head>
<body onload="startCountdown()">
    <div class="container">
        <h1>Payment Successful</h1>
        <p>Thank you for your purchase!</p>
        <p>Your payment was processed successfully.</p>
        <p>You will be redirected to the homepage in <span id="countdown">10</span> seconds.</p>
        <p>If you have any questions, please <a href="contact.jsp">contact us</a>.</p>
        <a href="UserLanding.jsp" class="button">Return to Home</a>
    </div>
</body>
</html>
