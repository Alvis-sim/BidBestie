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

@WebServlet("/DeleteListingServlet")
public class DeleteListingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productID = request.getParameter("productID");

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String adminUser = (String) session.getAttribute("adminUser");
        String loggedInAccountID = (String) session.getAttribute("accountID");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC","root", "root");

            // Check if the logged-in user is either the admin or the creator of the listing
            PreparedStatement pst = con.prepareStatement("SELECT accountID FROM product WHERE productID = ?");
            pst.setInt(1, Integer.parseInt(productID));
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String creatorAccountID = rs.getString("accountID");

                if (adminUser != null) {
                    // User is an admin
                    PreparedStatement deletePst = con.prepareStatement("DELETE FROM product WHERE productID = ?");
                    deletePst.setInt(1, Integer.parseInt(productID));
                    int result = deletePst.executeUpdate();

                    if (result > 0) {
                        request.setAttribute("status", "success");
                    } else {
                        request.setAttribute("status", "failed");
                    }
                    
                    deletePst.close();
                    response.sendRedirect("adminViewListing.jsp"); // Redirect admins to the admin view listings page
                } else if (creatorAccountID.equals(loggedInAccountID)) {
                    // User is the creator of the listing
                    PreparedStatement deletePst = con.prepareStatement("DELETE FROM product WHERE productID = ?");
                    deletePst.setInt(1, Integer.parseInt(productID));
                    int result = deletePst.executeUpdate();

                    if (result > 0) {
                        request.setAttribute("status", "success");
                    } else {
                        request.setAttribute("status", "failed");
                    }

                    deletePst.close();
                    response.sendRedirect("viewlisting.jsp"); // Redirect users to their own listings page
                } else {
                    // User is not authorized to delete the listing
                    request.setAttribute("status", "unauthorized");
                    response.sendRedirect("errorPage.jsp"); // Redirect to an error page or appropriate page
                }
            } else {
                request.setAttribute("status", "notfound");
                response.sendRedirect("errorPage.jsp"); // Redirect to an error page or appropriate page
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "failed");
            response.sendRedirect("errorPage.jsp"); // Redirect to an error page or appropriate page
        }
    }
}
