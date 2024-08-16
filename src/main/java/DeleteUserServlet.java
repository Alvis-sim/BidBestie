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
import java.sql.SQLException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String adminUsername = (String) session.getAttribute("adminUser"); // Assuming admin username is stored in session

        if (adminUsername == null) {
            response.sendRedirect("adminLogin.jsp"); // Redirect to admin login if not logged in as admin
            return;
        }

        String userID = request.getParameter("accountID");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC","root", "root");
            PreparedStatement pst = con.prepareStatement("DELETE FROM users WHERE accountID = ?");
            pst.setString(1, userID);
            
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }

            pst.close();
            con.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
        }

        request.getRequestDispatcher("adminViewUser.jsp").forward(request, response); // Redirect to admin dashboard or appropriate page
    }
}
