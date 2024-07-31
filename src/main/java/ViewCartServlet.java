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
import java.util.ArrayList;
import java.util.List;
import com.cart.CartItem;

@WebServlet("/ViewCartServlet")
public class ViewCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountIDParam = request.getParameter("accountID");
        int accountID = -1;
        if (accountIDParam != null) {
            try {
                accountID = Integer.parseInt(accountIDParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                forwardWithError(request, response, "Invalid account ID.");
                return;
            }
        }
        
        System.out.print(accountID);

        List<CartItem> cartItems = getCartItems(accountID);

        if (cartItems == null) {
            forwardWithError(request, response, "No cart found for accountID: " + accountID);
            return;
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("viewCart.jsp").forward(request, response);
    }

    private List<CartItem> getCartItems(int accountID) {
        List<CartItem> cartItems = new ArrayList<>();
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC", "root", "root");

            String cartIdSql = "SELECT cartID FROM Cart WHERE accountID = ?";
            statement = con.prepareStatement(cartIdSql);
            statement.setInt(1, accountID);
            rs = statement.executeQuery();

            int cartID = -1;
            if (rs.next()) {
                cartID = rs.getInt("cartID");
            } else {
                return null;
            }

            rs.close();
            statement.close();

            String itemsSql = "SELECT p.productName, ci.price, ci.quantity, ci.imageBase64, ci.cartItemID "
                            + "FROM CartItems ci "
                            + "JOIN product p ON ci.productID = p.productID "
                            + "WHERE ci.cartID = ?";
            statement = con.prepareStatement(itemsSql);
            statement.setInt(1, cartID);
            rs = statement.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductName(rs.getString("productName"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setImageBase64(rs.getString("imageBase64")); 
                item.setcartItemID(rs.getInt("cartItemID"));
                cartItems.add(item);
            }

            return cartItems;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String errorMessage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
    }
}
