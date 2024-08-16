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

@WebServlet("/RemoveAdminServlet")
public class RemoveAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String loggedInAdmin = (String) session.getAttribute("adminUser");

        if (loggedInAdmin == null || !loggedInAdmin.equals("adminj")) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show a message
            return;
        }

        String adminID = request.getParameter("adminID");

        // Prevent deletion of adminID '1'
        if ("1".equals(adminID)) {
            response.sendRedirect("adminViewAdmin.jsp"); // Redirect to an error page or show a message
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

            String sql = "DELETE FROM adminT WHERE adminID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, adminID);
            pst.executeUpdate();

            response.sendRedirect("adminViewAdmin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page if something goes wrong
        }
    }
}
