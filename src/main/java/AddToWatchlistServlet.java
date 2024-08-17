import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/AddToWatchlistServlet")
public class AddToWatchlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Check if the user is logged in
        if (session.getAttribute("accountID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve parameters from request
        String productIDParam = request.getParameter("productID");
        String productName = request.getParameter("productName");

        if (productIDParam == null || productName == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters.");
            return;
        }

        int productID;
        int accountID;

        try {
            productID = Integer.parseInt(productIDParam);
            
            // Parse accountID from session, ensuring it's an Integer
            Object accountIDObject = session.getAttribute("accountID");
            if (accountIDObject instanceof Integer) {
                accountID = (Integer) accountIDObject;
            } else if (accountIDObject instanceof String) {
                accountID = Integer.parseInt((String) accountIDObject);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Invalid accountID type in session.");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format.");
            return;
        }

        Connection con = null;
        PreparedStatement statement = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

            // Insert item into watchlist
            String sql = "INSERT INTO watchlist (accountID, productID, productName) VALUES (?, ?, ?)";
            statement = con.prepareStatement(sql);
            statement.setInt(1, accountID);
            statement.setInt(2, productID);
            statement.setString(3, productName);
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to a success page or the product details page
                response.sendRedirect("viewlistingdesc.jsp?productID=" + productID + "&addedToWatchlist=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add product to watchlist.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the product to the watchlist.");
        } finally {
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
