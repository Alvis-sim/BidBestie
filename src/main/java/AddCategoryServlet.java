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

@WebServlet("/addCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

            // Check if the category already exists
            String checkQuery = "SELECT COUNT(*) FROM categories WHERE categoryName = ?";
            pst = con.prepareStatement(checkQuery);
            pst.setString(1, categoryName);
            rs = pst.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                // Category already exists
                response.sendRedirect("manageCategories.jsp?error=Category already exists");
                return;
            }

            // Insert new category
            String insertQuery = "INSERT INTO categories (categoryName) VALUES (?)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, categoryName);
            pst.executeUpdate();

            response.sendRedirect("manageCategories.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}