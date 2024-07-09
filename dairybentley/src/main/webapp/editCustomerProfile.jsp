<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
if (session != null) {
    String name = (String) session.getAttribute("userName");
    String address = (String) session.getAttribute("userAddress");
    String email = (String) session.getAttribute("userEmail");
    String phoneNum = (String) session.getAttribute("userPhone");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer Profile</title>
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
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <img src="logo.jpeg" alt="Logo" class="logo">
            <span class="brand-name">DairyBen</span>
        </div>
        <a href="customerDashboard.jsp">Dashboard</a>
        <a href="viewCustomerProfile.jsp">Account</a>
        <a href="MilkPurchase.jsp">Milk Purchase</a>
        <a href="index.jsp" class="logout-btn">Log Out</a>
    </div>
    
    <div class="header">
        <button class="menu-btn" id="menuBtn">☰</button>
        <div class="date-time" id="date-time"></div>
        <a href="customerProfile.jsp">
            <img src="user.jpeg" alt="User Profile" class="profile">
        </a>
    </div>

    <div class="content">
    <div class="form-container">
        <h1>Edit Customer Profile</h1>
        <form action="UpdateCustomerServlet" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= name %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="<%= address %>" required>
            </div>
            <div class="form-group">
                <label for="phoneNum">Phone Number</label>
                <input type="tel" id="phoneNum" name="phoneNum" value="<%= phoneNum %>" required>
            </div>
            <div class="button-group">
                <button type="submit">Save Changes</button>
                <button type="button" onclick="discardChanges()">Discard Changes</button>
            </div>
        </form>
    </div>
</div>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <p>Dairy Ben provides fresh, organic milk straight from our farm to your table.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="customerDashboard.jsp">Dashboard</a></li>
                    <li><a href="customerProfile.jsp">Profile</a></li>
                    <li><a href="milkPurchase.jsp">Purchase Milk</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>Email: info@dairyben.com</p>
                <p>Phone: (123) 456-7890</p>
                <p>Address: 123 Milk Way, Dairy Town, DT 12345</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 Dairy Ben by Bentley. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function discardChanges() {
            window.location.href = 'viewCustomerProfile.jsp';
        }

        document.addEventListener('DOMContentLoaded', function () {
            const sidebar = document.getElementById('sidebar');
            const menuBtn = document.getElementById('menuBtn');
            const content = document.querySelector('.content');

            menuBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                sidebar.classList.toggle('active');
                content.classList.toggle('shifted');
            });

            // Close sidebar when clicking outside
            document.addEventListener('click', function(e) {
                if (!sidebar.contains(e.target) && !menuBtn.contains(e.target)) {
                    sidebar.classList.remove('active');
                    content.classList.remove('shifted');
                }
            });

            // Date and Time display
            function updateDateTime() {
                const now = new Date();
                const options = { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric', 
                    hour: '2-digit', 
                    minute: '2-digit',
                    second: '2-digit'
                };
                document.getElementById('date-time').textContent = now.toLocaleDateString('en-US', options);
            }

            setInterval(updateDateTime, 1000);
            updateDateTime();
        });
    </script>
</body>
</html>

<%
} else {
    response.sendRedirect("customerLogin.jsp?error=notLoggedIn");
}
%>