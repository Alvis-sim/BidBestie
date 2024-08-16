import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AddAdminServlet")
public class AddAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", 
                "root", 
                "root"
            );

            String sql = "INSERT INTO adminT (username, email, password) VALUES (?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);

            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "error");
            }

            pst.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
        }

        request.getRequestDispatcher("addAdmin.jsp").forward(request, response);
    }
}
