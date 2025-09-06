<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | Brandenbed Living Spaces</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin:0; padding:0; background:#f7fafc; color:#333; }
    /* Header same as Sign In */
    .header { background: rgba(255,255,255,0.95); backdrop-filter: blur(10px); position: fixed; top:0; width:100%; z-index:1000; padding:1rem 0; box-shadow:0 2px 20px rgba(0,0,0,0.1);}
    .nav-container { max-width:1200px; margin:0 auto; display:flex; justify-content:space-between; align-items:center; padding:0 2rem; }
    .logo { font-size:1.8rem; font-weight:bold; color:#2c5282; text-decoration:none; display:flex; align-items:center; }
    .logo i { margin-right:0.5rem; color:#3182ce; }
    .nav-menu { display:flex; list-style:none; gap:1.5rem; }
    .nav-menu a { text-decoration:none; color:#4a5568; font-weight:500; transition:0.3s; }
    .nav-menu a:hover { color:#3182ce; }
    .sign-in-btn { background:linear-gradient(135deg,#3182ce,#2c5282); color:white !important; padding:0.6rem 1.2rem; border-radius:25px; }
    .mobile-menu-toggle { display:none; font-size:1.5rem; cursor:pointer; background:none; border:none; color:#4a5568; }

    /* Auth Section */
    .auth-section { display:flex; justify-content:center; align-items:center; min-height:100vh; padding:2rem; }
    .auth-card { background:white; border-radius:15px; box-shadow:0 15px 40px rgba(0,0,0,0.1); max-width:400px; width:100%; padding:2.5rem 2rem; text-align:center; }
    .auth-card h2 { font-size:2rem; margin-bottom:2rem; color:#2d3748; }

    /* Form */
    .auth-card form { display:flex; flex-direction:column; gap:1rem; }
    .auth-card form input, .auth-card form button {
        width: 100%; padding:0.75rem 1rem; border-radius:8px; border:1px solid #ccc; font-size:1rem; box-sizing:border-box;
    }
    .auth-card form button { background:#3182ce; color:white; border:none; font-weight:600; cursor:pointer; transition:0.3s; }
    .auth-card form button:hover { background:#2c5282; }

    .auth-card p { margin-top:1rem; color:#718096; }
    .auth-card p a { color:#3182ce; text-decoration:none; font-weight:500; }
    .auth-card p a:hover { text-decoration:underline; }

    /* Footer same as Sign In */
    .footer { background: linear-gradient(135deg,#2d3748,#1a202c); color:white; padding:3rem 0 1rem; }
    .footer-content { max-width:1200px; margin:0 auto; padding:0 2rem; display:grid; grid-template-columns:repeat(auto-fit,minmax(250px,1fr)); gap:2rem; }
    .footer-section h3 { color:#3182ce; margin-bottom:1rem; font-size:1.3rem; }
    .footer-section p, .footer-section a { color:#a0aec0; text-decoration:none; margin-bottom:0.5rem; display:block; }
    .footer-section a:hover { color:#3182ce; }
    .social-links { display:flex; gap:1rem; margin-top:1rem; }
    .social-links a { display:flex; align-items:center; justify-content:center; width:40px; height:40px; background:#3182ce; border-radius:50%; color:white; transition:all 0.3s; }
    .social-links a:hover { background:#2c5282; transform:translateY(-3px); }
    .footer-bottom { border-top:1px solid #4a5568; margin-top:2rem; padding-top:1rem; text-align:center; color:#718096; }

    @media(max-width:768px){
        .mobile-menu-toggle{display:block;}
        .nav-menu{display:none; flex-direction:column; gap:1rem;}
        .nav-menu.active{display:flex;}
    }
</style>
</head>
<body>

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

<section class="auth-section">
    <div class="auth-card">
        <h2>Register</h2>
        <form method="post" action="<%= request.getContextPath() %>/registerUser">
            <input type="text" name="fullName" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Register</button>
        </form>
