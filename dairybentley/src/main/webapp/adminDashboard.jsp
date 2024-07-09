<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        :root {
            --primary-color: #4a6741; /* Green */
        }

        body {
            font-family: Arial, sans-serif;
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
            background-color: #6a9a5e; /* Lighter green color */
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
            padding: 80px 20px 20px 20px;
            margin-left: 0;
            transition: margin-left 0.3s;
            flex: 1;
        }

        .content.shifted {
            margin-left: 250px;
        }

        .card-container {
            display: flex;
            justify-content: space-around;
            margin-bottom: 40px;
        }

        .card {
            padding: 20px;
            border-radius: 10px;
            color: #333;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            flex: 1;
            margin: 0 10px;
            min-width: 200px;
            max-width: 300px;
        }

        .card h2 {
            margin: 0 0 10px;
        }

        .card p {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .card-employee {
            background-color: #e0f7fa;
        }

        .card-production {
            background-color: #ffecb3;
        }

        .card-sales {
            background-color: #ffe0b2;
        }

        .chart-container {
            width: 100%;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .chart-box {
            flex: 1;
            min-width: 300px;
            max-width: 500px;
            padding: 20px;
        }

        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            text-align: center;
        }

        @media (max-width: 768px) {
            .footer-content {
                flex-direction: column;
            }
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    
    <div class="header">
        <button class="menu-btn" id="menuBtn">☰</button>
        <div class="date-time" id="date-time"></div>
        <a href="homePage.jsp">
            <img src="user.jpeg" alt="User Profile" class="profile">
        </a>
    </div>

    <div class="container">
        <div class="content">
            <h1>Admin Dashboard</h1>
            <div class="card-container">
                <div class="card card-employee">
                    <h2>Total Current Employees</h2>
                    <p><%= request.getAttribute("totalEmployees") != null ? request.getAttribute("totalEmployees") : 0 %></p>
                </div>
                <div class="card card-production">
                    <h2>Total Milk Production (Last 30 Days)</h2>
                    <p><%= request.getAttribute("totalMilkProduction") != null ? request.getAttribute("totalMilkProduction") : 0 %> Liters</p>
                </div>
                <div class="card card-sales">
                    <h2>Total Sales (Last 30 Days)</h2>
                    <p>RM <%= request.getAttribute("totalSales") != null ? request.getAttribute("totalSales") : 0 %></p>
                </div>
            </div>
            <div class="chart-container">
                <div class="chart-box">
                    <canvas id="employeeChart"></canvas>
                </div>
                <div class="chart-box">
                    <canvas id="productionChart"></canvas>
                </div>
                <div class="chart-box">
                    <canvas id="salesChart"></canvas>
                </div>
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
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' };
            document.getElementById('date-time').textContent = now.toLocaleDateString('en-US', options);
        }

        setInterval(updateDateTime, 1000);
        updateDateTime();

        // Employee Chart
        const employeeCtx = document.getElementById('employeeChart').getContext('2d');
        const employeeChart = new Chart(employeeCtx, {
            type: 'bar',
            data: {
                labels: ['Total Employees'],
                datasets: [{
                    label: 'Employees',
                    data: [<%= request.getAttribute("totalEmployees") != null ? request.getAttribute("totalEmployees") : 0 %>],
                    backgroundColor: '#4caf50',
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Production Chart
        const productionCtx = document.getElementById('productionChart').getContext('2d');
        const productionChart = new Chart(productionCtx, {
            type: 'bar',
            data: {
                labels: ['Total Milk Production (Last 30 Days)'],
                datasets: [{
                    label: 'Milk Production (Liters)',
                    data: [<%= request.getAttribute("totalMilkProduction") != null ? request.getAttribute("totalMilkProduction") : 0 %>],
                    backgroundColor: '#2196f3',
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Sales Chart
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        const salesChart = new Chart(salesCtx, {
            type: 'bar',
            data: {
                labels: ['Total Sales (Last 30 Days)'],
                datasets: [{
                    label: 'Sales (RM)',
                    data: [<%= request.getAttribute("totalSales") != null ? request.getAttribute("totalSales") : 0 %>],
                    backgroundColor: '#ff5722',
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

    });
    </script>
</body>
</html>
