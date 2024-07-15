<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.io.*, java.util.*,p1.dbconnect" %> 
 <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anurag University Library</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @charset "UTF-8";
        body ,h1{
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #83FF33, #8A2BE2);
            color: black;
        }

        header {
            
            color: #fff;
            padding: 1em;
            text-align: center;
            position: relative;
        }

        
        nav {
            background-color: #444;
            padding: 10px;
            text-align: center;
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

        section {
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        #year-semester-dropdown {
            margin-bottom: 20px;
        }
        #cart-container {
    position: absolute;
    top: 10px;
    right: 10px;
    display: flex;
    align-items: center;
    cursor: pointer;
    color: #fff;
}

#cart-icon {
    font-size: 24px;
    margin-right: 5px;
}

#cart-text {
    color: #fff;
    cursor: pointer;
}
        

        footer {
            background-color: #333;
            color: #fff;
            padding: 1em;
            text-align: center;
        }
         

        table {
            border-collapse: collapse;
            width: 50%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
        #table-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    padding: 10px;
    background-color: #ffffff;
    border-radius: 5px;
}
        
    </style>
</head>
<body>


<header>
    <h1>Anurag University BookVault</h1>
    
</header>

<nav>
    <a href="NewFile.html">Home</a>
    <a href="#">Contact Us</a>
</nav>

<section>
    <div id="year-semester-dropdown">
        <form action="display.jsp" method="post">
            <label for="year-semester">Select Year and Semester:</label>
            <select id="year-semester" name="selectedYearSemester">
                <option>Select your semester</option>
                <option value="1-1">1st Year 1st Semester</option>
                <option value="1-2">1st Year 2nd Semester</option>
                <option value="2-1">2nd Year 1st Semester</option>
                <option value="2-2">2nd Year 2nd Semester</option>
                <option value="3-1">3rd Year 1st Semester</option>
                <option value="3-2">3rd Year 2nd Semester</option>
                <option value="4-1">4th Year 1st Semester</option>
                <option value="4-2">4th Year 2nd Semester</option>
            </select>
            <input type="submit" value="Submit">
        </form>
    </div>
</section>
<%
    
String username = dbconnect.userID;
String url = "jdbc:mysql://localhost:3306/bookvault";
String usernam = "root";
String password = "tiger";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, usernam, password);
    String query = "SELECT cart_id, bookname,Status FROM adminreq WHERE uname = ?";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, username);
    rs = pstmt.executeQuery(); // Use executeQuery() for SELECT statements
%>
<div id="table-container">
<table>
    <tr>
        <th>Cart ID</th>
        <th>Book Name</th>
        <th>Request Status</th>
        
    </tr>
<%
    // Process the result set
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("cart_id") %></td>
        <td><%= rs.getString("bookname") %></td>
        <td><%= rs.getString("Status") %></td>
    </tr>
<%
    }
%>
</table>
</div>
<%
} catch (SQLException e) {
    out.println("Database connection error: " + e.getMessage());
} catch (ClassNotFoundException e) {
    out.println("MySQL JDBC Driver not found: " + e.getMessage());
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
<footer>
    <p>&copy; 2024 Anurag University Library. All rights reserved.</p>
    <p>Contact: library@anuraguniversity.edu</p>
</footer>
<script>
window.onload = function() {
    const params = new URLSearchParams(window.location.search);
    if (params.has('success') && params.get('success') === 'true') {
        // Display success message using alert
        alert("Request to Admin sent successfully!");
    }
};
</script>
</body>
</html>
