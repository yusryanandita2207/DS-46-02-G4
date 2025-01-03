<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carbook Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%);
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            padding: 3rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #4f46e5, #818cf8);
        }

        .brand {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .brand-logo {
            width: 60px;
            height: 60px;
            background: #4f46e5;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.2);
        }

        .brand-logo svg {
            width: 35px;
            height: 35px;
            fill: white;
        }

        .brand h1 {
            color: #1e1b4b;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .brand p {
            color: #6b7280;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: #4b5563;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }

        .form-group input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.75rem;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group input:focus {
            border-color: #4f46e5;
            outline: none;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .login-button {
            width: 100%;
            padding: 1rem;
            background: #4f46e5;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .login-button:hover {
            background: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.2);
        }

        .login-button:active {
            transform: translateY(0);
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        .brand-logo {
            animation: float 3s ease-in-out infinite;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="brand">
            <div class="brand-logo">
                <svg viewBox="0 0 24 24">
                    <path d="M14,2H6C4.9,2,4,2.9,4,4v16c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V8L14,2z M16,18H8v-2h8V18z M16,14H8v-2h8V14z M13,9V3.5 L18.5,9H13z"/>
                </svg>
            </div>
            <h1>Carbook's Admin</h1>
            <p>Login to manage your platform</p>
        </div>
        <form method="POST" action="<%= request.getContextPath() %>/AuthController">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    <input type="text" id="username" name="username" required>
                </div>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                    <input type="password" id="password" name="password" required>
                </div>
            </div>
            <button type="submit" class="login-button">Sign In</button>
        </form>
                            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger mt-3 text-center">
                    Username atau password salah!
                </div>
                <% } %>
    </div>
</body>
</html>