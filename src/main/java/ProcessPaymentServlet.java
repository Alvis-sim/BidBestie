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
        String bidAmountString = request.getParameter("bidAmount");

        System.out.println("Received Stripe token: " + token);
        System.out.println("Received total amount: " + totalAmountString);
        System.out.println("Received bid amount: " + bidAmountString);

        if (token == null || token.isEmpty()) {
            System.out.println("No token received.");
            response.sendRedirect("paymentFailure.jsp");
            return;
        }

        long totalAmount = 0;
        double bidAmount = 0;
        try {
            totalAmount = Long.parseLong(totalAmountString); // Convert to long
            bidAmount = Double.parseDouble(bidAmountString); // Convert to double
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("paymentFailure.jsp");
            return;
        }

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
            e.printStackTrace();
            response.sendRedirect("paymentFailure.jsp");
        }
    }
}
