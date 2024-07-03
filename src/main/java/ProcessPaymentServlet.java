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


public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve payment details from the request
        String cardNumber = request.getParameter("cardNumber");
        String cardName = request.getParameter("cardName");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String billingAddress = request.getParameter("billingAddress");
        String billingZip = request.getParameter("billingZip");

        // Process the payment (this is a placeholder for actual payment processing logic)
        boolean paymentSuccess = processPayment(cardNumber, cardName, expiryDate, cvv, billingAddress, billingZip);

        // Redirect based on payment success
        if (paymentSuccess) {
            response.sendRedirect("paymentSuccess.jsp");
        } else {
            response.sendRedirect("paymentFailure.jsp");
        }
    }

    private boolean processPayment(String cardNumber, String cardName, String expiryDate, String cvv, String billingAddress, String billingZip) {
        // Implement payment processing logic here
        // This is just a placeholder that always returns true
        return true;
    }
}
