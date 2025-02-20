<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.*, java.math.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String message = "";
    String color = "";

    // Database connection details
    
    String dbURL = "jdbc:derby:D:\\Users\\2794667\\MyDB;create=true"; 

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    

    try {
        Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        conn = DriverManager.getConnection(dbURL);

        
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("registerEmail") != null) {
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("registerEmail");
            String password = request.getParameter("registerPassword");
            String confirmPassword = request.getParameter("registerConfirmPassword");
            String gender = request.getParameter("gender");

            // Handle null values for age
            String ageParam = request.getParameter("age");
            int age = (ageParam != null && !ageParam.isEmpty()) ? Integer.parseInt(ageParam) : 0; 

            if (!password.equals(confirmPassword)) {
                message = "Passwords do not match!";
                color= "red";
            } else {
                // Hash password
                MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(password.getBytes());
                byte[] digest = md.digest();
                String hashedPassword = new BigInteger(1, digest).toString(16);

                String sql = "INSERT INTO users (first_name, last_name, age, gender, email, password) VALUES (?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setInt(3, age);
                stmt.setString(4, gender);
                stmt.setString(5, email);
                stmt.setString(6, hashedPassword);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    message = "Registration successful! You can now log in.";
                    color= "green";
                } else {
                    message = "Registration failed. Please try again.";
                    color= "red";
                }
            }
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html
>
<html lang="en">
<head>
    <meta  charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Portal</title>
    <link rel="stylesheet"
 href= "admin.css">
</head>
<body>
    <div class="container">
        <nav>
            <button onclick="showSection('home')">Home</button>
            <button onclick="showSection('registerTrain')">Register Train</button>
            <button onclick="showSection('profile')">Profile</button>
            <button onclick="logout()">Logout</button>
        </nav>

        <!-- Home Section -->
        <section id="home" class="section">
            <h2>Admin Dashboard</h2>
            
            <!-- Aggregate Section -->
            <div class="aggregate">
                <h3>Statistics</h3>
                <p>Tickets per Class: <span id="ticketsPerClass">0</span></p>
                <p>Sales per Quarter: <span id="salesPerQuarter">0</span></p>
            </div>

            <!-- Clients Table -->
            <div class="clients">
                <h3>Clients</h3>
                <table id="clientsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Mobile</th>
                            <th>Tickets Booked</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Clients will be populated here -->
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Register Train Section -->
        <section id="registerTrain" class="section hidden">
            <h2>Register New Train</h2>
            <form id="trainForm" action="registerTrain" method="post">
                <label for="trainName">Train Name:</label>
                <input type="text" id="trainName" name="trainName" required>

                <label for="seats">Number of Seats:</label>
                <input type="number" id="seats" name
="seats" required>

                <label for="from">From:</label>
                <input type="text" id="from" name="from" required>

                <label for="to">To:</label>
                <input type="text" id="to" name="to" required>

                <label for="ownership">Ownership:</label>
                <input type="text" id="ownership" name="ownership" required>

                <button type="submit">Register Train</button>
            </form>
        </section>

        <!-- Profile Section -->
        <section id="profile" class="section hidden">
            <h2>Update Profile</h2>
            <form id="profileForm" action="updateProfile" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>

                <label for="password">New Password:</label>
                <input type="password" id="password" name="password">

                <label for="mobile">Mobile Number:</label>
                <input type="text" id="mobile" name="mobile" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <button type="submit">Update Profile</button>
            </form>
        </section>
    </div>

    <script src="admin.js"></script>
</body>
</html>
