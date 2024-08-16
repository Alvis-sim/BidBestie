import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/FinalizeAuctionServlet")
public class FinalizeAuctionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIDStr = request.getParameter("productID");
        if (productIDStr != null) {
            int productID = Integer.parseInt(productIDStr);

            // Create an instance of your AuctionEndpoint or relevant class to finalize the auction
            AuctionEndpoint auctionEndpoint = new AuctionEndpoint();
            String winner = auctionEndpoint.finalizeAuction(productID);

            // Store the winner's username in the session
            HttpSession session = request.getSession();
            session.setAttribute("auctionWinner", winner);

            // Optionally, send a response back to the client
            response.getWriter().write("Auction finalized for product ID: " + productID + ". Winner: " + winner);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing");
        }
    }
}
