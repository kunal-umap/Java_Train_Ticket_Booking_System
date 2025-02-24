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
	        String url = "jdbc:derby:C:\\Users\\Dell\\MyDB;create=true"; // Replace with your database name
	        
	
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
            <h2>Available Trains from <%= startStation %> to <%= endStation %>:</h2>
            <table border="1">
                <tr>
                    <th>Train ID</th>
                    <th>Train Name</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                </tr>
<%
            while (rs.next()) {
                hasResults = true; // We have at least one train
%>
                <tr>
                    <td><%= rs.getInt("train_id") %></td>
                    <td><%= rs.getString("train_name") %></td>
                    <td><%= rs.getTimestamp("start_at") %></td>
                    <td><%= rs.getTimestamp("end_at") %></td>
                </tr>
<%
            }

            if (!hasResults) { 
                out.println("<h3>No trains found for this route.</h3>");
            }
%>
            </table>
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const cardContainer = document.getElementById('cardContainer');
            const trainNames = ["Rajdhani Express", "Shatabdi Express", "Duronto Express", "Garib Rath", "Jan Shatabdi", "Sampark Kranti", "Humsafar Express", "Tejas Express", "Vande Bharat"];
            for (let i = 0; i < 9; i++) {
                const card = document.createElement('div');
                card.classList.add('card');

                const cardContent = document.createElement('div');
                cardContent.classList.add("card-content");

                const title = document.createElement('div');
                title.classList.add('card-title');
                title.textContent = trainNames[i];

                const trainNumber = document.createElement('div');
                trainNumber.classList.add('card-details');
                trainNumber.textContent = 'Train No: ' + Math.floor(100000 + Math.random() * 900000);

                const departureTime = document.createElement('div');
                departureTime.classList.add('card-details');
                departureTime.textContent = 'Departure: ' + getRandomTime();

                const arrivalTime = document.createElement('div');
                arrivalTime.classList.add('card-details');
                arrivalTime.textContent = 'Arrival: ' + getRandomTime();

                const bookButton = document.createElement('button');
                bookButton.textContent = 'Book Ticket';
                bookButton.classList.add('book-ticket-button');

                // Add click event
                bookButton.addEventListener('click', function () {
                	window.location.href = '../bookedTickets/tickets.html';
                    alert('Ticket booked successfully!');
                    // You can replace this with your actual booking logic
                });

 
                cardContent.appendChild(title);
                cardContent.appendChild(trainNumber);
                cardContent.appendChild(departureTime);
                cardContent.appendChild(arrivalTime);
                card.appendChild(cardContent);
                card.appendChild(bookButton);
                cardContainer.appendChild(card);
            }
        });

        function getRandomTime() {
            const hours = Math.floor(Math.random() * 24).toString().padStart(2, '0');
            const minutes = Math.floor(Math.random() * 60).toString().padStart(2, '0');
            return `${hours}:${minutes}`;
        }
    </script>
</body>
</html>
