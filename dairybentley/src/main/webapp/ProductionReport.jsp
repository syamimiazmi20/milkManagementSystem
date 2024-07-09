<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Milk.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milk Production Report - Admin</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap">
    
    <style>
        :root {
            --primary-color: #4a6741;
            --secondary-color: #8fbc8f;
            --background-color: #f4f4f4;
            --text-color: #333;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            display: flex;
            flex-direction: column;
            flex: 1;
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

        .sidebar a, .sidebar .dropdown-btn {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            background-color: transparent;
            border: none;
            text-align: left;
            width: calc(100% - 30px);
            cursor: pointer;
            outline: none;
            margin: 0 auto;
        }

        .sidebar a:hover, .sidebar .dropdown-btn:hover {
            background-color: #7db36f;
        }

        .sidebar .dropdown-container {
            display: none;
            background-color: #5c8852;
        }

        .sidebar .dropdown-container a {
            padding-left: 45px;
        }

        .sidebar .logout-btn {
            position: absolute;
            bottom: 20px;
            width: calc(100% - 30px);
            margin: 0 15px;
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
            flex: 1;
        }

        .content.shifted {
            margin-left: 250px;
        }

        .date-selection {
            margin-bottom: 20px;
        }

        .date-selection label, .date-selection input, .date-selection button {
            margin-right: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: var(--primary-color);
            color: white;
        }

        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            text-align: center;
        }
        
    </style>
</head>
<body>
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

    <div class="header">
        <button class="menu-btn" id="menuBtn">☰</button>
        <div class="date-time" id="date-time"></div>
        <a href="homePage.jsp">
            <img src="user.jpeg" alt="User Profile" class="profile">
        </a>
    </div>

    <div class="container">
        <div class="content">
            <h1>Milk Production Report</h1>
            <form method="post" action="ViewProductionReport">
                <div class="date-selection">
                    <label for="fromDate">From Date:</label>
                    <input type="date" id="fromDate" name="fromDate">
                    <label for="toDate">To Date:</label>
                    <input type="date" id="toDate" name="toDate">
                    <button type="submit">Generate Report</button>
                </div>
            </form>
            <div class="report-section">
                <table>
                    <thead>
                        <tr>
                            <th>Employee ID</th>
                            <th>Production ID</th>
                            <th>Production Date</th>
                            <th>Production Time</th>
                            <th>Amount In (L)</th>
                            <th>Total Production (L)</th>
                            <th>Amount Balance (L)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<MilkProduction> list = (List<MilkProduction>) request.getAttribute("milkList");
                            if (list != null && !list.isEmpty()) {
                                for (MilkProduction milk : list) {
                        %>
                        <tr>
                            <td><%= milk.getEmpId() %></td>
                            <td><%= milk.getProductionId() %></td>
                            <td><%= milk.getProductionDate() %></td>
                            <td><%= milk.getProductionTime() %></td>
                            <td><%= milk.getAmount() %></td>
                            <td><%= milk.getTotalProduction() %></td>
                            <td><%= milk.getAmountBalance() %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7">No data available for the selected date range.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 Dairy Ben by Bentley. All rights reserved.</p>
        </div>
    </footer> 
    <script>
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
            
            // Dropdown functionality
            const dropdownBtn = document.querySelector('.dropdown-btn');
            const dropdownContainer = document.querySelector('.dropdown-container');

            dropdownBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                dropdownContainer.style.display = dropdownContainer.style.display === 'block' ? 'none' : 'block';
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
