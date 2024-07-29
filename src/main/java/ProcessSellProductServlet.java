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

/**
 * Servlet implementation class ProcessSell
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
        String duration = null;

        if (auctionToggle != null && auctionToggle.equals("on")) {
            startingBidPrice = request.getParameter("startingBidPrice");
            sDate = request.getParameter("startdate");
            eDate = request.getParameter("enddate");
            duration = request.getParameter("auctionDuration");
        }

        InputStream inputStream = null;
        if (imagePart != null) {
            inputStream = imagePart.getInputStream();
        }

        Connection con = null;
        String message = null;

        try {
            // connects to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC", "root", "root");

            // constructs SQL statement
            String sql = "INSERT INTO product (accountID, productName, productCategory, productDescription, Quantity, buyNowPrice, sDate, eDate, duration, Shipping, Image, startingBidPrice, currentBid, highestBidderID, auctionStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, accountID);
            statement.setString(2, productName);
            statement.setString(3, productCategory);
            statement.setString(4, productDescription);
            statement.setString(5, quantity);
            statement.setString(6, buyNowPrice);
            statement.setString(7, sDate);
            statement.setString(8, eDate);

            if (duration != null && !duration.isEmpty()) {
                statement.setInt(9, Integer.parseInt(duration));
            } else {
                statement.setNull(9, java.sql.Types.INTEGER);
            }

            statement.setString(10, shipping);

            if (inputStream != null) {
                statement.setBlob(11, inputStream);
            } else {
                statement.setNull(11, java.sql.Types.BLOB);
            }

            if (startingBidPrice != null && !startingBidPrice.isEmpty()) {
                statement.setString(12, startingBidPrice);
            } else {
                statement.setNull(12, java.sql.Types.DECIMAL);
            }

            // Assuming currentBid, highestBidderID, auctionStatus are not part of form submission
            statement.setNull(13, java.sql.Types.DECIMAL); // currentBid
            statement.setNull(14, java.sql.Types.INTEGER); // highestBidderID
            statement.setNull(15, java.sql.Types.VARCHAR); // auctionStatus

            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
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
