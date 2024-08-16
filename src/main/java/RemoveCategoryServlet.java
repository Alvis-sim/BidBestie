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

@WebServlet("/RemoveCategoryServlet")
public class RemoveCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");
        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

            // Delete the category
            String deleteQuery = "DELETE FROM categories WHERE categoryId = ?";
            pst = con.prepareStatement(deleteQuery);
            pst.setString(1, categoryId);
            pst.executeUpdate();

            response.sendRedirect("manageCategories.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
