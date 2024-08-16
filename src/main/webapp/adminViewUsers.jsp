<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Account Management</title>
  <link rel="stylesheet" href="css/adminViewUsers.css">
  <script type="text/javascript">
    function confirmDeletion() {
        return confirm("Are you sure you want to delete this user? This action cannot be undone.");
    }
  </script>
</head>
<body>
<div class="back-to-dashboard">
  <a href="adminDashboard.jsp" class="btn">Back to Admin Dashboard</a>
</div>


<div class="content">
  <h2>Account Management</h2>
  <div class="search-bar">
    <label for="searchQuery">Search</label>
    <input type="text" id="searchQuery" name="searchQuery" placeholder="Enter accountID, first name, or last name">
    <button type="submit" id="searchBtn">Search</button>
  </div>
  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th><input type="checkbox" onclick="selectAll(this)"></th>
          <th>Index</th>
          <th>Account ID</th>
          <th>Username</th>
          <th>Email</th>
          <th>Mobile Phone</th>
          <th>Operation</th>
        </tr>
      </thead>
      <tbody id="userTableBody">
      <% 
        String searchQuery = request.getParameter("searchQuery");
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        int index = 1;

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

          // Construct SQL query with dynamic search conditions
          String sql = "SELECT accountID, username, email, mobile FROM users WHERE 1=1";
          if (searchQuery != null && !searchQuery.trim().isEmpty()) {
              sql += " AND (accountID LIKE ? OR firstName LIKE ? OR lastName LIKE ?)";
          }

          pst = con.prepareStatement(sql);
          if (searchQuery != null && !searchQuery.trim().isEmpty()) {
              String searchParam = "%" + searchQuery + "%";
              pst.setString(1, searchParam);
              pst.setString(2, searchParam);
              pst.setString(3, searchParam);
          }

          rs = pst.executeQuery();

          while (rs.next()) {
              String accountID = rs.getString("accountID");
              String username = rs.getString("username");
              String email = rs.getString("email");
              String mobilePhone = rs.getString("mobile");

              out.println("<tr>");
              out.println("<td><input type='checkbox'></td>");
              out.println("<td>" + (index++) + "</td>");
              out.println("<td>" + accountID + "</td>");
              out.println("<td>" + username + "</td>");
              out.println("<td>" + email + "</td>");
              out.println("<td>" + mobilePhone + "</td>");
              out.println("<td>");
              out.println("<form method='POST' action='DeleteUserServlet' onsubmit='return confirmDeletion();'>");
              out.println("<input type='hidden' name='accountID' value='" + accountID + "'>");
              out.println("<button type='submit' class='suspend-button'>Suspend</button>");
              out.println("</form>");
              out.println("</td>");
              out.println("</tr>");
          }
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
          if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
          if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
      %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
