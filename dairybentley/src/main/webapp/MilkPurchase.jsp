<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Milk Purchase</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap">
    <style>
        :root {
            --main-green: #4a6741;
            --light-brown: #D2B48C;
            --dark-brown: #8B4513;
        }

        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }

        .background-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('register.jpeg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            filter: brightness(70%);
            z-index: -1;
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

        .container {
            display: flex;
            flex-direction: column;
            max-width: 1200px;
            margin: 20px auto;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

		.sections-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        
        
        .section {
            
            flex: 1;
            background-color: #f9f9f9;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            margin-right: 1rem;

        }

        .section:last-child {
            margin-right: 0;
        }

        h1 {
            text-align: center;
            color: var(--main-green);
        }

        h2 {
            color: var(--main-green);
            font-size: 1.2rem;
            margin-bottom: 1rem;
            border-bottom: 2px solid var(--light-brown);
            padding-bottom: 0.5rem;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: var(--main-green);
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea {
            width: 85%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid var(--light-brown);
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: var(--main-green);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            background-color: #3a5234;
        }

        footer {
            background-color: var(--main-green);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
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
            .sections-row {
                flex-direction: column;
            }
            .section {
                margin-right: 0;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>

<body>
    <%
        int custID = (int)session.getAttribute("userID");
        String custName = (String)session.getAttribute("userName");
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
            
            <a href="viewCustomerProfile.jsp">View Account</a>
            <a href="index.jsp">Log Out</a>
        </div>
    </header>

    <div class="background-image"></div>

     <div class="container">
        <h1>Milk Purchase</h1>
        <form action="PurchaseServlet?action=addPayment" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="cust_id" value="<%= custID %>">
            <input type="hidden" name="production_id" value="${milkProduction.productionId}">

            <div class="sections-row">
                <div class="section">
                    <h2>Customer Information</h2>
                    <h3>Customer name: <%= custName %></h3>
                    <label for="customerId">Customer ID: <%= custID %></label>
                </div>

                <div class="section">
                    <h2>Milk Purchase</h2>
                    <label for="availability">Availability: (liters left)</label>
                    <input type="text" id="availability" name="availability" value="${milkProduction.amountBalance}" readonly>

                    <label for="amountPurchase">Amount Purchase (liters):</label>
                    <input type="number" id="amountPurchase" name="amountPurchase" min="0" step="0.1" required>

                    <label id="pricePerLiter">Price per Liter: RM 3.00</label>

                    <label for="totalPrice">Total Price:</label>
                    <input type="number" id="totalPrice" name="totalPrice" readonly>
                </div>

                <div class="section">
                    <h2>Shipping Method</h2>
                    <label for="delivery">
                        <input type="radio" id="delivery" name="shipping_type" value="delivery" onclick="showDeliveryFields()" checked>
                        Delivery
                    </label>
                    <label for="pickup">
                        <input type="radio" id="pickup" name="shipping_type" value="pickup" onclick="showPickupFields()">
                        Pickup
                    </label>
                    <label for="con_phone">Contact number:</label>
                    <input type="text" id="con_phone" name="con_phone">
                </div>
            </div>

            <div id="deliveryFields">
                <h3>Delivery Information</h3>
                <label for="receiver_name">Receiver name:</label>
                <input type="text" id="receiver_name" name="receiver_name">
                <label for="send_address">Send address:</label>
                <textarea id="send_address" name="send_address"></textarea>
            </div>

            <div id="pickupFields" style="display: none;">
                <h3>Pickup Information</h3>
                <label for="pickup_date">Pickup Date:</label>
                <input type="date" id="pickup_date" name="pickup_date">
                <label for="pickup_session">Available Pickup Time:</label>
                <select id="pickup_session" name="pickup_session">
                    <option value="morning">Morning (8am-12pm)</option>
                    <option value="evening">Evening (2pm-6pm)</option>
                </select>
            </div>

            <div class="section">
                <h2>Payment</h2>
                <div id="paymentDetails">
                    <h3>Total Price: RM <span id="displayTotalPrice">0.00</span></h3>
                </div>
                <input type="hidden" name="total_price" id="hiddenTotalPrice">
                <label for="payment_type">Choose Payment Method:</label>
                <select id="payment_type" name="payment_type" onchange="togglePaymentOptions()">
                    <option value="qr">QR Pay</option>
                    <option value="onlinetransfer">Online Transfer</option>
                </select>
                <div id="qrOptions" class="qrOptions">
                    <h3>QR Pay</h3>
                    <img id="qrCode" src="qr_code.png" alt="QR Code" style="max-width: 100px;">
                    <p>Scan this QR to make a payment</p>
                </div>
                <div id="onlinetransferOptions" class="onlinetransferOptions" style="display: none;">
                    <h3>Online Transfer</h3>
                    <p>Account Number: 1234567890</p>
                    <p>Bank: Maybank</p>
                    <p>Name: Butterfly Agro Farm</p>
                </div>
            </div>

            <input type="hidden" name="payment_date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            <input type="submit" value="Submit Purchase">
        </form>
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
                    <li><a href="#home">Home</a></li>
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

    <script>
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

        window.onclick = function(event) {
            if (!event.target.matches('.menu-button')) {
                var menu = document.getElementById("menuContent");
                if (menu.style.display === "block") {
                    menu.style.display = "none";
                }
            }
        }

        setInterval(updateDateTime, 1000);
        updateDateTime();

        document.getElementById('amountPurchase').addEventListener('input', calculateTotal);

        function calculateTotal() {
            const amount = parseFloat(document.getElementById('amountPurchase').value) || 0;
            const total = amount * 3.00;
            document.getElementById('totalPrice').value = total.toFixed(2);
            document.getElementById('displayTotalPrice').innerText = total.toFixed(2);
            document.getElementById('hiddenTotalPrice').value = total.toFixed(2);
        }

        function showDeliveryFields() {
            document.getElementById("deliveryFields").style.display = "block";
            document.getElementById("pickupFields").style.display = "none";
        }

        function showPickupFields() {
            document.getElementById("deliveryFields").style.display = "none";
            document.getElementById("pickupFields").style.display = "block";
        }

        function validateForm() {
            var shippingType = document.querySelector('input[name="shipping_type"]:checked').value;

            if (shippingType === "delivery") {
                var receiver_name = document.getElementById("receiver_name").value.trim();
                var address = document.getElementById("send_address").value.trim();
                if (receiver_name === "" || address === "") {
                    alert("Please fill in all the delivery information.");
                    return false;
                }
            } else if (shippingType === "pickup") {
                var pickup_date = document.getElementById("pickup_date").value.trim();
                var pickup_session = document.getElementById("pickup_session").value.trim();
                if (pickup_date === "" || pickup_session === "") {
                    alert("Please fill in all the pickup information.");
                    return false
                        }
            }
            return true;
          }
          
       // Function to toggle payment options based on selection
          function togglePaymentOptions() {
            var payment_type = document.getElementById("payment_type").value;
            var qrOptions = document.getElementById("qrOptions");
            var onlinetransferOptions = document.getElementById("onlinetransferOptions");

            if (payment_type === "qr") {
              qrOptions.style.display = "block";
              onlinetransferOptions.style.display = "none";
            } else if (payment_type === "onlinetransfer") {
              qrOptions.style.display = "none";
              onlinetransferOptions.style.display = "block";
            }
          }
    </script>
   </body>
</html>