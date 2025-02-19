<%@ page language="java" contentType="text/html"; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>Profile</title>
    <style>
    body{
        margin:0;
        padding:0;
    }
    .heading{
        background-color:#09122C;
        color:white;
        padding:10px;
        font-size:30px;  
    }
    img {
        width:200px;
        border-radius: 50%;
    }
    p{
        font-size:20px;
        font-weight:bold;
        
        
    }
    p span{
        padding-left:5px;
        color:grey;
    }
    .maincontainer{
        display:flex;
        width:70%;
        justify-content:space-around;
    }
    input,select{
        width:100%;
        padding:10px;
        margin-top:5px;
        border:1px solid #ddd;
        border-radius:5px;
        font-size:16px;
    }
    .btn{
        display:block;
        width:10%;
        padding:12px;
        background:#007bff;
        color:white;
        text-align:center;
        border-radius:px;
        cursor:pointer;
        font-size:18px;
        border:none;
        margin:10px;
    }
    .fields{
        display:flex;
        flex-direction:column;
    }
    .mainblock{
        display:flex;
        justify-content:space-around;
    }
    .block1{
        margin-right:200px;
    }
    .btn:hover{
        background:#0056b3;
    }
    table{
        width:100%;
        border-collapse:collapse;
        margin-top:20px;
        background:white;
        border-radius:8px;
        overflow:hidden;
    }
    th,td{
        padding:12px;
        border:1px solid #ddd;
        text-align:left;
    }
    th{
        background-color:#09122C;
        color:white
    }
    .hidden{
        display:none;
    }
    </style>
    <script>
    function editProfile(){
            document.getElementById("editProfile").classList.remove("hidden"); 
        document.getElementById("displayProfile").classList.add("hidden");
         document.getElementById("editbutton").classList.add("hidden");
    }
    function saveProfile(){
        document.getElementById("nameDisplay").textContent=document.getElementById("firstName").value+""+document.getElementById("lastName").value;
         document.getElementById("ageDisplay").textContent=document.getElementById("age").value;
         document.getElementById("emailDisplay").textContent=document.getElementById("email").value;
         document.getElementById("genderDisplay").textContent=document.getElementById("gender").value;
         document.getElementById("displayProfile").classList.remove("hidden");
         document.getElementById("editProfile").classList.add("hidden");
    }
    </script>
</head>
<body>
  <h1 class="heading">My Profile</h1>
  <div class="container">
   <div class="maincontainer">
    <div class="image">
    <img src="avatar.avif">
    </div>
    <div  id="displayProfile" class="profile-info fields">
     <p>Name:<span id="nameDisplay"><%=request.getAttribute("name")%></span></p>
     <p>Email:<span id="emailDisplay"><%=request.getAttribute("email")%></span></p>
     <p>Age:<span id="ageDisplay"><%=request.getAttribute("age")%></span></p>
     <p>Gender:<span id="genderDisplay"><%=request.getAttribute("gender")%></span></p>
     </div>
     <div id="editProfile" class="profile-info hidden">
      <form onsubmit="event.preventDefault(); saveProfile();">
      <div class="mainblock">
      <div class="block1">
      <label>First Name:</label>
      <input type="text" id="firstName" name="firstName" value="<%=request.getAttribute("firstName")%>">
      <label>Last Name:</label>
      <input type="text" id="lastName" name="LastName" value="<%=request.getAttribute("lastName")%>">
      <label>Email:</label>
   
      
      <input type="email" id="email" name="email" value="<%=request.getAttribute("email")%>">
         </div>
      <div class="block2">
      <label>Password:</label>
      <input type="password" id="password" name="password" value="<%=request.getAttribute("password")%>">
      <label>Age:</label>
      <input type="number" id=age" name="age" value="<%=request.getAttribute("age")%>">
      <label>Gender:</label>
      <select id="gender" name="gender">
      <option value="Male"<%= "Male".equals(request.getAttribute("gender"))?"seleted":""%>>Male</option>
      <option value="Female" <%= "Female".equals(request.getAttribute("gender"))?"seleted":""%>>Female</option>
      </select>
      </div>
      </div>
      <button type="submit" class="btn">Save</button>
      </form>
      </div>
    


    </div>
    <h3>Booked Tickets</h3>
    <table>
     <tr>
       <th>Ticket Id</th>
       <th>Destination</th>
       <th>Date</th>
       <th>Price</th>
     </tr>
     <%@ page import="java.util.List,java.util.Map"%>
     <%List<Map<String,String>>tickets=(List<Map<String,String>>) request.getAttribute("tickets");
     if(tickets!=null){
         for(Map<String,String> ticket:tickets){%>
             <tr>
             <td><%=ticket.get("id")%></td>
             <td><%=ticket.get("destination")%></td>
             <td><%=ticket.get("date")%></td>
             <td>$<%=ticket.get("price")%></td>
             </tr>

         <%}
     }%>
    
     </table>
     <button onclick="editProfile()" id="editbutton" class="btn ">Edit Profile<button>
     
     

  </div>


</body>
</html>
