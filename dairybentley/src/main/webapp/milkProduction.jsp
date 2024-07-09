<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Milk.model.MilkProduction" %>
<%@ page import="Milk.dao.MilkProductionDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Milk Production</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap">
    <style>
        :root {
            --main-green: #4a6741;
            --light-brown: #D2B48C;
            --dark-brown: #8B4513;
        }
        
        .background-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('why-are-dutch-farmers-interested-in-uk-dairy-farms.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            filter: brightness(70%);
            z-index: -1;
        }

        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: var(--main-green);
            color: white;
        }

        .header-left {
            display: flex;
            align-items: center;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid #8fbc8f;
            margin-right: 10px;
            object-fit: cover;
        }

        .brand-name {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .date-time {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .menu-button {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            width: 100px;
        }

        .menu-content {
            display: none;
            position: absolute;
            right: 0;
            top: 60px;
            background-color: var(--main-green);
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .menu-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .menu-content a:hover {
            background-color: #3a5234;
        }

        .main-content {
            flex-grow: 1;
            padding: 20px;
        }

        h1 {
            color: var(--main-green);
            margin-top: 10px;
            text-align: center;
            font-weight: 600;
        }

        .add-milk {
            text-align: right;
            margin-bottom: 20px;
        }

        .add-milk button {
            background-color: var(--main-green);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: var(--main-green);
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .form-popup {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            border: 3px solid #f1f1f1;
            z-index: 9;
        }

        .form-container {
            max-width: 300px;
            padding: 20px;
            background-color: white;
        }

        .form-container input[type=text], .form-container input[type=number], .form-container input[type=date], .form-container select {
            width: 100%;
            padding: 12px;
            margin: 5px 0 22px 0;
            border: 1px solid #ddd;
            background: #f1f1f1;
        }

        .form-container .btn {
            background-color: var(--main-green);
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 10px;
            opacity: 0.8;
        }

        .form-container .cancel {
            background-color: #ff4d4d;
        }

        .form-container .btn:hover, .open-button:hover {
            opacity: 1;
        }
        
        .logout-button {
    background-color: #d9534f;
    color: white;
    border: none;
    padding: 12px 16px;
    width: 100%;
    text-align: left;
    cursor: pointer;
}

.logout-button:hover {
    background-color: #c9302c;
}

.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 300px;
    text-align: center;
}

.modal-buttons button {
    margin: 10px;
    padding: 5px 10px;
    cursor: pointer;
}

        footer {
            background-color: var(--main-green);
            color: white;
            padding: 2rem 0;
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

        @media (max-width: 768px) {
            .footer-content {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <%
    Integer empID = (Integer) session.getAttribute("userID");
    if (empID == null) {
        empID = 0; // or handle this situation appropriately
        // You might want to redirect to login or show an error message
    }
	%>
    <header>  
        <div class="header-left">
            <div class="logo-container">
                <img src="logo.jpeg" alt="Dairy Ben Logo" class="logo">
                <span class="brand-name">DairyBen</span>
            </div>
        </div>
        <div class="date-time" id="date-time"></div>     
        <button class="menu-button" onclick="toggleMenu()">☰</button>
        <div class="menu-content" id="menuContent">
            <button class="logout-button" onclick="showLogoutModal()">Log Out</button>
        </div>
    </header>
    
    <div id="logoutModal" class="modal">
    <div class="modal-content">
        <p>Do you want to log out?</p>
        <div class="modal-buttons">
            <button onclick="logout()">Yes</button>
            <button onclick="closeLogoutModal()">No</button>
        </div>
    </div>
</div>

    <div class="background-image"></div>

    <div class="main-content">
        <div class="container">
            <h1>Milk Production</h1>
            <div class="add-milk">
                <button onclick="openForm('addForm')">Add Milk Entry</button>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>

            <div class="table-container">
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
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        MilkProductionDAO dao = new MilkProductionDAO();
                        List<MilkProduction> list = dao.getAllMilkProduction();
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
                        <td>
                            <button onclick="openEditForm('<%= milk.getProductionId() %>', '<%= milk.getEmpId() %>', '<%= milk.getProductionDate() %>', '<%= milk.getProductionTime() %>', '<%= milk.getAmount() %>', '<%= milk.getTotalProduction() %>', '<%= milk.getAmountBalance() %>')">Edit</button>
                        </td>
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
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <p>Dairy Ben provides fresh, organic milk straight from our farm to your table.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="homePage.jsp">Home</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#products">Products</a></li>
                    <li><a href="#contact">Contact</a></li>
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

    <!-- Add Milk Entry Form -->
    <div class="form-popup" id="addForm">
        <form action="AddMilkEntryServlet" method="post" class="form-container">
            <h2>Add Milk Entry</h2>
            <label for="empId">Employee ID:</label>
            <input type="text" id="empId" name="empId" value="<%= empID %>" readonly>
            <label for="productionDate">Production Date:</label>
            <input type="date" id="productionDate" name="productionDate" required >
            <label for="productionTime">Production Time:</label>
            <select id="productionTime" name="productionTime" required >
                <option value="morning">Morning</option>
                <option value="evening">Evening</option>
                <option value="night">Night</option>
            </select>
            <label for="amount">Amount In (L):</label>
            <input type="number" id="amount" name="amount" step="0.01" required>
            <input type="hidden" name="action" value="add">
        
            <div class="form-buttons">
                <button type="submit" class="btn">Submit</button>
                <button type="button" class="btn cancel" onclick="closeForm('addForm')">Close</button>
            </div>
        </form>
    </div>

    <!-- Edit Milk Entry Form -->
    <div class="form-popup" id="editForm">
        <form action="EditMilkEntryServlet" method="post" class="form-container">
            <h2>Edit Milk Entry</h2>
            <input type="hidden" id="editProductionID" name="production_id">
            <label for="editEmpID">Employee ID:</label>
            <input type="text" id="editEmpID" name="emp_id" value="<%= empID %>" readonly>
            <label for="editProductionDate">Production Date:</label>
            <input type="date" id="editProductionDate" name="production_date" required>
            <label for="editProductionTime">Production Time:</label>
            <select id="editProductionTime" name="production_time" required>
                <option value="morning">Morning</option>
                <option value="evening">Evening</option>
                <option value="night">Night</option>
            </select>
            <label for="editAmount">Amount In (L):</label>
            <input type="number" id="editAmount" name="amount" step="0.01" required>
            <label for="editTotalProduction">Total Production (L):</label>
            <input type="number" id="editTotalProduction" name="total_production" step="0.01">
            <label for="editAmountBalance">Amount Balance (L):</label>
            <input type="number" id="editAmountBalance" name="amount_balance" step="0.01">
            <input type="hidden" name="action" value="edit">
            <div class="form-buttons">
                <button type="submit" class="btn">Submit</button>
                <button type="button" class="btn cancel" onclick="closeForm('editForm')">Close</button>
            </div>
        </form>
    </div>

    <script>
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


    function toggleMenu() {
        var menu = document.getElementById("menuContent");
        menu.style.display = menu.style.display === "block" ? "none" : "block";
    }
    
    function showLogoutModal() {
        document.getElementById("logoutModal").style.display = "block";
    }

    function closeLogoutModal() {
        document.getElementById("logoutModal").style.display = "none";
    }

    function logout() {
        // Redirect to homepage
        window.location.href = "index.jsp";
    }
    
 // Close the menu if clicked outside
    window.onclick = function(event) {
        if (!event.target.matches('.menu-button')) {
            var menu = document.getElementById("menuContent");
            if (menu.style.display === "block") {
                menu.style.display = "none";
            }
        }
    }
 
 // Initialize date-time display and update it every second
    setInterval(updateDateTime, 1000);
    updateDateTime();

    // Add event listener for when the DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Add any initialization code here if needed
    });
        
        function openForm(formId) {
            document.getElementById(formId).style.display = 'block';
        }

        function closeForm(formId) {
            document.getElementById(formId).style.display = 'none';
        }

        function openEditForm(productionID, empID, productionDate, productionTime, amount, totalProduction, amountBalance) {
            document.getElementById('editProductionID').value = productionID;
            document.getElementById('editEmpID').value = empID;
            document.getElementById('editProductionDate').value = productionDate;
            document.getElementById('editProductionTime').value = productionTime;
            document.getElementById('editAmount').value = amount;
            document.getElementById('editTotalProduction').value = totalProduction;
            document.getElementById('editAmountBalance').value = amountBalance;
            document.getElementById('editForm').style.display = 'block';
        }
       </script>
   </body>

   </html>