

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*, java.util.*,p1.dbconnect" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>

<%
    String username = dbconnect.userID;
    String bookname = request.getParameter(",");
    String eq="=";
    String mm = bookname.replace(eq, " ");
    String url = "jdbc:mysql://localhost:3306/bookvault";
    String usernam = "root";
    String password = "tiger";
    Connection conn = null;
    
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    // Database connection and insertion logic
    // Assume you have a connection and prepared statement ready

    try {
    	Class.forName("com.mysql.jdbc.Driver");
    	conn = DriverManager.getConnection(url, usernam, password);
        String query = "INSERT INTO adminreq (uname,bookname) VALUES (?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, mm);
        int i=pstmt.executeUpdate();
        if (i > 0) {
            response.sendRedirect("qty.jsp?success=true"); // Passing parameter indicating success
        } else {
            out.println("<h2>Request unsuccessfully</h2>");
        }   
        pstmt.close();
        conn.close(); 
        pstmt.close();
        conn.close();

        
        
        
    } catch (SQLException e) {
    	out.println("Database connection error: " + e.getMessage());

    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
        
    }
%>

</body>
</html>