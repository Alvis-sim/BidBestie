<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin | View Listings</title>
  <link rel="stylesheet" href="css/adminViewListing.css">
</head>
<body>
<div class="header">
    <a href="adminDashboard.jsp" class="back-link">Back to Admin Dashboard</a>
</div>

<div class="content">
  <h2>Listing Management</h2>

  <!-- Search Bar -->
  <div class="search-bar">
    <label for="listing">Listings</label>
    <form method="get" action="adminViewListing.jsp">
      <input type="text" name="searchQuery" id="productID" placeholder="Enter product name or ID" required>
      <button type="submit">Search</button>
    </form>
  </div>

  <!-- Dynamic Table Container -->
  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th><input type="checkbox" onclick="selectAll(this)"></th>
          <th>Product ID</th>
          <th>Name</th>
          <th>Category</th>
          <th>Operation</th>
        </tr>
      </thead>
      <tbody id="userTableBody">
      <%
        String searchQuery = request.getParameter("searchQuery");
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        int totalListings = 0;

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");

          String sql = "SELECT productID, productName, productCategory FROM product";
          if (searchQuery != null && !searchQuery.trim().isEmpty()) {
              sql += " WHERE productName LIKE ? OR productID LIKE ?";
          }

          pst = con.prepareStatement(sql);
          if (searchQuery != null && !searchQuery.trim().isEmpty()) {
              pst.setString(1, "%" + searchQuery + "%");
              pst.setString(2, "%" + searchQuery + "%");
          }

          rs = pst.executeQuery();

          while (rs.next()) {
              totalListings++;
              String productID = rs.getString("productID");
              String productName = rs.getString("productName");
              String productCategory = rs.getString("productCategory");

              out.println("<tr>");
              out.println("<td><input type='checkbox'></td>");
              out.println("<td>" + productID + "</td>");
              out.println("<td>" + productName + "</td>");
              out.println("<td>" + productCategory + "</td>");
              out.println("<td>");
              out.println("<a href='adminViewListingDescServlet?productID=" + productID + "'>Detail</a>");
              out.println("<form action='DeleteListingServlet' method='post' style='display:inline;'>");
              out.println("<input type='hidden' name='productID' value='" + productID + "'>");
              out.println("<button type='submit'>Suspend</button>");
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

  <!-- Suspend popup -->
  <div class="modal" id="suspendConfirmModal">
    <div class="modal-content">
      <p>Are you sure you want to suspend this account?</p>
      <div class="modal-actions">
        <button class="btn" id="confirmSuspend">Yes</button>
        <button class="btn" id="cancelSuspend">Cancel</button>
      </div>
    </div>
  </div>

  <!-- Enter Suspend reason popup -->
  <div class="modal" id="reasonModal">
    <div class="modal-content">
      <p>Please enter reason for the suspension:</p>
      <textarea id="suspendReason" rows="4" cols="50"></textarea>
      <div class="modal-actions">
        <button class="btn" id="submitReason">Submit</button>
      </div>
    </div>
  </div>

  <!-- Suspend Successful popup -->
  <div class="modal" id="suspendSuccessModal">
    <div class="modal-content">
      <p>Account has been suspended!</p>
      <div class="modal-actions">
        <button class="btn" id="closeSuccess">OK</button>
      </div>
    </div>
  </div>

  <div class="pagination">
    <div class="pagination-info">
      Total <span id="totalUsers"><%= totalListings %></span> Listings
    </div>
    <div class="pagination-controls">
      <button onclick="prevPage()">&#9664; Prev</button>
      <input type="text" id="currentPage" value="1" readonly>
      <button onclick="nextPage()">Next &#9654;</button>
      <div class="go-to-page">
        Go To Page <input type="number" id="goToPageInput" min="1" value="1">
        <button onclick="goToPage()">Go</button>
      </div>
    </div>
  </div>
</div>

<script src="HomePage_admin.js"></script>
</body>
</html>
