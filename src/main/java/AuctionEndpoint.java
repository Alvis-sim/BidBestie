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
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint(value = "/auction/{username}", configurator = AuctionEndpoint.Configurator.class)
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
    public void onOpen(Session session, @PathParam("username") String username) throws IOException, SQLException {
        System.out.println("Connection opened for user: " + username);
        clients.add(session);
        session.getUserProperties().put("username", username);

        HttpSession httpSession = (HttpSession) session.getUserProperties().get("httpSession");
        if (httpSession != null) {
            httpSession.setAttribute("username", username);
        }

        sendAuctionHistory(session);
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

    public void sendAuctionHistory(Session session) throws SQLException, IOException {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT username, bid_amount, timestamp, productID FROM auction_bids ORDER BY timestamp")) {

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String username = resultSet.getString("username");
                BigDecimal bidAmount = resultSet.getBigDecimal("bid_amount");
                Timestamp timestamp = resultSet.getTimestamp("timestamp");
                int productID = resultSet.getInt("productID");
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
}
