<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Requests</title>
    <style>
        body {
            background: linear-gradient(to right, #83FF33, #8A2BE2); 
        }
        table {
            margin: 0 auto; 
            background-color: white; 
        }
        .accept-btn {
    background-color: #28a745; /* Green */
    color: white;
}

.reject-btn {
    background-color: #dc3545; /* Red */
    color: white;
}
nav {
            background-color: #444;
            padding: 10px;
            text-align: right;
        }

        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #4CAF50;
        }
        
    </style>
</head>
<nav>
    <a href="NewFile.html">Home</a>
</nav>
<body>
    <h1 style="text-align: center;">Admin Requests</h1>
<table border="1">
    <thead>
        <tr>
            <th>Cart ID</th>
            <th>Book Name</th>
            <th>User Name</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <% 
        String url = "jdbc:mysql://localhost:3306/bookvault";
        String username = "root";
        String password = "tiger";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            
            String query = "SELECT cart_id, bookname, uname FROM adminreq";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                String cartId = rs.getString("cart_id");
                String bookname = rs.getString("bookname");
                String uname = rs.getString("uname");
        %>
        <tr>
            <td><%= cartId %></td>
            <td><%= bookname %></td>
            <td><%= uname %></td>
            <td>
                <form action="upstat.jsp" method="post">
                    <input type="hidden" name="cart_id" value="<%= cartId %>">
                    <input type="submit" name="status" value="Accept">
                    <input type="submit" name="status" value="Reject">
                </form>
            </td>
        </tr>
        <% 
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("Error closing resources: " + e.getMessage());
            }
        }
        %>
    </tbody>
</table>
    
</body>
</html>
