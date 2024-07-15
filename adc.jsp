<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,p1.dbconnect" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
String uname = request.getParameter("username");
String pass = request.getParameter("password");
String url = "jdbc:mysql://localhost:3306/bookvault";
String username = "root";
String password = "tiger";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, username, password);
	String sql = "SELECT * FROM adnew WHERE uname = ? AND pass = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, uname);
    pstmt.setString(2, pass);
    rs = pstmt.executeQuery();
    if (rs.next()) {
    	dbconnect.userID=uname;
    	
        response.sendRedirect("adpage.jsp");
    } else {
        out.println("Invalid username ad pass. Please try again.");
    }
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