
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
import java.util.ArrayList;
import java.util.List;

import com.registration.Product;

@WebServlet("/WatchlistServlet")
public class WatchlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int accountID = (int) session.getAttribute("accountID");

        List<Product> watchlist = new ArrayList<>();
        String url = "jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC";
        String user = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "SELECT p.productID, p.productName, p.buyNowPrice, p.image FROM Watchlist w "
                       + "JOIN product p ON w.productID = p.productID WHERE w.accountID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, accountID);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("productID");
                        String name = rs.getString("productName");
                        double price = rs.getDouble("buyNowPrice");
                        String imagePath = rs.getString("image");
                        Product product = new Product(id, name, price, imagePath);
                        watchlist.add(product);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("watchlist", watchlist);
        request.getRequestDispatcher("/watchlist.jsp").forward(request, response);
    }
}
