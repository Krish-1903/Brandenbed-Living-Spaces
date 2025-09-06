<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Brandenbed</title>
    <style>
        /* Reset & base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #3182ce, #2c5282);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Login container */
        .login-container {
            background: #fff;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            text-align: center;
            animation: fadeInUp 0.8s ease-out;
        }

        .login-container h2 {
            margin-bottom: 1.5rem;
            color: #2d3748;
            font-size: 1.8rem;
            font-weight: 700;
        }

        /* Form elements */
        .login-container label {
            display: block;
            text-align: left;
            font-weight: 500;
            margin-bottom: 0.3rem;
            color: #4a5568;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 0.75rem 1rem;
            margin-bottom: 1.2rem;
            border: 1px solid #cbd5e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .login-container input:focus {
            border-color: #3182ce;
            outline: none;
            box-shadow: 0 0 6px rgba(49, 130, 206, 0.3);
        }

        /* Button */
        .login-container button {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, #3182ce, #2c5282);
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-container button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(49, 130, 206, 0.3);
        }

        /* Error message */
        .error-message {
            margin-top: 1rem;
            color: #e53e3e;
            font-weight: 500;
            font-size: 0.95rem;
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="admin" method="post">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required />

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required />

            <button type="submit">Login</button>
        </form>

        <p class="error-message">${errmsg}</p>
    </div>
</body>
</html>
