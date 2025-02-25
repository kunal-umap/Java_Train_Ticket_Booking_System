<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.*, java.math.*, javax.servlet.http.*, javax.servlet.*, java.util.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cards Page</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
    <header>
        <button class="back-button" onclick="history.back()">
            <i class="fas fa-arrow-left"></i>
        </button>
        <i class="fas fa-train temp-icon"></i>
        <div class="header-title">E Yatra: Train Ticket System</div>
        <i class="fas fa-user-circle profile-icon"></i>
    </header>
 	
    <main id="cardContainer">
        <!-- Cards will be dynamically inserted here -->
        <%
    // Get parameters from the request
		    String startStation = request.getParameter("start_station");
		    String endStation = request.getParameter("end_station");

	    if (startStation != null && endStation != null) {
	        // Database connection details
	        String url = "jdbc:derby:D:\\Users\\2792618\\MyDB;create=true"; // Replace with your database name
	        
	
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;

        try {
            // Load JDBC driver
           	Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        	conn = DriverManager.getConnection(url);

            // SQL query to fetch matching trains
            String sql = "SELECT train_id, train_name, start_at, end_at FROM trains WHERE start_station = ? AND end_station = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, startStation);
            stmt.setString(2, endStation);

            rs = stmt.executeQuery();

            boolean hasResults = false; // Flag to check if any rows are returned

            // Loop through results and display
%>
           
            
<%
            while (rs.next()) {
                hasResults = true; // We have at least one train
%>				<div class="card_box">
                
                <div class="card">
                  <span class="tag">
                    <%= rs.getInt("train_id") %>
                  </span>
                  <div class="card_header">
                    <img src="https://tse3.mm.bing.net/th/id/OIP.K0hNUKtpph8FcAsgqWONtwHaHa?rs=1&pid=ImgDetMain" alt="T" class="train-logo">
                    <p><%= rs.getString("train_name") %></p>
                    <span>3</span>
                  </div>
                  <div class="journey">
                    <div class="from_loc">
                        <p class="place"><%= startStation %></p>
                        <p class="time"><%= rs.getTimestamp("start_at") %></p>
                    </div>
                    <div class="arrow">
                        ->
                    </div>
                    <div class="to_loc">
                        <p class="place"><%= endStation %></p>
                        <p class="time"><%= rs.getTimestamp("end_at") %></p>
                    </div>

                  </div>
                  <div class="btns">
                    <a class="cancelbtn"></a>
                    <a href="../finalTicket/index.html" class="viewbtn">Book Ticket</a>
                  </div>
                </div>
                </div>

<%
            }

            if (!hasResults) { 
                out.println("<h3>No trains found for this route.</h3>");
            }
%>
    
<%
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("<p>Please enter both start and end stations.</p>");
    }
%>
        
        
    </main>

</body>
</html>
