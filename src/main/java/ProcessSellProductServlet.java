import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;

/**
 * Servlet implementation class ProcessSellProductServlet
 */
@MultipartConfig(maxFileSize = 16177215) // upload file up to 16MB
public class ProcessSellProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Collect form data
        HttpSession session = request.getSession();
        String accountIDStr = request.getParameter("accountID");
        if (accountIDStr == null || accountIDStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Account ID is missing");
            return;
        }
        
        int accountID = Integer.parseInt(accountIDStr);
        String productName = request.getParameter("name");
        String productCategory = request.getParameter("categories");
        String productDescription = request.getParameter("description");
        String quantity = request.getParameter("quantity");
        String buyNowPrice = request.getParameter("buyitnow");
        String shipping = request.getParameter("shipping");
        Part imagePart = request.getPart("image");

        // Auction fields
        String auctionToggle = request.getParameter("auctionToggle");
        String startingBidPrice = null;
        String sDate = null;
        String eDate = null;

        if (auctionToggle != null && auctionToggle.equals("on")) {
            startingBidPrice = request.getParameter("startingBidPrice");
            sDate = request.getParameter("startdate");
            eDate = request.getParameter("enddate");
        }

        InputStream inputStream = null;
        if (imagePart != null) {
            inputStream = imagePart.getInputStream();
        }

        Connection con = null;
        String message = null;
        int productID = 0;

        try {
            // connects to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

            // constructs SQL statement
            String sql = "INSERT INTO product (accountID, productName, productCategory, productDescription, Quantity, buyNowPrice, sDate, eDate, Shipping, Image, startingBidPrice, currentBid, highestBidderID, auctionStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setInt(1, accountID);
            statement.setString(2, productName);
            statement.setString(3, productCategory);
            statement.setString(4, productDescription);
            statement.setString(5, quantity);
            statement.setString(6, buyNowPrice);
            statement.setString(7, sDate);
            statement.setString(8, eDate);

            statement.setString(9, shipping);

            if (inputStream != null) {
                statement.setBlob(10, inputStream);
            } else {
                statement.setNull(10, java.sql.Types.BLOB);
            }

            if (startingBidPrice != null && !startingBidPrice.isEmpty()) {
                statement.setString(11, startingBidPrice);
            } else {
                statement.setNull(11, java.sql.Types.DECIMAL);
            }

            // Assuming currentBid, highestBidderID, auctionStatus are not part of form submission
            statement.setNull(12, java.sql.Types.DECIMAL); // currentBid
            statement.setNull(13, java.sql.Types.INTEGER); // highestBidderID
            statement.setNull(14, java.sql.Types.VARCHAR); // auctionStatus

            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";

                // Retrieve the generated product ID
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    productID = generatedKeys.getInt(1);

                    // If the listing is for an auction, schedule the finalization
                    if (auctionToggle != null && auctionToggle.equals("on") && eDate != null) {
                        Timestamp endTimestamp = Timestamp.valueOf(eDate.replace("T", " ") + ":00");
                        AuctionScheduler.scheduleAuctionFinalization(productID, new Date(endTimestamp.getTime()));
                    }
                }
            }

        } catch (Exception ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            request.setAttribute("Message", message);
            getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
        }
    }
}
