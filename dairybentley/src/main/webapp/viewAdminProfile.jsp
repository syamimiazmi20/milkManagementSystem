<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
if (session != null) {
    String adminName = (String) session.getAttribute("userName");
    String adminAddress = (String) session.getAttribute("userAddress");
    String adminEmail = (String) session.getAttribute("userEmail");
    String adminPhoneNum = (String) session.getAttribute("userPhone");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Admin Profile</title>
    <style>
	        :root {
	            --primary-color: #4a6741;
	            --secondary-color: #8fbc8f;
	            --background-color: #f4f4f4;
	            --text-color: #333;
	        }
	
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f9f9f9;
	            color: #333;
	            margin: 0;
	        }
	
	        .sidebar {
	            width: 250px;
	            position: fixed;
	            top: 0;
	            left: -250px;
	            height: 100%;
	            background-color: #6a9a5e;
	            padding-top: 20px;
	            box-sizing: border-box;
	            transition: 0.3s;
	            z-index: 1001;
	        }
	
	        .sidebar.active {
	            left: 0;
	        }
	
	        .sidebar-header {
	            display: flex;
	            align-items: center;
	            padding: 0 15px 20px;
	        }
	
	        .sidebar img.logo {
	            height: 40px;
	            width: 40px;
	            border-radius: 50%;
	            border: 2px solid white;
	        }
	
	        .sidebar-header .brand-name {
	            color: white;
	            font-size: 20px;
	            font-weight: bold;
	            margin-left: 10px;
	        }
	
	        .sidebar a {
	            padding: 10px 15px;
	            text-decoration: none;
	            font-size: 18px;
	            color: white;
	            display: block;
	        }
	
	        .sidebar a:hover {
	            background-color: #7db36f;
	        }
	
	        .header {
	            display: flex;
	            justify-content: space-between;
	            align-items: center;
	            background-color: #4a6741;
	            padding: 10px 20px;
	            position: fixed;
	            width: 100%;
	            top: 0;
	            z-index: 1000;
	            font-family: 'poppins', serif;
	            box-sizing: border-box;
	        }
	
	        .header .menu-btn {
	            background: none;
	            border: none;
	            color: white;
	            font-size: 24px;
	            cursor: pointer;
	        }
	
	        .header .date-time {
	            flex-grow: 1;
	            text-align: center;
	            color: white;
	        }
	
	        .header img.profile {
	            height: 40px;
	            border-radius: 50%;
	        }
	
	        .content {
	            padding: 80px 20px 20px;
	            margin-left: 0;
	            transition: margin-left 0.3s;
	        }
	
	        .content.shifted {
	            margin-left: 250px;
	        }
	
	         .form-container {
        max-width: 500px;
        margin: 40px auto;
        background-color: #ffffff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .form-container h1 {
        text-align: center;
        color: var(--primary-color);
        margin-bottom: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: var(--primary-color);
    }

    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }

    .button-group {
        text-align: center;
        margin-top: 30px;
    }

    .button-group button {
        padding: 12px 24px;
        margin: 0 10px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .button-group button:hover {
        background-color: var(--secondary-color);
    }
	
	        footer {
	            background-color: var(--primary-color);
	            color: white;
	            padding: 2rem 0;
	            margin-top: 40px;
	        }
	
	        .footer-content {
	            display: flex;
	            justify-content: space-around;
	            flex-wrap: wrap;
	            max-width: 1200px;
	            margin: 0 auto;
	        }
	
	        .footer-section {
	            flex: 1;
	            margin: 1rem;
	            min-width: 200px;
	        }
	
	        .footer-section h3 {
	            margin-bottom: 1rem;
	        }
	
	        .footer-section ul {
	            list-style-type: none;
	            padding: 0;
	        }
	
	        .footer-section ul li {
	            margin-bottom: 0.5rem;
	        }
	
	        .footer-section ul li a {
	            color: white;
	            text-decoration: none;
	        }
	
	        .footer-bottom {
	            text-align: center;
	            padding-top: 1rem;
	            margin-top: 1rem;
	            border-top: 1px solid rgba(255, 255, 255, 0.3);
	        }
	    </style>
</head>
<body>
<%
    Integer empID = (Integer) session.getAttribute("userID");
%>
   <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <img src="logo.jpeg" alt="Logo" class="logo">
            <span class="brand-name">DairyBen</span>
        </div>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="viewAdminProfile.jsp">Account</a>
        <a href="manageEmployees.jsp">Manage Employee</a>
        <button class="dropdown-btn">Reports 
            <span>&#9660;</span>
        </button>
        <div class="dropdown-container">
            <a href="ProductionReport.jsp">Milk Production Report</a>
            <a href="ListMilkPurchase.jsp">Milk Purchase list</a>
        </div>
        <a href="index.jsp" class="logout-btn">Log Out</a>
    </div>
    <div class="content">
        <div class="form-container">
            <h1>Admin Profile</h1>
            <form action="" method="post">
                <div class="form-group">
                    <label for="adminName">Name</label>
                    <input type="text" id="adminName" value="<%= adminName %>" disabled>
                </div>
                <div class="form-group">
                    <label for="adminEmail">Email</label>
                    <input type="text" id="adminEmail" value="<%= adminEmail %>" disabled>
                </div>
                <div class="form-group">
                    <label for="adminAddress">Address</label>
                    <input type="text" id="adminAddress" value="<%= adminAddress %>" disabled>
                </div>
                <div class="form-group">
                    <label for="adminPhone">Phone Number</label>
                    <input type="text" id="adminPhone" value="<%= adminPhoneNum %>" disabled>
                </div>
                <div class="button-group">
                    <button type="button" onclick="editProfile()">Edit</button>
                    <button type="button" onclick="deleteProfile()">Delete</button>
                </div>
            </form>
        </div>
    </div>

     <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 Dairy Ben by Bentley. All rights reserved.</p>
        </div>
    </footer>
    <script>
        // Function to navigate to edit profile page
        function editProfile() {
            window.location.href = 'editAdminProfile.jsp';
        }

        // Function to handle profile deletion (if needed)
        function deleteProfile() {
            if (confirm('Are you sure you want to delete your profile?')) {
                // Implement deletion logic here
            }
        }
    </script>
</body>
</html>

<%
} else {
    response.sendRedirect("adminLogin.jsp?error=notLoggedIn");
}
%>
