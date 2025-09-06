<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" id="html-root">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Brandenbed Living Spaces - Premium Real Estate in Berlin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; color: #333;}

        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            position: fixed; top: 0; width: 100%; z-index: 1000;
            padding: 1rem 0; box-shadow: 0 2px 20px rgba(0,0,0,0.1); transition: all 0.3s ease;
        }
        .nav-container {max-width: 1200px; margin:0 auto; display:flex; justify-content:space-between; align-items:center; padding:0 2rem;}
        .logo {font-size:1.8rem; font-weight:bold; color:#2c5282; text-decoration:none; display:flex; align-items:center;}
        .logo i {margin-right:0.5rem; color:#3182ce;}
        .nav-menu {display:flex; list-style:none; align-items:center; gap:2rem;}
        .nav-menu a {text-decoration:none; color:#4a5568; font-weight:500; position:relative; transition: color 0.3s;}
        .nav-menu a:hover {color:#3182ce;}
        .nav-menu a::after {content:''; position:absolute; width:0; height:2px; bottom:-5px; left:0; background:#3182ce; transition: width 0.3s;}
        .nav-menu a:hover::after {width:100%;}
        .sign-in-btn {background:linear-gradient(135deg,#3182ce,#2c5282); color:white !important; padding:0.7rem 1.5rem; border-radius:25px; transition: all 0.3s;}
        .sign-in-btn:hover {transform:translateY(-2px); box-shadow:0 10px 25px rgba(49,130,206,0.3);}
        .language-toggle {background:#f7fafc; border:1px solid #e2e8f0; border-radius:20px; padding:0.5rem 1rem; margin-left:1rem; cursor:pointer; transition:0.3s;}
        .language-toggle:hover {background:#edf2f7; transform:translateY(-1px);}
        .mobile-menu-toggle {display:none; background:none; border:none; font-size:1.5rem; color:#4a5568; cursor:pointer;}

        /* Hero */
        .hero {
            background: url('https://images.unsplash.com/photo-1646987916641-1f3c8992daa2?q=80&w=2606&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center/cover;
            height: 100vh; display:flex; align-items:center; justify-content:center; text-align:center; color:white; position:relative;
        }
        .hero-content {max-width:800px; padding:0 2rem; animation: fadeInUp 1s ease-out;}
        .hero h1 {font-size:3.5rem; font-weight:700; margin-bottom:1rem; color:#fff; text-shadow:0 4px 12px rgba(0,0,0,0.6);}
        .hero p {font-size:1.3rem; margin-bottom:2rem; color:#f0f0f0; text-shadow:0 2px 6px rgba(0,0,0,0.5);}
        .cta-button {background:linear-gradient(135deg,#38a169,#2f855a); color:white; padding:1rem 2.5rem; border:none; border-radius:50px; font-size:1.1rem; font-weight:600; cursor:pointer; transition: all 0.3s; text-transform:uppercase; letter-spacing:1px;}
        .cta-button:hover {transform:translateY(-3px); box-shadow:0 15px 35px rgba(56,161,105,0.4);}

        /* Stats */
        .stats {padding:4rem 0; background:linear-gradient(135deg,#f7fafc,#edf2f7);}
        .stats-container {max-width:1200px; margin:0 auto; padding:0 2rem; display:grid; grid-template-columns:repeat(auto-fit,minmax(250px,1fr)); gap:2rem;}
        .stat-card {background:white; padding:2rem; border-radius:15px; text-align:center; box-shadow:0 10px 30px rgba(0,0,0,0.1); transition: transform 0.3s, box-shadow 0.3s;}
        .stat-card:hover {transform:translateY(-10px); box-shadow:0 20px 40px rgba(0,0,0,0.15);}
        .stat-number {font-size:3rem; font-weight:bold; color:#3182ce; margin-bottom:0.5rem;}
        .stat-label {color:#4a5568; font-weight:500; font-size:1.1rem;}

        /* Core Values */
        .values {padding:5rem 0; background:white;}
        .section-title {text-align:center; font-size:2.5rem; color:#2d3748; margin-bottom:1rem; font-weight:700;}
        .section-subtitle {text-align:center; color:#718096; font-size:1.2rem; margin-bottom:3rem; max-width:600px; margin:auto;}
        .values-container {max-width:1200px; margin:0 auto; padding:0 2rem; display:grid; grid-template-columns:repeat(auto-fit,minmax(300px,1fr)); gap:2rem;}
        .value-card {padding:2rem; border-radius:15px; text-align:center; transition:all 0.3s; border:2px solid transparent;}
        .value-card:hover {border-color:#3182ce; transform:translateY(-5px); box-shadow:0 15px 35px rgba(49,130,206,0.1);}
        .value-icon {font-size:3rem; color:#3182ce; margin-bottom:1rem;}
        .value-title {font-size:1.5rem; color:#2d3748; margin-bottom:1rem; font-weight:600;}
        .value-description {color:#4a5568; line-height:1.7;}

        /* Services */
        .services {padding:5rem 2rem; background:linear-gradient(135deg,#f7fafc,#edf2f7);}
		/* Services */
		.services-container {
		    max-width: 1200px;
		    margin: 0 auto;
		    display: flex;           /* use flex for horizontal layout */
		    gap: 1.5rem;
		    flex-wrap: wrap;         /* wrap to next line if screen is too small */
		    justify-content: space-between; /* space between cards */
		}
		.service-card {
		    flex: 1 1 22%;           /* each card takes ~22% width, adjusts automatically */
		    background: white;
		    padding: 2rem;
		    border-radius: 20px;
		    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
		    border-left: 5px solid #3182ce;
		    display: flex;
		    flex-direction: column;
		    transition: all 0.3s;
		}
        .service-card:hover {transform:translateY(-8px); box-shadow:0 20px 50px rgba(0,0,0,0.15);}
        .service-icon {font-size:2.5rem; color:#3182ce; margin-bottom:1rem;}
        .service-title {font-size:1.4rem; color:#2d3748; margin-bottom:1rem; font-weight:600;}
        .service-description {color:#4a5568; line-height:1.7; margin-bottom:1rem; flex-grow:1;}
        .service-features {list-style:none; padding:0;}
        .service-features li {color:#4a5568; margin-bottom:0.5rem; padding-left:1.5rem; position:relative; font-size:0.95rem;}
        .service-features li::before {content:'✓'; position:absolute; left:0; color:#38a169; font-weight:bold;}

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

        @keyframes fadeInUp {from {opacity:0; transform:translateY(50px);} to {opacity:1; transform:translateY(0);}}

        /* Responsive */
        @media(max-width:768px){.mobile-menu-toggle{display:block;}.nav-menu{display:none; position:absolute; top:100%; left:0; width:100%; background:white; flex-direction:column; padding:1rem; gap:1rem; box-shadow:0 5px 20px rgba(0,0,0,0.1);}.nav-menu.active{display:flex;}}
        @media(max-width:768px){.hero h1{font-size:2.5rem;}.hero p{font-size:1.1rem;}.stats-container{grid-template-columns:repeat(auto-fit,minmax(200px,1fr));}.values-container{grid-template-columns:1fr;}.services-container{grid-template-columns:repeat(2,1fr);}.footer-content{grid-template-columns:1fr;text-align:center;}}
        @media(max-width:480px){.nav-container{padding:0 1rem;}.hero-content{padding:0 1rem;}.hero h1{font-size:2rem;}.cta-button{padding:0.8rem 2rem; font-size:1rem;}.services-container{grid-template-columns:1fr;}}
    </style>
</head>
<body>

<!-- Header -->
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
            
    </nav>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Premium Living Spaces in Berlin</h1>
        <p>Discover exceptional properties and experience luxury living in Germany's capital. Your dream home awaits with Brandenbed Living Spaces.</p>
        <button class="cta-button" onclick="scrollToSection('services')">Explore Services</button>
    </div>
</section>

<!-- Stats Section -->
<section class="stats">
    <div class="stats-container">
        <div class="stat-card"><div class="stat-number">500+</div><div class="stat-label">Properties Sold</div></div>
        <div class="stat-card"><div class="stat-number">1200+</div><div class="stat-label">Happy Clients</div></div>
        <div class="stat-card"><div class="stat-number">18+</div><div class="stat-label">Years Experience</div></div>
        <div class="stat-card"><div class="stat-number">8+</div><div class="stat-label">Districts in Berlin</div></div>
    </div>
</section>

<!-- Core Values Section -->
<section class="values" id="about">
    <h2 class="section-title">Our Core Values</h2>
    <p class="section-subtitle">Built on trust, excellence, and unwavering commitment to our clients</p>
    <div class="values-container">
        <div class="value-card"><i class="fas fa-shield-alt value-icon"></i><h3 class="value-title">Trust & Integrity</h3><p class="value-description">We build lasting relationships through honest communication and transparent dealings with every client.</p></div>
        <div class="value-card"><i class="fas fa-star value-icon"></i><h3 class="value-title">Excellence</h3><p class="value-description">We strive for perfection in every property we offer and every service we provide to exceed expectations.</p></div>
        <div class="value-card"><i class="fas fa-users value-icon"></i><h3 class="value-title">Client-Focused</h3><p class="value-description">Your needs are our priority. We customize our approach to match your unique requirements and preferences.</p></div>
        <div class="value-card"><i class="fas fa-lightbulb value-icon"></i><h3 class="value-title">Innovation</h3><p class="value-description">We embrace cutting-edge technology and modern solutions to enhance your property experience.</p></div>
        <div class="value-card"><i class="fas fa-handshake value-icon"></i><h3 class="value-title">Partnership</h3><p class="value-description">We work alongside you as partners in your real estate journey, providing support every step of the way.</p></div>
        <div class="value-card"><i class="fas fa-map-marker-alt value-icon"></i><h3 class="value-title">Local Expertise</h3><p class="value-description">Deep knowledge of Berlin's neighborhoods helps us match you with the perfect location for your lifestyle.</p></div>
    </div>
</section>

<!-- Services Section -->
<section class="services" id="services">
    <h2 class="section-title">Our Services</h2>
    <p class="section-subtitle">Comprehensive real estate solutions tailored to your needs</p>
    <div class="services-container">
        <div class="service-card">
            <i class="fas fa-home service-icon"></i>
            <h3 class="service-title">Property Sales</h3>
            <p class="service-description">Find your perfect home with our extensive portfolio of premium properties across Berlin's most desirable neighborhoods.</p>
            <ul class="service-features"><li>Personalized property search</li><li>Market analysis and pricing</li><li>Negotiation support</li><li>Legal documentation assistance</li></ul>
        </div>
        <div class="service-card">
            <i class="fas fa-key service-icon"></i>
            <h3 class="service-title">Rental Services</h3>
            <p class="service-description">Comprehensive rental solutions for both tenants seeking quality homes and landlords looking for reliable property management.</p>
            <ul class="service-features"><li>Tenant screening and placement</li><li>Rent collection management</li><li>Property maintenance coordination</li><li>Lease agreement handling</li></ul>
        </div>
        <div class="service-card">
            <i class="fas fa-chart-line service-icon"></i>
            <h3 class="service-title">Investment Consulting</h3>
            <p class="service-description">Expert guidance for real estate investments with detailed market insights and strategic planning for maximum returns.</p>
            <ul class="service-features"><li>Market trend analysis</li><li>ROI calculations</li><li>Portfolio optimization</li><li>Risk assessment</li></ul>
        </div>
        <div class="service-card">
            <i class="fas fa-tools service-icon"></i>
            <h3 class="service-title">Property Management</h3>
            <p class="service-description">Full-service property management to maximize your investment value while ensuring tenant satisfaction and property maintenance.</p>
            <ul class="service-features"><li>24/7 maintenance support</li><li>Tenant relationship management</li><li>Financial reporting</li><li>Property inspections</li></ul>
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

    function scrollToSection(id) {
        document.getElementById(id).scrollIntoView({behavior:'smooth'});
    }

    function toggleLanguage() {
        let currentLang = document.getElementById('currentLang');
        let alternateLang = document.getElementById('alternateLang');
        [currentLang.textContent, alternateLang.textContent] = [alternateLang.textContent, currentLang.textContent];
    }
</script>

</body>
</html>
