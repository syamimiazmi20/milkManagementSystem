<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Milk.model.Employee" %>
<%@ page import="Milk.dao.EmployeeDAO" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Employee</title>
    <style>
        :root {
            --primary-color: #4a6741;
            --secondary-color: #6a9a5e;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: -250px;
            height: 100%;
            background-color: var(--secondary-color);
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
            background-color: var(--primary-color);
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
        }

        .content.shifted {
            margin-left: 250px;
        }

        .main-title {
            color: #333;
            font-size: 36px;
            font-family: 'Playfair Display', serif;
            margin-bottom: 20px;
        }

        .add-employee button {
            background-color: var(--secondary-color);
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            color: white;
            font-family: 'Roboto', sans-serif;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }

        .add-employee button:hover {
            background-color: var(--primary-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        th, td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: var(--secondary-color);
            color: white;
            font-family: 'Playfair Display', serif;
        }

        .actions button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-family: 'Roboto', sans-serif;
            background-color: var(--primary-color);
            color: white;
            margin-right: 5px;
        }

        .actions button:hover {
            background-color: #3a5331;
        }

        .form-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: none;
            z-index: 9;
            background-color: #f9f9f9;
            padding: 40px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
        }

        .form-container {
            padding: 20px;
            background-color: transparent;
        }

        .form-container h2 {
            font-family: 'Playfair Display', serif;
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-container input[type="text"], 
        .form-container input[type="password"], 
        .form-container input[type="number"], 
        .form-container input[type="email"], 
        .form-container input[type="tel"], 
        .form-container select {
            width: 100%;
            padding: 12px;
            margin: 5px 0 15px 0;
            border: 1px solid var(--secondary-color);
            background: #fff;
            border-radius: 5px;
            font-family: 'Roboto', sans-serif;
        }

        .form-container .btn, .form-container .cancel {
            background-color: var(--secondary-color);
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 10px;
            opacity: 0.8;
            transition: background-color 0.3s, opacity 0.3s;
            border-radius: 5px;
            font-family: 'Roboto', sans-serif;
            font-weight: bold;
        }

        .form-container .btn:hover, .form-container .cancel:hover {
            background-color: var(--primary-color);
            opacity: 1;
        }

        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            text-align: center;
            margin-top: auto;
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
        <a href="logout.jsp" class="logout-btn">Log Out</a>
    </div>

    <div class="header">
        <button class="menu-btn" id="menuBtn">☰</button>
        <div class="date-time" id="date-time"></div>
        <a href="adminDashboard.jsp">
            <img src="user.jpeg" alt="User Profile" class="profile">
        </a>
    </div>

    <div class="content" id="content">
        <h1 class="main-title">Manage Employees</h1>
        <div class="add-employee">
            <button onclick="openForm('addForm')">Add Employee</button>
        </div>

	        <div class="table-container">
	            <table>
	                <thead>
	                    <tr>
	                        <th>Employee ID</th>
	                        <th>Employee Name</th>
	                        <th>Employee Email</th>
	                        <th>Employee Address</th>
	                        <th>Employee Phone Number</th>
	                        <th>Employee Role</th>
	                        <th>Actions</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <%
	                    EmployeeDAO employeeDAO = new EmployeeDAO();
                        List<Employee> employees = employeeDAO.getAllEmployees();

                        for (Employee employee : employees) {
	                    %>
	                    <tr>
	                        <td><%= employee.getId() %></td>
	                        <td><%= employee.getName() %></td>
	                        <td><%= employee.getEmail() %></td>
	                        <td><%= employee.getAddress() %></td>
	                        <td><%= employee.getPhoneNum() %></td>
	                        <td><%= employee.getRole() %></td>
	                        <td class="actions">
	                            <button onclick="openEditForm('<%= employee.getId() %>', '<%= employee.getName() %>', '<%= employee.getEmail() %>', '<%= employee.getAddress() %>', '<%= employee.getPhoneNum() %>', '<%= employee.getRole() %>', '<%= employee.getPassword() %>')">Edit</button>
	                            <form action="RegisterEmployeeServlet" method="post" style="display:inline;">
	                                <input type="hidden" name="action" value="delete">
	                                <input type="hidden" name="Id" value="<%= employee.getId() %>">
	                                <button type="submit">Delete</button>
	                            </form>
	                        </td>
	                    </tr>
	                    <%
	                            }
	                   
	                    %>
	                </tbody>
	            </table>
	        </div>
    </div>

    <div class="form-popup" id="addForm">
        <form action="RegisterEmployeeServlet" method="post" class="form-container">
            <h2>Add Employee</h2>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter employee name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter employee email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter employee password" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" placeholder="Enter employee address" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" placeholder="Enter employee phone number" required>
            </div>
            <div class="form-group">
                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="Employee">Employee</option>
                </select>
            </div>
            <div class="form-group">
                <label for="adminId">Admin:</label>
                <input type="text" id="adminId" name="adminId" placeholder="Enter Admin's ID" required>
            </div>
            <input type="hidden" name="action" value="add">
            <div class="form-buttons">
                <button type="submit" class="btn">Submit</button>
                <button type="button" class="btn cancel" onclick="closeForm('addForm')">Close</button>
            </div>
        </form>
    </div>

    <div class="form-popup" id="editForm">
        <form action="RegisterEmployeeServlet" method="post" class="form-container">
            <h2>Edit Employee</h2>
            <input type="hidden" id="editId" name="id">
            <div class="form-group">
                <label for="editName">Name:</label>
                <input type="text" id="editName" name="name" required>
            </div>
            <div class="form-group">
                <label for="editEmail">Email:</label>
                <input type="email" id="editEmail" name="email" required>
            </div>
            <div class="form-group">
                <label for="editAddress">Address:</label>
                <input type="text" id="editAddress" name="address" required>
            </div>
            <div class="form-group">
                <label for="editPhone">Phone Number:</label>
                <input type="tel" id="editPhone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="editRole">Role:</label>
                <select id="editRole" name="role" required>
                    <option value="Employee">Employee</option>
                </select>
            </div>
            <div class="form-group">
                <label for="editAdminId">Admin:</label>
                <input type="text" id="editAdminId" name="adminId" placeholder="Enter Admin's ID" required>
            </div>
            <div class="form-group">
                <label for="editPassword">Password:</label>
                <input type="password" id="editPassword" name="password" required>
            </div>
            <input type="hidden" name="action" value="update">
            <div class="form-buttons">
                <button type="submit" class="btn">Submit</button>
                <button type="button" class="btn cancel" onclick="closeForm('editForm')">Close</button>
            </div>
        </form>
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
        });

        function openForm(formId) {
            console.log('Opening form:', formId);
            document.getElementById(formId).style.display = 'block';
        }

        function closeForm(formId) {
            console.log('Closing form:', formId);
            document.getElementById(formId).style.display = 'none';
        }

        function confirmLogout() {
            document.getElementById('logoutPopup').style.display = 'block';
        }

        function logoutYes() {
            window.location.href = 'index.jsp';
        }

        function openEditForm(id, name, email, address, phone, role, password) {
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editEmail').value = email;
            document.getElementById('editAddress').value = address;
            document.getElementById('editPhone').value = phone;
            document.getElementById('editRole').value = role;
            document.getElementById('editPassword').value = password;
            openForm('editForm');
        }
    </script>
</body>
</html>
