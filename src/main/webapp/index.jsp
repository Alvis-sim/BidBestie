<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Auction Bidding System</title>
    <script type="text/javascript">
        var ws;
        var username;

        function connect() {
            username = prompt("Enter your username:");
            if (!username) {
                alert("Username is required to join the auction.");
                return;
            }
            ws = new WebSocket("ws://" + document.location.host + "<%= request.getContextPath() %>/auction/" + encodeURIComponent(username));
            ws.onmessage = function(event) {
                var log = document.getElementById("bidLog");
                log.innerHTML += event.data + "<br>";
            };
            ws.onclose = function() {
                console.log("WebSocket connection closed");
            };
        }

        function placeBid() {
            var bidAmount = document.getElementById("bidAmount").value;
            ws.send(bidAmount);
            document.getElementById("bidAmount").value = '';
        }

        window.onload = connect;
    </script>
</head>
<body>
    <h1>Auction Bidding System</h1>
    <div id="bidLog" style="border:1px solid black; height:300px; overflow:auto;"></div>
    <input type="text" id="bidAmount" placeholder="Enter your bid amount" />
    <button onclick="placeBid()">Place Bid</button>
</body>
</html>
