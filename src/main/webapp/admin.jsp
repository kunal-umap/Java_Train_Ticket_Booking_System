<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Session Handling - Redirect to login if admin is not logged in
    HttpSession sessionAdmin = request.getSession(false);
    if (sessionAdmin == null || sessionAdmin.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Sample Admin Data (Can be fetched from DB)
    String adminUsername = "admin";
    String adminEmail = "admin@railway.com";
    String adminMobile = "9876543210";

    // Simulated Clients Data (In a real scenario, fetch from database)
    List<Map<String, String>> clients = new ArrayList<>();
    Map<String, String> client1 = new HashMap<>();
    client1.put("id", "1");
    client1.put("name", "John Doe");
    client1.put("mobile", "1234567890");
    client1.put("tickets", "3");
    clients.add(client1);
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

        <!-- Home Section -->
        <section id="home" class="section">
            <h2>Admin Dashboard</h2>
            <div class="aggregate">
                <h3>Statistics</h3>
                <p>Tickets per Class: <span id="ticketsPerClass"><%= clients.stream().mapToInt(c -> Integer.parseInt(c.get("tickets"))).sum() %></span></p>
                <p>Sales per Quarter: <span id="salesPerQuarter">0</span></p>
            </div>

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
                        <% for (Map<String, String> client : clients) { %>
                            <tr>
                                <td><%= client.get("id") %></td>
                                <td><%= client.get("name") %></td>
                                <td><%= client.get("mobile") %></td>
                                <td><%= client.get("tickets") %></td>
                                <td><button onclick="deleteClient('${client.get(id)')">Delete</button></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Register Train Section -->
        <section id="registerTrain" class="section hidden">
            <h2>Register New Train</h2>
            <form action="TrainServlet" method="post">
                <label for="trainName">Train Name:</label>
                <input type="text" id="trainName" name="trainName" required>

                <label for="seats">Number of Seats:</label>
                <input type="number" id="seats" name="seats" required>

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
            <form action="ProfileServlet" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= adminUsername %>" required>

                <label for="password">New Password:</label>
                <input type="password" id="password" name="password">

                <label for="mobile">Mobile Number:</label>
                <input type="text" id="mobile" name="mobile" value="<%= adminMobile %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= adminEmail %>" required>

                <button type="submit">Update Profile</button>
            </form>
        </section>
    </div>

    <script>
        function showSection(sectionId) {
            document.querySelectorAll('.section').forEach(section => {
                section.classList.add('hidden');
            });
            document.getElementById(sectionId).classList.remove('hidden');
        }

        function logout() {
            window.location.href = 'logout.jsp';
        }

        function deleteClient(clientId) {
            if (confirm('Are you sure you want to delete this client?')) {
                // In a real application, send request to servlet
                alert("Client deleted: " + clientId);
                location.reload();
            }
        }

        showSection('home');
    </script>
</body>
</html>
