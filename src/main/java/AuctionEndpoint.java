import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import jakarta.servlet.http.HttpSession;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import jakarta.servlet.ServletContext;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;

@ServerEndpoint(value = "/auction/{productID}/{username}", configurator = AuctionEndpoint.Configurator.class)
public class AuctionEndpoint {

    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static final String DB_URL = "jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    public static class Configurator extends ServerEndpointConfig.Configurator {
        @Override
        public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, jakarta.websocket.HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            sec.getUserProperties().put("httpSession", httpSession);
        }
    }

    @OnOpen
    public void onOpen(Session session, @PathParam("productID") int productID, @PathParam("username") String username) throws IOException, SQLException {
        System.out.println("Connection opened for user: " + username + " on product: " + productID);
        clients.add(session);
        session.getUserProperties().put("username", username);
        session.getUserProperties().put("productID", productID);

        HttpSession httpSession = (HttpSession) session.getUserProperties().get("httpSession");
        if (httpSession != null) {
            httpSession.setAttribute("username", username);
            
            // Optional: store productID in HttpSession as a fallback
            httpSession.setAttribute("productID", String.valueOf(productID));
            
            sendAuctionHistory(session, productID);
        } else {
            session.getBasicRemote().sendText("HttpSession is not available, cannot retrieve auction history.");
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("Connection closed for user: " + session.getUserProperties().get("username"));
        clients.remove(session);
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException, SQLException {
        String username = (String) session.getUserProperties().get("username");
        System.out.println("Received message from user: " + username + " - " + message);
        if (username == null) {
            throw new RuntimeException("Username is not set in session properties");
        }

        // Expecting message format: {"bidAmount": "100.00", "productID": "123"}
        String[] parts = message.replace("\"", "").replace("{", "").replace("}", "").split(",");
        String bidAmountStr = parts[0].split(":")[1].trim();
        String productIDStr = parts[1].split(":")[1].trim();

        BigDecimal bidAmount;
        int productID;
        try {
            bidAmount = new BigDecimal(bidAmountStr);
            productID = Integer.parseInt(productIDStr);
        } catch (NumberFormatException e) {
            session.getBasicRemote().sendText("Invalid bid data");
            return;
        }

        // Save the productID to session properties to use in the onOpen method
        session.getUserProperties().put("productID", String.valueOf(productID));

        saveBidToDatabase(username, bidAmount, productID);

        // Broadcast bid to all clients
        synchronized (clients) {
            for (Session client : clients) {
                if (client.isOpen()) {
                    client.getBasicRemote().sendText(username + " bid $" + bidAmount + " on product " + productID);
                }
            }
        }
    }

    public void sendAuctionHistory(Session session, int productID) throws SQLException, IOException {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT username, bid_amount, timestamp, productID FROM auction_bids WHERE productID = ? ORDER BY timestamp")) {

            statement.setInt(1, productID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                String username = resultSet.getString("username");
                BigDecimal bidAmount = resultSet.getBigDecimal("bid_amount");
                Timestamp timestamp = resultSet.getTimestamp("timestamp");
                String timeAgo = formatTimestamp(timestamp);
                session.getBasicRemote().sendText("[" + timeAgo + "] " + username + " bid $" + bidAmount + " on product " + productID);
            }
        }
    }

    public void saveBidToDatabase(String username, BigDecimal bidAmount, int productID) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("INSERT INTO auction_bids (username, bid_amount, timestamp, productID) VALUES (?, ?, ?, ?)")) {

            statement.setString(1, username);
            statement.setBigDecimal(2, bidAmount);
            statement.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            statement.setInt(4, productID);
            statement.executeUpdate();
            System.out.println("Bid saved to database: " + username + " - " + bidAmount + " on product " + productID);
        } catch (SQLException e) {
            System.err.println("Error saving bid to database: " + e.getMessage());
        }
    }

    public String finalizeAuction(int productID) {
        String winner = null;
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement checkStatusStmt = connection.prepareStatement(
                 "SELECT status FROM product WHERE productID = ?");
             PreparedStatement statement = connection.prepareStatement(
                 "SELECT username, bid_amount FROM auction_bids WHERE productID = ? ORDER BY bid_amount DESC LIMIT 1")) {

            // Check if the auction has already been finalized
            checkStatusStmt.setInt(1, productID);
            ResultSet statusResultSet = checkStatusStmt.executeQuery();
            if (statusResultSet.next()) {
                String status = statusResultSet.getString("status");
                if ("Sold".equalsIgnoreCase(status)) {
                    System.out.println("Auction already finalized for product: " + productID);
                    return null; // Exit early to prevent double charging
                }
            }

            // Proceed with auction finalization if not already finalized
            statement.setInt(1, productID);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                winner = resultSet.getString("username");
                BigDecimal winningBid = resultSet.getBigDecimal("bid_amount");

                // Charge the winner using Stripe
                chargeWinner(winner, winningBid);

                // Notify the winner (optional)
                notifyWinner(winner, productID, winningBid);

                // Update the product status to sold
                updateProductStatus(productID, "Sold");

                System.out.println("Auction finalized. Winner: " + winner + ", Bid: " + winningBid);
            }
        } catch (SQLException e) {
            System.err.println("Error finalizing auction: " + e.getMessage());
        }

        return winner;
    }
    public void chargeWinner(String username, BigDecimal amount) {
        // Retrieve the Stripe token associated with the user (you should store this during the bidding process)
        String stripeToken = getStripeTokenForUser(username);

        // Use Stripe's API to charge the user
        if (stripeToken != null) {
            try {
                // Set your secret key. Remember to replace this with your actual key.
                Stripe.apiKey = "sk_test_51PYQCORpr2L9wI5uzqOTYCHr2wFE1Cvdjj8457Bov2JZmIzm2telIyYeM3l6z8gablhFQusLgUpESZK0ob1n2Rdg00h9om4eGh";

                // Prepare the parameters for the charge
                Map<String, Object> chargeParams = new HashMap<>();
                chargeParams.put("amount", amount.multiply(new BigDecimal(100)).intValueExact()); // Convert to cents
                chargeParams.put("currency", "usd"); // Replace "usd" with your actual currency if needed
                chargeParams.put("source", stripeToken);
                chargeParams.put("description", "Payment for winning auction by " + username);

                // Create the charge using the Stripe API
                Charge charge = Charge.create(chargeParams);

                // Log the successful payment
                System.out.println("Payment successful for user: " + username + ", Charge ID: " + charge.getId());

            } catch (StripeException e) {
                // Handle Stripe API errors
                System.err.println("Error charging user: " + e.getMessage());
            }
        } else {
            // Log the case where no Stripe token is found for the user
            System.err.println("Stripe token not found for user: " + username);
        }
    }


    public void updateProductStatus(int productID, String status) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(
                 "UPDATE product SET status = ? WHERE productID = ?")) {
             
            statement.setString(1, status);
            statement.setInt(2, productID);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating product status: " + e.getMessage());
        }
    }

    public void notifyWinner(String username, int productID, BigDecimal winningBid) {
        // Implement notification logic, such as sending an email
        System.out.println("Notifying winner: " + username + " for product " + productID + " with bid " + winningBid);
    }

    public String formatTimestamp(Timestamp timestamp) {
        LocalDateTime bidTime = timestamp.toLocalDateTime();
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(bidTime, now);

        long seconds = duration.getSeconds();
        if (seconds < 60) {
            return seconds + " seconds ago";
        }
        long minutes = seconds / 60;
        if (minutes < 60) {
            return minutes + " minutes ago";
        }
        long hours = minutes / 60;
        if (hours < 24) {
            return hours + " hours ago";
        }
        long days = hours / 24;
        if (days < 30) {
            return days + " days ago";
        }
        long months = days / 30;
        if (months < 12) {
            return months + " months ago";
        }
        long years = months / 12;
        return years + " years ago";
    }

    private String getStripeTokenForUser(String username) {
        String stripeToken = null;

        String sql = "SELECT stripe_token FROM users WHERE username = ?";
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                stripeToken = resultSet.getString("stripe_token");
            } else {
                System.err.println("No Stripe token found for user: " + username);
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving Stripe token for user " + username + ": " + e.getMessage());
            e.printStackTrace();
        }

        return stripeToken;
    }
 }
