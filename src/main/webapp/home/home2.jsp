<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.*, java.math.*, javax.servlet.http.*, javax.servlet.*, java.util.*" %>

<%
   	ArrayList<String> start = new ArrayList<>();
	ArrayList<String> end = new ArrayList<>();

    // Database connection details
    String dbURL = "jdbc:derby:C:\\Users\\Dell\\MyDB;create=true"; 

    Connection conn = null;
    PreparedStatement stmt = null;
    PreparedStatement stmt1 = null;

    try {
        Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        conn = DriverManager.getConnection(dbURL);
        
        String query = "SELECT start_station FROM trains";
        String query1 = "SELECT end_station FROM trains";
        
        stmt = conn.prepareStatement(query);
        stmt1 = conn.prepareStatement(query1);
        
        ResultSet rs1 = stmt.executeQuery();
        ResultSet rs2 = stmt1.executeQuery();
        
        while(rs1.next()){
        	start.add(rs1.getString("start_station"));
        }
        
        while(rs2.next()){
        	end.add(rs2.getString("end_station"));
        }
        

        
        if (rs1 != null) rs1.close();
        if (rs2 != null) rs2.close();
    } catch (Exception e) {
        System.out.print( "Error: " + e.getMessage());
    } finally {
        
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-icons@1.13.12/iconfont/material-icons.min.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href='style.css' rel='stylesheet'>
  <title>Train Ticket</title>
</head>

<body>
  <nav class="navbar">
    <div class="container">
      <div class="row justify-content-between align-items-center">
        <div class="logo">E<span>Yatra</span></div>
        <input type="checkbox" name="" id="click">
        <label for="click" class="menu-btn">
          <i class="material-icons">menu</i>
        </label>
        <ul>
          <li><a href="#" class="active">Home</a></li>
          <li><a href="../admin/admin.html">Profile</a></li> 
        </ul>
      </div>
    </div>
  </nav>
  <section id="main-hero">

    <form class="bokingSpace" action="../availableTrains/cards.jsp" method="get">
      <div class="options">
        <input  checked="checked" class="radio"  type="radio" id="book" name="opt">
        <label class="option_bp select" for="book" >Book Train</label> 
         
      </div>

      <div class="inputeFiledContainer">
        <div class="from field-inp">
          <p>From</p>
          <!-- <input value="Delhi" > -->
          <select value="Delhi" name="start_station" id="input_box" class="input_box">
          <%
		        for(String city : start) {
		    %>
		        <option value="<%= city %>"><%= city %></option>
		    <%
		        }
		    %>
            
          </select>
          <p>NDLS, New Delhi Railway Station</p>
        </div>
        <div class="to field-inp">
          <p>To</p>
          <select value="Delhi" name="end_station" id="input_box" class="input_box">
            <<%
		        for(String city : end) {
		    %>
		        <option value="<%= city %>"><%= city %></option>
		    <%
		        }
		    %>
		    <option value="Delhi">Delhi</option>
          </select>
          <p>CSMT, Mumbai Railway Station</p>
        </div>
        <div class="date field-inp">
          <p>Travel Date</p>
          <div class="cont">
            <p class="disp_date"><span>6</span> Feb' 25</p>
            <input type="date" id="input_box date" class="input_box date_box">
          </div>
          <p>Thursday</p>

        </div>
        <div class="class field-inp">
          <p>Class</p>
          <select value="Delhi" name="class" id="input_box" class="input_box">
            <option value="Delhi">All</option>
          </select>
          <p>All Class</p>

        </div>
      </div>

      <input type="submit"  class="searchBtn"> Search </a> 
    </form>

  </section>
 
  <section class="moreDetails">
  
    <div class="user-card">
        <div class="upcomming">
            <h3 class="uc_title" >Upcoming Journey</h3>
            <div class="card_box">


                <!-- TO be in javascript -->
                <div class="card">
                  <span class="tag">
                    Complete
                  </span>
                  <div class="card_header">
                    <img src="https://tse3.mm.bing.net/th/id/OIP.K0hNUKtpph8FcAsgqWONtwHaHa?rs=1&pid=ImgDetMain" alt="T" class="train-logo">
                    <p>Kerla Express, Thane</p>
                    <span>3</span>
                  </div>
                  <div class="journey">
                    <div class="from_loc">
                        <p class="place">NMZ, Delhi</p>
                        <p class="time">24:05</p>
                        <p class="date">23 Jul'25</p>
                    </div>
                    <div class="arrow">
                        ->
                    </div>
                    <div class="to_loc">
                        <p class="place">Thane, Mumbai</p>
                        <p class="time">08:25</p>
                        <p class="date">24 Jul'25</p>
                    </div>

                  </div>
                  <div class="btns">
                    <a class="cancelbtn">Cancel Ticket</a>
                    <a href="../finalTicket/index.html" class="viewbtn">View Ticket</a>
                  </div>
                </div>


                <!-- TO be in javascript -->
                <div class="card">
                  <span class="tag">
                    Complete
                  </span>
                  <div class="card_header">
                    <img src="https://tse3.mm.bing.net/th/id/OIP.K0hNUKtpph8FcAsgqWONtwHaHa?rs=1&pid=ImgDetMain" alt="T" class="train-logo">
                    <p>Kerla Express, Thane</p>
                    <span>3</span>
                  </div>
                  <div class="journey">
                    <div class="from_loc">
                        <p class="place">NMZ, Delhi</p>
                        <p class="time">24:05</p>
                        <p class="date">23 Jul'25</p>
                    </div>
                    <div class="arrow">
                        ->
                    </div>
                    <div class="to_loc">
                        <p class="place">Thane, Mumbai</p>
                        <p class="time">08:25</p>
                        <p class="date">24 Jul'25</p>
                    </div>

                  </div>
                  <div class="btns">
                    <a class="cancelbtn">Cancel Ticket</a>
                    <a href="../finalTicket/index.html"  class="viewbtn">View Ticket</a>
                  </div>
                </div>

            </div>
        </div>
        <div class="history">
            <h3 class="uc_title" >Booking History</h3>
            <div class="card_box"> 
                



                <!-- TO be in javascript -->
                <div class="card">
                  <span class="tag">
                    Complete
                  </span>
                  <div class="card_header">
                    <img src="https://tse3.mm.bing.net/th/id/OIP.K0hNUKtpph8FcAsgqWONtwHaHa?rs=1&pid=ImgDetMain" alt="T" class="train-logo">
                    <p>Kerla Express, Thane</p>
                    <span>3</span>
                  </div>
                  <div class="journey">
                    <div class="from_loc">
                        <p class="place">NMZ, Delhi</p>
                        <p class="time">24:05</p>
                        <p class="date">23 Jul'25</p>
                    </div>
                    <div class="arrow">
                        ->
                    </div>
                    <div class="to_loc">
                        <p class="place">Thane, Mumbai</p>
                        <p class="time">08:25</p>
                        <p class="date">24 Jul'25</p>
                    </div>

                  </div>
                  <div class="btns"> 
                    <a class="cancelbtn">Cancel Ticket</a>
                    <a href="../finalTicket/index.html"  class="viewbtn">View Ticket</a>
                  </div>
                </div>



            </div>
        </div>
    </div>
  
   </section> 





  <script defer type="text/javascript" src="/main.js"></script>
</body>

</html>