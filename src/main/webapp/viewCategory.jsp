<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>Electronics Products</title>
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
    <h1>Electronics Products</h1>
    <table>
        <tr>
            <th>Product Name</th>
            <th>Image</th>
            <th>Buy Now Price</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
            	Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC","root", "root");
                stmt = conn.createStatement();
                String sql = "SELECT productName, image, buyNowPrice FROM product WHERE productCategory='electronics'";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String productName = rs.getString("productName");
                    byte[] image = rs.getBytes("image");
                    double buyNowPrice = rs.getDouble("buyNowPrice");
        %>
        <tr>
            <td><%= productName %></td>
            <td>
                <%
                    if (image != null) {
                        String base64Image = java.util.Base64.getEncoder().encodeToString(image);
                %>
                <img src="data:image/jpeg;base64,<%= base64Image %>" width="100" height="100" />
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
        %>
    </table>
</body>
</html>
