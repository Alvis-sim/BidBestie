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
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC";
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
        System.out.println("Received bid from user: " + username + " - " + message);
        if (username == null) {
            throw new RuntimeException("Username is not set in session properties");
        }
        
        BigDecimal bidAmount;
        try {
            bidAmount = new BigDecimal(message);
        } catch (NumberFormatException e) {
            session.getBasicRemote().sendText("Invalid bid amount");
            return;
        }
        
        saveBidToDatabase(username, bidAmount);
        synchronized (clients) {
            for (Session client : clients) {
                if (client.isOpen()) {
                    System.out.println("Sending bid to client: " + client.getUserProperties().get("username"));
                    client.getBasicRemote().sendText(username + " bid: $" + bidAmount);
                }
            }
        }
    }

    private void sendAuctionHistory(Session session) throws SQLException, IOException {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT username, bid_amount, timestamp FROM auction_bids ORDER BY timestamp")) {

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String username = resultSet.getString("username");
                BigDecimal bidAmount = resultSet.getBigDecimal("bid_amount");
                Timestamp timestamp = resultSet.getTimestamp("timestamp");
                System.out.println("Retrieved timestamp: " + timestamp); // Debugging output
                String timeAgo = formatTimestamp(timestamp);
                session.getBasicRemote().sendText("[" + timeAgo + "] " + username + " bid: $" + bidAmount);
            }
        }
    }

    private void saveBidToDatabase(String username, BigDecimal bidAmount) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("INSERT INTO auction_bids (username, bid_amount, timestamp) VALUES (?, ?, ?)")) {

            statement.setString(1, username);
            statement.setBigDecimal(2, bidAmount);
            statement.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            statement.executeUpdate();
            System.out.println("Bid saved to database: " + username + " - " + bidAmount);
        } catch (SQLException e) {
            System.err.println("Error saving bid to database: " + e.getMessage());
        }
    }

    private String formatTimestamp(Timestamp timestamp) {
        LocalDateTime bidTime = timestamp.toLocalDateTime();
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(bidTime, now);

        long seconds = duration.getSeconds();
        if (seconds < 0) {
            return "just now"; // Handle negative values
        }
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
