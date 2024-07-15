<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
        
        String bookName = request.getParameter("bookName");
        String studentName = request.getParameter("studentName");
        String issueDate = request.getParameter("issueDate");
        String dueDate = request.getParameter("dueDate");
        String payment = request.getParameter("payment");

      
        String url = "jdbc:mysql://localhost:3306/bookvault";
        String username = "root";
        String password = "tiger";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
       
            Class.forName("com.mysql.jdbc.Driver");

           
            conn = DriverManager.getConnection(url, username, password);

            
            String sql = "INSERT INTO stuinfo (bookname, stuname, issuedate, duedate, payment) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, bookName);
            pstmt.setString(2, studentName);
            pstmt.setString(3, issueDate);
            pstmt.setString(4, dueDate);
            pstmt.setString(5, payment);

            
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                
                out.println("Data inserted successfully.");
            } else {
                
                out.println("Failed to insert data.");
            }
        } catch (SQLException e) {
            out.println("Database connection error or SQL error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("MySQL JDBC Driver not found: " + e.getMessage());
        } finally {
           
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>

</body>
</html>