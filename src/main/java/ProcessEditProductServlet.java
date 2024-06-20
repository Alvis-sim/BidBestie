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

/**
 * Servlet implementation class ProcessEditProductServlet
 */
@MultipartConfig(maxFileSize = 16177215) // upload file up to 16MB
@WebServlet("/ProcessEditProductServlet")
public class ProcessEditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Collect form data
        HttpSession session = request.getSession();
        int accountID = (int) session.getAttribute("accountID");
        int productID = Integer.parseInt(request.getParameter("productID"));
        String productName = request.getParameter("name");
        String productCategory = request.getParameter("categories");
        String productDescription = request.getParameter("description");
        String quantity = request.getParameter("quantity");
        String buyNowPrice = request.getParameter("buyitnow");
        String shipping = request.getParameter("shipping");
        Part imagePart = request.getPart("image");

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

            // Verify if the product belongs to the user
            String verifySql = "SELECT accountID FROM product WHERE id = ?";
            PreparedStatement verifyStatement = con.prepareStatement(verifySql);
            verifyStatement.setInt(1, productID);
            ResultSet rs = verifyStatement.executeQuery();
            
            if (rs.next() && rs.getInt("accountID") == accountID) {
                // constructs SQL statement for update
                String sql = "UPDATE product SET productName = ?, productCategory = ?, productDescription = ?, quantity = ?, buyNowPrice = ?, shipping = ?, image = ? WHERE id = ?";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setString(1, productName);
                statement.setString(2, productCategory);
                statement.setString(3, productDescription);
                statement.setString(4, quantity);
                statement.setString(5, buyNowPrice);
                statement.setString(6, shipping);

                if (inputStream != null) {
                    statement.setBlob(7, inputStream);
                } else {
                    statement.setNull(7, java.sql.Types.BLOB);
                }

                statement.setInt(8, productID);

                int row = statement.executeUpdate();
                if (row > 0) {
                    message = "Product updated successfully";
                }
            } else {
                message = "You do not have permission to edit this product.";
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
