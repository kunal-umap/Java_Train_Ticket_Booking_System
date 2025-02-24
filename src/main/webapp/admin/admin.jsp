<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
    String message = "";
    String color = "";
    String dbURL = "jdbc:derby:C:\\Users\\Dell\\MyDB;create=true";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        conn = DriverManager.getConnection(dbURL);

        if (request.getMethod().equalsIgnoreCase("POST")) {
            String trainName = request.getParameter("trainName");
            String startStation = request.getParameter("startStation");
            String endStation = request.getParameter("endStation");
            String startAt = request.getParameter("startAt");
            String endAt = request.getParameter("endAt");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Timestamp startTime = new Timestamp(sdf.parse(startAt).getTime());
            Timestamp endTime = new Timestamp(sdf.parse(endAt).getTime());

            String sql = "INSERT INTO trains (train_name, start_station, end_station, start_at, end_at) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, trainName);
            stmt.setString(2, startStation);
            stmt.setString(3, endStation);
            stmt.setTimestamp(4, startTime);
            stmt.setTimestamp(5, endTime);
            
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                message = "Train registered successfully!";
                color = "green";
            } else {
                message = "Failed to register train.";
                color = "red";
            }
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
        color = "red";
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Portal</title>
  <link rel="stylesheet" href="admin.css">
</head>
<body>
  <div class="container">
    <nav>
      <button onclick="showSection('home')">Home</button>
      <button onclick="showSection('registerTrain')">Register Train</button>
      <button onclick="showSection('profile')">Profile</button>
      <button onclick="logout()">Logout</button>
    </nav>

    <section id="home" class="section">
      <h2>Admin Dashboard</h2>
      <% if (!message.isEmpty()) { %>
        <div class="message" style="color: <%=color%>"><%= message %></div>
      <% } %>
      <div class="aggregate">
        <h3>Statistics</h3>
        <p>Tickets per Class: <span id="ticketsPerClass">0</span></p>
        <p>Sales per Quarter: <span id="salesPerQuarter">0</span></p>
      </div>
    </section>

    <section id="registerTrain" class="section hidden">
      <h2>Register New Train</h2>
      <form action="admin.jsp" method="post">
        <label for="trainName">Train Name:</label>
        <input type="text" name="trainName" required>

        <label for="from">From:</label>
        <input type="text" name="startStation" required>

        <label for="to">To:</label>
        <input type="text" name="endStation" required>

        <label for="startAt">Start Date & Time:</label>
        <input type="datetime-local" name="startAt" required>

        <label for="endAt">End Date & Time:</label>
        <input type="datetime-local" name="endAt" required>

        <button type="submit">Register Train</button>
      </form>
    </section>
  </div>
  <script src="admin.js"></script>
</body>
</html>