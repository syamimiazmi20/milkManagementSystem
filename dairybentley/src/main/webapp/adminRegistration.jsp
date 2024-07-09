<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Registration</title>
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
    background-image: url('register.jpeg');
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
    max-width: 600px;
    margin: 20px auto;
    background-color: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

      /* Header Styles */
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
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 80px;
            padding: 20px;
        }

        .welcome-text {
            text-align: center;
            color: white;
            margin-bottom: 20px;
            font-size: 50px;
            font-weight: 30px;
            line-height: 1.6;
            max-width: 600px;
            padding: 20px;
            border-radius: 10px;
        }


        

        .form-container {
    background-color: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(10px);
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    width: 90%;
    max-width: 500px;
    
}

		h1 {
            color: var(--main-green);
            margin-top: 10px;
            text-align: center;
            font-weight: 600;
        }

.form-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    gap: 20px; /* Add gap between form groups within a row */
}

.form-group {
    flex: 1; /* Change from 0 0 48% to 1 to allow flexible growth */
}
.form-group label {
            
            color: var(--main-green);
            font-weight: bold;
            margin-bottom: 5px;
        }
        
.form-group.full-width {
    flex: 0 0 100%;
    margin-bottom: 20px; /* Add margin to the bottom of full-width inputs */
}

.form-group input {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid var(--light-brown);
    border-radius: 8px;
    font-size: 16px;
    transition: border-color 0.3s, box-shadow 0.3s;
    box-sizing: border-box; /* Ensure padding is included in width calculation */
}

        button {
            background-color: var(--main-green);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 20px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.1s;
            width: 100%;
            margin-top: 20px;
        }

        button:hover {
            background-color: #3a5234;
        }

        button:active {
            transform: scale(0.98);
        }

        /* Footer Styles */
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

        .login-link {
            margin-bottom: 30px;
            text-align: center;
            font-size: 14;
    	
}
        }

        .login-link a {
            color: var(--main-green);
            font-weight: 600;
           
        }
        
        

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
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
        <a href="#home">Home</a>
        <a href="#account">View Account</a>
    </div>
</header>

<div class="background-image"></div>

    <div class="main-content">
        
<div class="welcome-text">
           Welcome to DairyBen! 
        </div>
        <div class="form-container">
        
            <h1>Admin Registration</h1>
            <form action="AdminRegistrationServlet" method="post">
            
            
                <div class="form-row">
                    <div class="form-group">
                    	<label for="name">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter your full name" required pattern="[A-Za-z\s]+" title="Name should only contain letters and spaces.">
                    </div>
                    <div class="form-group">
                    	<label for="email">Email</label>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>
                </div>
                <div class="form-group full-width">
                	<label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Enter your address" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                    	<label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required pattern="\d{10}" title="Phone number should be 10 digits.">
                    </div>
                    <div class="form-group">
                    	<label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required minlength="6">
                    </div>
                </div>
                <button type="submit">Register</button>
            </form>
            <div class="login-link">
               <p> Already have an account? <a href="adminLogin.jsp">Log In Here</a></p>
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
        
        
     // header-footer.js

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
    </script>
</body>

</html>