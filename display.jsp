

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="ds.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <meta charset="UTF-8">
    <title>Book Details</title>
    <style>
        /* Add your CSS styles here */
        #cart-section {
            display: display;
        }
    </style>
</head>
<body>
<header>
    <h1 align="center" style="font-size: 39px;">Anurag University BookVault</h1>
    <div id="cart-container" onclick="toggleCartDetails()">
        
        <span id="cart-text"></span>
    </div>
</header>

<div id="book-details">
    <h2>Book Details</h2>
    <table>
        <thead>
            <tr>
                <th>Book Name</th>
                <th>Author</th>
                <th>Availability</th>
                <th>Add to Cart</th>
            </tr>
        </thead>
        <tbody id="book-list">
            <% 
                String selectedYearSemester = request.getParameter("selectedYearSemester");
                if (selectedYearSemester != null) {
                    String url = "jdbc:mysql://localhost:3306/bookvault";
                    String username = "root";
                    String password = "tiger";

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(url, username, password);
                        String query = "SELECT bookname, author, availability FROM books WHERE year = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, selectedYearSemester);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
            %>
                            <tr>
                                <td><%= rs.getString("bookname") %></td>
                                <td><%= rs.getString("author") %></td>
                                <td><%= rs.getString("availability") %></td>
                                <td><button onclick="addToCart('<%= rs.getString("bookname") %>')">Add to Cart</button></td>
                            </tr>
            <% 
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<tr><td colspan='4'>Error retrieving books: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='4'>Error closing resources: " + e.getMessage() + "</td></tr>");
                        }
                    }
                } else {
                    out.println("<tr><td colspan='4'>Please select a semester</td></tr>");
                }
            %>
        </tbody>
    </table>
</div>

<div id="cart-section">
    <h2>Cart</h2>
    <ul id="cart-items"></ul>
    <div id="redirect-button">
    <br>
        <center>
            <button onclick="redirectToAdReqPage()">Proceed to next</button>
        </center>
    </div>
</div>

<script>
    function toggleCartDetails() {
        var cartSection = document.getElementById("cart-section");
        if (cartSection.style.display === "none") {
            cartSection.style.display = "block";
        } else {
            cartSection.style.display = "none";
        }
    }

    function addToCart(bookName) {
        var cartItems = document.getElementById("cart-items");
        var listItem = document.createElement("li");
        

        var bookTextNode = document.createTextNode(bookName); // Create a text node for the book name
        listItem.appendChild(bookTextNode); // Append the text node to the list item

        var removeButton = document.createElement("button");
        removeButton.textContent = "  Remove";
        removeButton.onclick = function() {
            listItem.remove();
        };
        
        // Append the remove button after the book name
        listItem.appendChild(removeButton);

        cartItems.appendChild(listItem);
        

    }



    function redirectToAdReqPage() {
        var cartItems = document.getElementById("cart-items").getElementsByTagName("li");
        var bookNames = [];

        // Retrieve book names from cart items
        for (var i = 0; i < cartItems.length; i++) {
            var bookName = cartItems[i].textContent.trim();
            bookNames.push(bookName);
        }

        // Redirect to adreq.jsp with book names as parameters
        // Redirect to adreq.jsp with book names as parameters
		var url = 'adreq.jsp?';
		for (var j = 0; j < bookNames.length; j++) {
		    if (j > 0) {
		        url += '';
		    }
		    // Remove last 7 characters from book name
		    var trimmedBookName = bookNames[j].slice(0, -6);
		    url = url+ ',=' + encodeURIComponent(trimmedBookName);
		}

            
        window.location.href = url;
    }
</script>


</body>
</html>
