<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/bookvault";
    String username = "root";
    String password = "tiger";

    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        
        String cartId = request.getParameter("cart_id");
        String status = request.getParameter("status");
        
        if (cartId != null && status != null) {
            String query = "UPDATE adminreq SET Status = ? WHERE cart_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, status);
            pstmt.setString(2, cartId);
            pstmt.executeUpdate();
        }
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
    
    // Redirect back to the page where the request originated
    response.sendRedirect(request.getHeader("Referer"));
%>
</body>
</html>