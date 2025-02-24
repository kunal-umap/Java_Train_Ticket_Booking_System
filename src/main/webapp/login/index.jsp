<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.*, java.math.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String message = "";

    // Database connection details
    String dbURL = "jdbc:derby:C:\\Users\\Dell\\MyDB;create=true"; 

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        conn = DriverManager.getConnection(dbURL);

        // Handle Login 
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("email") != null) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Hash password
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            String hashedPassword = new BigInteger(1, digest).toString(16);

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, hashedPassword);
            rs = stmt.executeQuery();

            if (rs.next()) {
                session.setAttribute("user", email);
                response.sendRedirect("../home/home2.html"); // Redirect to home page
                return;
            } else {
                message = "Invalid email or password!";
            }
        }

        // Handle Registration
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
                } else {
                    message = "Registration failed. Please try again.";
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="overlay"></div>
    <div class="container">
        <% if (!message.isEmpty()) { %>
            <div class="message"><%= message %></div>
        <% } %>
        <div class="form-container">
            <div id="login-form" class="form-section active">
                <h2>Login</h2>
                <form action="index.jsp" method="post">
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Login</button>
                </form>
                <div class="toggle-btn" onclick="toggleForm('register')">Don't have an account? Register</div>
            </div>
            <div id="register-form" class="form-section">
                <h2>Register</h2>
                <form action="index.jsp" method="post">
                    <input type="text" name="first_name" placeholder="First Name*" required>
                    <input type="text" name="last_name" placeholder="Last Name*" required>
                    <input type="number" name="age" placeholder="Age" required> 

                    <select name="gender" required>
                        <option value="" disabled selected>Select Gender</option>
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                        <option value="O">Other</option>
                    </select>

                    <input type="email" name="registerEmail" placeholder="Email*" required>

                    <div class="password-container">
                        <input type="password" name="registerPassword" placeholder="Password*" required>
                        <span id="togglePassword" class="eye-icon">&#128065;</span> 
                    </div>
                    <input type="password" name="registerConfirmPassword" placeholder="Confirm Password*" required>

                    <button type="submit">Register</button>
                </form>
                <div class="toggle-btn" onclick="toggleForm('login')">Already have an account? Login</div>
            </div>
        </div>
    </div>

    <script>
        function toggleForm(formType) {
            document.getElementById('login-form').classList.toggle('active', formType === 'login');
            document.getElementById('register-form').classList.toggle('active', formType === 'register');
        }
    </script>
</body>
</html>
