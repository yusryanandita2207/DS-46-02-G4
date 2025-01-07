<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Montserrat', sans-serif;
      background-color: #f0f4f8;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 2rem;
    }
    .card {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      padding: 2rem;
      text-align: center;
    }
    .error-message {
      font-size: 1.5rem;
      font-weight: 600;
      color: #e53e3e;
    }
    .btn {
      background-color: #6b46c1;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 6px;
      font-size: 1rem;
      font-weight: 600;
      transition: background-color 0.3s ease;
      display: inline-block;
      margin-top: 1rem;
    }
    .btn:hover {
      background-color: #805ad5;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="card">
      <h1 class="text-2xl font-bold mb-6">Oops!</h1>
      <p class="error-message">
        <%= request.getAttribute("error") %>
      </p>
      <a href="index.jsp" class="btn">Go to Home</a>
    </div>
  </div>
</body>
</html>