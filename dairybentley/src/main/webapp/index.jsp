<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dairy Ben - Farm Fresh Milk</title>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&family=Playfair+Display:wght@700&display=swap');
    
    :root {
    --primary-color: #4a6741; /* Green */
    --secondary-color: #8b4513; /* Brown */
    --text-color: #444; /* Slightly lighter text color */
    --background-color: #f5f5f5;
}

	body {
    font-family: 'Montserrat', Arial, sans-serif;
    font-size: 16px;
    line-height: 1.6;
    font-weight: 400;
    margin: 0;
    padding: 0;
    background-color: var(--background-color);
    color: var(--text-color);
}

	h1, h2, h3 {
    font-family: 'Playfair Display', serif;
    font-weight: 700;
}

	h1 {
    font-size: 3rem;
    color: white	;
}

	h2 {
    font-size: 2.5rem;
}

	h3 {
    font-size: 1.8rem;
}

	header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    background-color: var(--primary-color);
    color: white;
}

	.logo-container {
    display: flex;
    align-items: center;
    text-align:left;
}

	.logo img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    border: 3px solid #4a6741; /* Green border */
    object-fit: cover;
}

	.company-name {
    margin-left: 1rem;
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    font-weight: 700;
    text-align:left;
}

	nav {
    flex-grow: 1;
    display: flex;
    justify-content: center;
}

nav ul {
    display: flex;
    list-style-type: none;
    margin: 0;
    padding: 0;
    justify-content: center; /* Center the items horizontally */
}

nav ul li {
    margin: 0 1rem;
}

nav ul li a {
    color: white;
    text-decoration: none;
    font-family: 'Montserrat', sans-serif;
    font-size: 1rem;
    font-weight: 400;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: color 0.3s ease;
}

nav ul li a:hover {
    color: #f0f0f0;
}

.hero {
    text-align: center;
    padding: 17rem 2rem;
    background-image: url('test.jpeg');
    background-size: cover;
    background-position: center;
    color: #fff; /* White text color for better contrast */
}

.hero h1 {
    font-size: 4rem;
    margin-bottom: 1rem;
}

.hero p {
    font-weight: 500;
    font-size: 1.3rem;
}

 .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        .transparent-btn {
            padding: 0.8rem 2rem;
            font-size: 1rem;
            cursor: pointer;
            border: 2px solid white;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            transition: background-color 0.3s;
            text-decoration: none; /* Remove underline */
            display: inline-block; /* Ensure block-level styling */
        }

        .transparent-btn:hover {
            background-color: black; /* Brown transparent */
        }
.employees {
    padding: 2rem;
    background-color: white;
}

.employee-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
}

.employee {
    text-align: center;
    cursor: pointer;
}

.employee img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
}

.employee-popup {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.7);
    justify-content: center;
    align-items: center;
}

.popup-content {
    background-color: white;
    padding: 2rem;
    border-radius: 10px;
    text-align: center;
    position: relative;
}

.close-popup {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 1.5rem;
    cursor: pointer;
}

#popupImage {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 1rem;
}

.about {
    padding: 4rem 2rem;
    background-color: #f9f5f2;
}

.about-content {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    align-items: center;
}

.about-text {
    flex: 1;
    padding-right: 2rem;
}

.about-text h2 {
    font-size: 2.5rem;
    margin-bottom: 1rem;
    color: #333;
}

.about-text p {
    margin-bottom: 2rem;
    color: #666;
    line-height: 1.6;
}

.about-btn {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    background-color: #8b4513;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.about-btn:hover {
    background-color: #6b3309;
}

.about-image {
    flex: 1;
}

.about-image img {
    width: 100%;
    border-radius: 10px;
}

footer {
    background-color: var(--primary-color);
    color: white;
    padding: 2rem 0;
     font-family: 'freight-big-pro';
    
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
	header {
        flex-direction: column;
        align-items: center;
    }

    .logo-container {
        margin-bottom: 1rem;
    }

    nav {
        margin-top: 1rem;
        width: 100%; /* Ensure full width on mobile */
    }

    nav ul {
        justify-content: center; /* Center items on mobile */
    }


 	.about-content {
        flex-direction: column;
    }
    
    .about-text {
        padding-right: 0;
        margin-bottom: 2rem;
    }
    .employee-grid {
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    }
    
    .footer-content {
        flex-direction: column;
    }
    
}
</style>
</head>
<body>
   <header>
    <div class="logo-container">
        <div class="logo">
            <img src="logo.jpeg" alt="Dairy Ben Logo">
        </div>
        <div class="company-name">DairyBen</div>
    </div>
    <nav>
        <ul>
            <li><a href="#home">Home</a></li>
            <li><a href="#employees">Our Team</a></li>
            <li><a href="#about">About Us</a></li>
        </ul>
    </nav>
</header>

    <section id="home" class="hero">
        <h1>Butterfly Agro Farm</h1>
        <p>Organic Dairy House</p>
        <div class="hero-buttons">
    <a href="employeeLogin.jsp" class="transparent-btn staff-btn">Staff</a>
    <a href="customerRegistration.jsp" class="transparent-btn customer-btn">Customer</a>
    <a href="adminLogin.jsp" class="transparent-btn admin-btn">Admin</a>
</div>

    </section>

    <section id="employees" class="employees">
        <h2>Meet Our Team</h2>
        <div class="employee-grid">
            <div class="employee" data-employee="1">
                <img src="balqis.jpeg" alt="Firha">
                <h3>Siti Firha Balqis</h3>
                <p>Programmer</p>
            </div>
            <div class="employee" data-employee="2">
                <img src="nadia.png" alt="Natasha">
                <h3>Nurin Nadia</h3>
                <p>Docummenter</p>
            </div>
            <div class="employee" data-employee="3">
                <img src="nik.jpeg" alt="Siti">
                <h3>Nik Natasha</h3>
                <p>Programmer</p>
            </div>
            <div class="employee" data-employee="4">
                <img src="zam.png" alt="Balqis">
                <h3>Zamharirah</h3>
                <p>Tester</p>
            </div>
            <div class="employee" data-employee="5">
                <img src="mimi.png" alt="Nik">
                <h3>Nurul Syamimi</h3>
                <p>Docummenter</p>
            </div>
           
        </div>
    </section>

    

    <section id="about" class="about">
    <div class="about-content">
        <div class="about-text">
            <h2>About Us</h2>
            <p>Dairy Ben provides fresh, organic milk straight from our farm to your table. We pride ourselves on maintaining high standards of animal welfare and sustainable farming practices. Our team of dedicated professionals ensures that every drop of milk you receive is of the highest quality.</p>
            <a href="#home" class="about-btn">LET'S GO</a>
        </div>
        <div class="about-image">
            <img src="image1.jpeg" alt="Fresh Milk">
        </div>
    </div>
</section>

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
    document.addEventListener('DOMContentLoaded', function() {
        const sections = document.querySelectorAll('section');
        const navLinks = document.querySelectorAll('nav ul li a');
        
        const options = {
            threshold: 0.5
        };
        
        const observer = new IntersectionObserver(function(entries, observer) {
            entries.forEach(entry => {
                if (!entry.isIntersecting) {
                    return;
                }
                entry.target.classList.add('show');
                observer.unobserve(entry.target);
            });
        }, options);
        
        sections.forEach(section => {
            observer.observe(section);
        });

        // Smooth scrolling for navigation links
        navLinks.forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const targetId = this.getAttribute('href').substring(1);
                const targetSection = document.getElementById(targetId);
                
                window.scrollTo({
                    top: targetSection.offsetTop,
                    behavior: 'smooth'
                });
            });
        });

        

        closePopup.addEventListener('click', () => {
            popup.style.display = 'none';
        });
    });
</script>


</body>
</html>
