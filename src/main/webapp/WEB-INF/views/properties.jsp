<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.brandenbed.entity.Property"%>
<!DOCTYPE html>
<html lang="en" id="html-root">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Brandenbed Living Spaces - Properties</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height:1.6; color:#333; background:#f7fafc; }

        /* Header (same as homepage) */
        .header {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            position: fixed; top:0; width:100%; z-index:1000;
            padding: 1rem 0; box-shadow:0 2px 20px rgba(0,0,0,0.1); transition: all 0.3s ease;
        }
        .nav-container {
            max-width:1200px; margin:0 auto;
            display:flex; justify-content:space-between; align-items:center;
            padding:0 2rem;
        }
        .logo {
            font-size:1.8rem; font-weight:bold; color:#2c5282; text-decoration:none; display:flex; align-items:center;
        }
        .logo i { margin-right:0.5rem; color:#3182ce; }
        .nav-menu {
            display:flex; list-style:none; align-items:center; gap:2rem;
        }
        .nav-menu a {
            text-decoration:none; color:#4a5568; font-weight:500; position:relative; transition: color 0.3s; font-size:1rem;
        }
        .nav-menu a:hover { color:#3182ce; }
        .nav-menu a::after { content:''; position:absolute; width:0; height:2px; bottom:-5px; left:0; background:#3182ce; transition: width 0.3s; }
        .nav-menu a:hover::after { width:100%; }
        .sign-in-btn {
            background:linear-gradient(135deg,#3182ce,#2c5282); color:white !important;
            padding:0.7rem 1.5rem; border-radius:25px; transition:all 0.3s;
        }
        .sign-in-btn:hover { transform:translateY(-2px); box-shadow:0 10px 25px rgba(49,130,206,0.3); }
        .mobile-menu-toggle { display:none; background:none; border:none; font-size:1.5rem; color:#4a5568; cursor:pointer; }

        /* Properties Section */
        .properties-section { padding:6rem 2rem 2rem 2rem; min-height:100vh; }
        .section-title { text-align:center; font-size:2.5rem; color:#2d3748; margin-bottom:0.5rem; font-weight:700; }
        .section-subtitle { text-align:center; color:#718096; font-size:1.2rem; margin-bottom:3rem; max-width:600px; margin-left:auto; margin-right:auto; }

        .search-filter { text-align:center; margin-bottom:2rem; }
        .search-filter input, .search-filter select { padding:0.5rem 1rem; border-radius:8px; border:1px solid #ccc; margin-right:0.5rem; }
        .search-filter button { padding:0.5rem 1rem; border:none; background:#3182ce; color:white; border-radius:8px; cursor:pointer; }

        .properties-container { display:grid; grid-template-columns:repeat(auto-fit,minmax(300px,1fr)); gap:2rem; max-width:1200px; margin:0 auto; }
        .property-card { background:white; border-radius:15px; overflow:hidden; box-shadow:0 15px 35px rgba(0,0,0,0.08); transition:all 0.3s ease; border-left:5px solid #3182ce; position:relative; }
        .property-card:hover { transform:translateY(-5px); box-shadow:0 25px 50px rgba(0,0,0,0.15); }
        .property-img { width:100%; height:200px; object-fit:cover; }
        .property-content { padding:1.5rem; }
        .property-title { font-size:1.4rem; color:#2d3748; font-weight:600; margin-bottom:0.5rem; }
        .property-location { color:#718096; font-size:0.95rem; margin-bottom:1rem; }
        .property-price { font-size:1.2rem; font-weight:700; color:#3182ce; margin-bottom:1rem; }
        .property-features { list-style:none; display:flex; flex-wrap:wrap; gap:0.5rem; margin-bottom:1rem; }
        .property-features li { background:#edf2f7; padding:0.3rem 0.7rem; border-radius:12px; font-size:0.85rem; color:#4a5568; }

        .status-badge { position:absolute; top:15px; right:15px; padding:0.3rem 0.8rem; border-radius:15px; color:white; font-weight:600; font-size:0.85rem; text-transform:uppercase; }
        .Available { background:#38a169; }   /* Green */
        .Rented { background:#e53e3e; }      /* Red */
        .Sold { background:#d69e2e; }        /* Yellow */
        .Maintenance { background:#ed8936; } /* Orange */

        /* Footer (same as homepage) */
        .footer { background: linear-gradient(135deg,#2d3748,#1a202c); color:white; padding:3rem 0 1rem; }
        .footer-content { max-width:1200px; margin:0 auto; padding:0 2rem; display:grid; grid-template-columns:repeat(auto-fit,minmax(250px,1fr)); gap:2rem; }
        .footer-section h3 { color:#3182ce; margin-bottom:1rem; font-size:1.3rem; }
        .footer-section p, .footer-section a { color:#a0aec0; text-decoration:none; margin-bottom:0.5rem; display:block; transition:color 0.3s; }
        .footer-section a:hover { color:#3182ce; }
        .social-links { display:flex; gap:1rem; margin-top:1rem; }
        .social-links a { display:inline-flex; align-items:center; justify-content:center; width:40px; height:40px; background:#3182ce; border-radius:50%; color:white; transition:all 0.3s; }
        .social-links a:hover { background:#2c5282; transform:translateY(-3px); }
        .footer-bottom { border-top:1px solid #4a5568; margin-top:2rem; padding-top:1rem; text-align:center; color:#718096; }

        @media(max-width:768px){
            .mobile-menu-toggle{display:block;}
            .nav-menu{display:none; position:absolute; top:100%; left:0; width:100%; background:white; flex-direction:column; padding:1rem; gap:1rem; box-shadow:0 5px 20px rgba(0,0,0,0.1);}
            .nav-menu.active{display:flex;}
        }
        @media(max-width:480px){ .nav-container{padding:0 1rem;} }
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
            </ul>
            <button class="mobile-menu-toggle" onclick="toggleMobileMenu()"><i class="fas fa-bars"></i></button>
        </nav>
    </header>

    <!-- Properties Section -->
    <section class="properties-section" id="properties">
        <h2 class="section-title">Our Properties</h2>
        <p class="section-subtitle">Explore premium living spaces available across Berlin</p>

        <!-- Search & Filter -->
        <div class="search-filter">
            <form method="get" action="<%= request.getContextPath() %>/filter">
                <input type="text" name="name" placeholder="Search by name or location" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>">
                <select name="status">
                    <option value="All" <%= ("All".equals(request.getAttribute("status"))) ? "selected" : "" %>>All Status</option>
                    <option value="Available" <%= ("Available".equals(request.getAttribute("status"))) ? "selected" : "" %>>Available</option>
                    <option value="Rented" <%= ("Rented".equals(request.getAttribute("status"))) ? "selected" : "" %>>Rented</option>
                    <option value="Sold" <%= ("Sold".equals(request.getAttribute("status"))) ? "selected" : "" %>>Sold</option>
                    <option value="Maintenance" <%= ("Maintenance".equals(request.getAttribute("status"))) ? "selected" : "" %>>Maintenance</option>
                </select>
                <button type="submit">Filter</button>
            </form>
        </div>

        <div class="properties-container">
            <%
                List<Property> properties = (List<Property>) request.getAttribute("properties");
                if (properties != null && !properties.isEmpty()) {
                    for (Property property : properties) {
            %>
            <div class="property-card">
                <span class="status-badge <%= property.getStatus() %>"><%= property.getStatus() %></span>
				<img src="<%= request.getContextPath() + (property.getImagePath() != null ? property.getImagePath() : "/images/default.jpg") %>"
				     alt="<%= property.getName() %>" />


                    <h3 class="property-title"><%= property.getName() %></h3>
                    <p class="property-location"><i class="fas fa-map-marker-alt"></i> <%= property.getLocation() %></p>
                    <p class="property-price">€ <%= property.getPrice() %></p>
                    <ul class="property-features">
                        <li>3 Beds</li>
                        <li>2 Baths</li>
                        <li>150 m²</li>
                    </ul>
                    <% if ("Available".equalsIgnoreCase(property.getStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/bookProperty">
                            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                            <button type="submit" style="padding:0.5rem 1rem; background:#38a169; color:white; border:none; border-radius:8px; cursor:pointer;">Book Now</button>
                        </form>
                    <% } %>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p style="text-align:center; color:#718096;">No properties available at the moment.</p>
            <%
                }
            %>
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
