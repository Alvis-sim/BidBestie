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

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
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
        String priceParam = request.getParameter("price");
        String imageBase64 = request.getParameter("imageBase64");

        if (productIDParam == null || priceParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters.");
            return;
        }

        int productID;
        double price;
        int accountID;

        try {
            productID = Integer.parseInt(productIDParam);
            price = Double.parseDouble(priceParam);
            
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

            // Check if there is an existing cart for the accountID
            String getCartIDSql = "SELECT cartID FROM Cart WHERE accountID = ?";
            statement = con.prepareStatement(getCartIDSql);
            statement.setInt(1, accountID);
            ResultSet rs = statement.executeQuery();

            int cartID;
            if (rs.next()) {
                cartID = rs.getInt("cartID");
            } else {
                // Create a new cart for the accountID if it doesn't exist
                String createCartSql = "INSERT INTO Cart (accountID) VALUES (?)";
                statement = con.prepareStatement(createCartSql, PreparedStatement.RETURN_GENERATED_KEYS);
                statement.setInt(1, accountID);
                statement.executeUpdate();
                rs = statement.getGeneratedKeys();
                if (rs.next()) {
                    cartID = rs.getInt(1);
                } else {
                    throw new SQLException("Failed to create cart.");
                }
            }
            rs.close();
            statement.close();

            // Insert item into cart
            String sql = "INSERT INTO CartItems (cartID, productID, quantity, price, imageBase64) VALUES (?, ?, 1, ?, ?)";
            statement = con.prepareStatement(sql);
            statement.setInt(1, cartID);
            statement.setInt(2, productID);
            statement.setDouble(3, price);
            statement.setString(4, imageBase64);
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                // Redirect to viewlistingdesc.jsp with success message
                response.sendRedirect("viewlistingdesc?productID=" + productID + "&addedToCart=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add product to cart.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the product to the cart.");
        } finally {
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
