import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.auction.AuctionItem;

@WebServlet("/viewlistingdesc")
public class ViewListingDescriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ViewListingDescriptionServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIDParam = request.getParameter("productID");
        if (productIDParam != null && productIDParam.matches("\\d+")) { // Validate productID
            int productID = Integer.parseInt(productIDParam);
            AuctionItem auctionItem = null;

            // Database connection and query
            try (Connection con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");
                 PreparedStatement statement = con.prepareStatement("SELECT productName, buyNowPrice, startingBidPrice, productDescription, currentBid, eDate, Image FROM product WHERE productID = ?")) {
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                statement.setInt(1, productID);
                try (ResultSet rs = statement.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("productID", productID);
                        request.setAttribute("productName", rs.getString("productName"));
                        request.setAttribute("buyNowPrice", rs.getDouble("buyNowPrice"));
                        request.setAttribute("startingBidPrice", rs.getDouble("startingBidPrice"));
                        request.setAttribute("productDescription", rs.getString("productDescription"));
                        request.setAttribute("currentBid", rs.getDouble("currentBid"));
                        request.setAttribute("eDate", rs.getString("eDate"));
                        
                        // Retrieve the image as a byte array
                        byte[] imageData = rs.getBytes("Image");
                        String base64Image = Base64.getEncoder().encodeToString(imageData);
                        request.setAttribute("base64Image", base64Image);

                        auctionItem = new AuctionItem(
                                productID,
                                rs.getString("productName"),
                                rs.getDouble("buyNowPrice"),
                                rs.getDouble("startingBidPrice"),
                                rs.getString("productDescription"),
                                rs.getDouble("currentBid"),
                                rs.getString("eDate"),
                                base64Image
                        );
                    } else {
                        response.sendRedirect("productNotFound.jsp");
                        return;
                    }
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Database error", e);
                response.sendRedirect("error.jsp");
                return;
            }
        } else {
            response.sendRedirect("invalidProduct.jsp");
            return;
        }
        // Forward to JSP page
        request.getRequestDispatcher("viewlistingdesc.jsp").forward(request, response);
    }
}
