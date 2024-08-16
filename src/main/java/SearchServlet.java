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
import java.util.ArrayList;
import java.util.List;

import com.registration.Product;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String category = request.getParameter("category");

        List<Product> products = new ArrayList<>();
        
        // Include productID in the SELECT clause
        String sql = "SELECT productID, productName, buyNowPrice, image FROM product WHERE productName LIKE ?";

        if (category != null && !category.isEmpty()) {
            sql += " AND productCategory = ?";
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + query + "%");
            if (category != null && !category.isEmpty()) {
                stmt.setString(2, category);
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve the productID from the ResultSet
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    double buyNowPrice = rs.getDouble("buyNowPrice");
                    byte[] imageBytes = rs.getBytes("image");
                    String imagePath = imageBytes != null ? "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(imageBytes) : null;
                    products.add(new Product(productID, productName, buyNowPrice, imagePath));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
}
