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
    <script>
        function startTimer(endDate, elementId) {
            var countDownDate = new Date(endDate).getTime();

            var x = setInterval(function() {
                var now = new Date().getTime();
                var distance = countDownDate - now;

                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                document.getElementById(elementId).innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById(elementId).innerHTML = "EXPIRED";
                }
            }, 1000);
        }
    </script>
</head>
<body>
    <h1>Products</h1>
    <table>
        <tr>
            <th>Product Name</th>
            <th>Image</th>
            <th>Buy Now Price</th>
            <th>Ends In</th>
        </tr>
        <%
            String category = request.getParameter("category");
            if (category != null && !category.isEmpty()) {
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://database-2.cvyg86uued8z.ap-southeast-1.rds.amazonaws.com:3306/bidbestie?enabledTLSProtocols=TLSv1.2&serverTimezone=UTC", "root", "root");
                    stmt = conn.createStatement();
                    String sql = "SELECT productName, image, buyNowPrice, eDate FROM product WHERE productCategory='" + category + "'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String productName = rs.getString("productName");
                        byte[] image = rs.getBytes("image");
                        double buyNowPrice = rs.getDouble("buyNowPrice");
                        String eDate = rs.getString("eDate");
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
            <td>
                <span id="timer-<%= productName %>"></span>
                <script>
                    startTimer("<%= eDate %>", "timer-<%= productName %>");
                </script>
            </td>
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

