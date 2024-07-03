<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<html>
<head>
    <title>Products</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Products</h1>
    <table>
        <tr>
            <th>Product Name</th>
            <th>Image</th>
            <th>Buy Now Price</th>
        </tr>
        <%
            String category = request.getParameter("category");
            if (category != null && !category.isEmpty()) {
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC", "root", "root");
                    stmt = conn.createStatement();
                    String sql = "SELECT productName, image, buyNowPrice FROM product WHERE productCategory='" + category + "'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String productName = rs.getString("productName");
                        byte[] image = rs.getBytes("image");
                        double buyNowPrice = rs.getDouble("buyNowPrice");
        %>
        <tr>
            <td><a href="viewlistingdesc.jsp?productName=<%= productName %>"><%= productName %></a></td>
            <td>
                <%
                    if (image != null) {
                        String base64Image = java.util.Base64.getEncoder().encodeToString(image);
                %>
                <a href="viewlistingdesc.jsp?productName=<%= productName %>">
                <img src="data:image/jpeg;base64,<%= base64Image %>" width="100" height="100" />
                </a>
                <%
                    }
                %>
            </td>
            <td><%= buyNowPrice %></td>
        </tr>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("Category not specified.");
            }
        %>
    </table>
</body>
</html>
