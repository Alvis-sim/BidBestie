import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import com.stripe.param.ChargeCreateParams;

@WebServlet("/processPayment")
public class ProcessPaymentServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        Stripe.apiKey = "sk_test_51PYQCORpr2L9wI5uzqOTYCHr2wFE1Cvdjj8457Bov2JZmIzm2telIyYeM3l6z8gablhFQusLgUpESZK0ob1n2Rdg00h9om4eGh"; // Replace with your Stripe secret key
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("stripeToken");
        String totalAmountString = request.getParameter("totalAmount");
        String bidAmountString = request.getParameter("bidAmount"); // This can be null during checkout

        // Logging the received values for debugging
        System.out.println("Received Stripe token: " + token);
        System.out.println("Received total amount: " + totalAmountString);
        System.out.println("Received bid amount: " + (bidAmountString != null ? bidAmountString : "null"));

        // Null and empty check for Stripe token
        if (token == null || token.trim().isEmpty()) {
            System.out.println("No token received.");
            response.sendRedirect("paymentFailure.jsp");
            return;
        }

        long totalAmount = 0;
        double bidAmount = 0;

        try {
            // Parse total amount, which is mandatory
            if (totalAmountString != null && !totalAmountString.trim().isEmpty()) {
                totalAmount = Long.parseLong(totalAmountString.trim());
            } else {
                System.out.println("Total amount is missing or invalid.");
                response.sendRedirect("paymentFailure.jsp");
                return;
            }

            // Parse bid amount, only if provided (for bidding scenarios)
            if (bidAmountString != null && !bidAmountString.trim().isEmpty()) {
                bidAmount = Double.parseDouble(bidAmountString.trim());
            } else {
                // Optional: Log a message that bid amount is null during checkout
                System.out.println("Bid amount is not provided. This is expected during checkout.");
            }
        } catch (NumberFormatException e) {
            System.out.println("Error parsing amounts: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("paymentFailure.jsp");
            return;
        }

        // Stripe charge creation
        ChargeCreateParams params = ChargeCreateParams.builder()
            .setAmount(totalAmount)
            .setCurrency("sgd")
            .setDescription("BidBestie purchase")
            .setSource(token)
            .build();

        try {
            Charge charge = Charge.create(params);
            System.out.println("Charge successful: " + charge.getId());
            // You can store the bid amount and other necessary information in the database here
            response.sendRedirect("paymentSuccess.jsp");
        } catch (StripeException e) {
            System.out.println("Stripe error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("paymentFailure.jsp");
        }
    }
}
