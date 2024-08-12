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

@WebServlet("/RemoveCartItemServlet")
public class RemoveCartItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productIDParam = request.getParameter("productID");
        int productID = -1;

        // Validate and parse productID
        if (productIDParam != null && !productIDParam.trim().isEmpty()) {
            try {
                productID = Integer.parseInt(productIDParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
            return;
        }

        Connection con = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

            // Remove the cart item
            String deleteSql = "DELETE FROM CartItems WHERE cartItemID = ?";
            statement = con.prepareStatement(deleteSql);
            statement.setInt(1, productID);
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
            	
                // Redirect to the ViewCartServlet after successful removal
                String accountIDParam = (String) request.getSession().getAttribute("accountID");       
                int accountID = Integer.parseInt(accountIDParam);
                updateItemCount(session, accountID, con);
                response.sendRedirect("ViewCartServlet?accountID=" + accountID);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Item not found in cart");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request");
        } finally {
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        private void updateItemCount(HttpSession session, int accountID, Connection con) throws SQLException {
            PreparedStatement statement = null;
            ResultSet rs = null;
            try {
                String countItemsSql = "SELECT COUNT(*) AS itemCount FROM CartItems WHERE cartID = (SELECT cartID FROM Cart WHERE accountID = ?)";
                statement = con.prepareStatement(countItemsSql);
                statement.setInt(1, accountID);
                rs = statement.executeQuery();

                int itemCount = 0;
                if (rs.next()) {
                    itemCount = rs.getInt("itemCount");
                }

                session.setAttribute("itemCount", itemCount);
            } finally {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
            }
    }
}
