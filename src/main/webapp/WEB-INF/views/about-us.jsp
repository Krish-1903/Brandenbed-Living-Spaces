<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" id="html-root">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Brandenbed Living Spaces - About Us</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {margin:0; padding:0; box-sizing:border-box;}
        body {font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height:1.6; color:#333; background:#f7fafc;}

        /* Header / Navbar */
        .header {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            position: fixed; top:0; width:100%; z-index:1000;
            padding:1rem 0; box-shadow:0 2px 20px rgba(0,0,0,0.1); transition: all 0.3s ease;
        }
        .nav-container {
            max-width:1200px; margin:0 auto; display:flex; justify-content:space-between; align-items:center; padding:0 2rem;
        }
        .logo {font-size:1.8rem; font-weight:bold; color:#2c5282; text-decoration:none; display:flex; align-items:center;}
        .logo i {margin-right:0.5rem; color:#3182ce;}
        .nav-menu {display:flex; list-style:none; align-items:center; gap:2rem;}
        .nav-menu a {text-decoration:none; color:#4a5568; font-weight:500; position:relative; transition: color 0.3s;}
        .nav-menu a:hover {color:#3182ce;}
        .nav-menu a::after {content:''; position:absolute; width:0; height:2px; bottom:-5px; left:0; background:#3182ce; transition: width 0.3s;}
        .nav-menu a:hover::after {width:100%;}
        .sign-in-btn {
            background:linear-gradient(135deg,#3182ce,#2c5282); color:white !important;
            padding:0.7rem 1.5rem; border-radius:25px; transition: all 0.3s;
        }
        .sign-in-btn:hover {transform:translateY(-2px); box-shadow:0 10px 25px rgba(49,130,206,0.3);}
        .language-toggle {
            background:#f7fafc; border:1px solid #e2e8f0; border-radius:20px; padding:0.5rem 1rem; margin-left:1rem; cursor:pointer; transition:0.3s;
        }
        .language-toggle:hover {background:#edf2f7; transform:translateY(-1px);}
        .mobile-menu-toggle {display:none; background:none; border:none; font-size:1.5rem; color:#4a5568; cursor:pointer;}

        /* About Us Section */
        .about-section {padding:8rem 2rem 4rem 2rem; max-width:1200px; margin:0 auto;}
        .about-title {text-align:center; font-size:2.5rem; color:#2d3748; margin-bottom:1rem; font-weight:700;}
        .about-subtitle {text-align:center; color:#718096; font-size:1.2rem; margin-bottom:3rem; max-width:700px; margin-left:auto; margin-right:auto;}
        .about-content {display:grid; grid-template-columns:repeat(auto-fit,minmax(300px,1fr)); gap:2rem; align-items:center;}
        .about-image {width:100%; border-radius:15px; height:250px; object-fit:cover; box-shadow:0 10px 25px rgba(0,0,0,0.1);}
        .about-text p {margin-bottom:1.5rem; color:#4a5568; line-height:1.7; font-size:1rem;}

        /* Footer */
        .footer {background:linear-gradient(135deg,#2d3748,#1a202c); color:white; padding:3rem 0 1rem;}
        .footer-content {max-width:1200px; margin:0 auto; padding:0 2rem; display:grid; grid-template-columns:repeat(auto-fit,minmax(250px,1fr)); gap:2rem;}
        .footer-section h3 {color:#3182ce; margin-bottom:1rem; font-size:1.3rem;}
        .footer-section p, .footer-section a {color:#a0aec0; text-decoration:none; margin-bottom:0.5rem; display:block; transition:color 0.3s;}
        .footer-section a:hover {color:#3182ce;}
        .social-links {display:flex; gap:1rem; margin-top:1rem;}
        .social-links a {display:inline-flex; align-items:center; justify-content:center; width:40px; height:40px; background:#3182ce; border-radius:50%; color:white; transition:all 0.3s;}
        .social-links a:hover {background:#2c5282; transform:translateY(-3px);}
        .footer-bottom {border-top:1px solid #4a5568; margin-top:2rem; padding-top:1rem; text-align:center; color:#718096;}

        @media(max-width:768px){
            .mobile-menu-toggle{display:block;}
            .nav-menu{display:none; position:absolute; top:100%; left:0; width:100%; background:white; flex-direction:column; padding:1rem; gap:1rem; box-shadow:0 5px 20px rgba(0,0,0,0.1);}
            .nav-menu.active{display:flex;}
        }
        @media(max-width:480px){ .nav-container{padding:0 1rem;} }
    </style>
</head>
<body>

<!-- Header / Navbar -->
<header class="header">
    <nav class="nav-container">
        <a href="#" class="logo"><i class="fas fa-building"></i>Brandenbed Living Spaces</a>
        <ul class="nav-menu" id="navMenu">
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/properties">Properties</a></li>
            <li><a href="${pageContext.request.contextPath}/aboutUs">About Us</a></li>
            <li><a href="#services">Services</a></li>
            <li><a href="#contact">Contact</a></li>
            <li><a href="${pageContext.request.contextPath}/signIn" class="sign-in-btn">Sign In</a></li>
        </ul>
        <button class="mobile-menu-toggle" onclick="toggleMobileMenu()"><i class="fas fa-bars"></i></button>
    </nav>
</header>

<!-- About Us Section -->
<section class="about-section" id="about">
    <h2 class="about-title">About Brandenbed Living Spaces</h2>
    <p class="about-subtitle">Providing premium real estate solutions across Berlin with commitment and excellence.</p>
    <div class="about-content">
        <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=800&auto=format&fit=crop" alt="Modern Building" class="about-image">
        <div class="about-text">
            <p>Brandenbed Living Spaces has been delivering top-quality residential and commercial properties in Berlin for over a decade. Our focus is on creating exceptional living experiences for our clients with transparency and trust.</p>
            <p>Our dedicated team works tirelessly to ensure every property meets the highest standards, combining innovative design, prime locations, and outstanding service. We pride ourselves on long-lasting relationships with our clients and partners.</p>
            <img src="https://images.unsplash.com/photo-1560448071-4b1b8b3ef1bb?q=80&w=800&auto=format&fit=crop" alt="Teamwork" class="about-image" style="margin-top:1rem;">
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer" id="contact">
    <div class="footer-content">
        <div class="footer-section">
            <h3>Contact Information</h3>
            <p><i class="fas fa-map-marker-alt"></i> Friedrichstraße 155, 10117 Berlin</p>
            <p><i class="fas fa-phone"></i> +49 30 1234567</p>
            <p><i class="fas fa-envelope"></i> info@brandenbed.com</p>
        </div>
        <div class="footer-section">
            <h3>Quick Links</h3>
            <a href="#properties">Properties</a>
            <a href="#about">About Us</a>
            <a href="#services">Services</a>
            <a href="#contact">Contact</a>
        </div>
        <div class="footer-section">
            <h3>Follow Us</h3>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">© 2025 Brandenbed Living Spaces. All Rights Reserved.</div>
</footer>

<script>
    function toggleMobileMenu() {
        document.getElementById('navMenu').classList.toggle('active');
    }
</script>

</body>
</html>
