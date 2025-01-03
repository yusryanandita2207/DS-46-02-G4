<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Models.Ticket" %>
<%@ page import="DAO.TicketDAOImpl" %>
<%@ page import="DAO.TicketDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CarBook - Book Your Tickets</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.16/dist/tailwind.min.css" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    /* Global styles */
    html {
      scroll-behavior: smooth;
    }
    
    body {
      font-family: 'Montserrat', sans-serif;
      background-color: #f0f4f8;
    }

    .hero {
      background-image: linear-gradient(to right, #6b46c1, #805ad5);
      height: 600px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      color: white;
    }

    .hero h1 {
      font-size: 3.5rem;
      font-weight: 700;
      margin-bottom: 1rem;
    }

    .hero p {
      font-size: 1.5rem;
      margin-bottom: 2rem;
    }

    .btn {
      background-color: #f0f4f8;
      color: #6b46c1;
      padding: 12px 24px;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 600;
      transition: background-color 0.3s ease, color 0.3s ease;
    }

    .btn:hover {
      background-color: #e2e8f0;
      color: #805ad5;
    }

    .features {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 3rem;
      padding: 5rem 2rem;
    }

    .feature {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      padding: 3rem;
      text-align: center;
      transition: transform 0.3s ease;
    }

    .feature:hover {
      transform: translateY(-10px);
    }

    .feature h3 {
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 1rem;
      color: #4a5568;
    }

    .feature p {
      font-size: 1.1rem;
      color: #718096;
    }

    .tickets {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 2rem;
      padding: 4rem 2rem;
    }

    .ticket {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      padding: 2rem;
      text-align: center;
      transition: transform 0.3s ease;
    }

    .ticket:hover {
      transform: translateY(-10px);
    }

    .ticket h4 {
      font-size: 1.5rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: #4a5568;
    }

    .ticket p {
      font-size: 1.1rem;
      color: #718096;
      margin-bottom: 1rem;
    }

    .ticket .price {
      font-size: 1.75rem;
      font-weight: 700;
      color: #6b46c1;
    }

    .ticket .image {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
      margin-bottom: 1rem;
    }

    .admin-btn {
      position: fixed;
      top: 20px;
      right: 20px;
      background-color: rgba(255, 255, 255, 0.2);
      color: white;
      padding: 10px 20px;
      border-radius: 8px;
      font-weight: 600;
      backdrop-filter: blur(10px);
      transition: all 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .admin-btn:hover {
      background-color: rgba(255, 255, 255, 0.3);
      transform: translateY(-2px);
    }
  </style>
</head>
<body>
    <%
    List<Ticket> tickets = null;
    try {
        TicketDAO ticketDAO = new TicketDAOImpl();
        tickets = ticketDAO.findAll();
    } catch (Exception e) {
        e.printStackTrace();
    }
    NumberFormat formatRupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    %>

    <a href="login.jsp" class="admin-btn">Admin Login</a>
    <div class="hero">
        <h1>Welcome to CarBook</h1>
        <p>Discover the best deals and book your tickets with ease.</p>
        <a href="#ticketSection" class="btn" onclick="smoothScroll(event, 'ticketSection')">Book Now</a>
    </div>

    <div class="features">
        <div class="feature">
            <h3>Easy Booking</h3>
            <p>Our intuitive booking system makes it simple to find and purchase your tickets.</p>
        </div>
        <div class="feature">
            <h3>Flexible Options</h3>
            <p>Choose from a variety of travel options to fit your needs and budget.</p>
        </div>
        <div class="feature">
            <h3>24/7 Support</h3>
            <p>Our dedicated support team is available to assist you with any questions or concerns.</p>
        </div>
    </div>

    <div id="ticketSection" class="tickets">
        <% 
        if (tickets != null && !tickets.isEmpty()) {
            for (Ticket ticket : tickets) { 
        %>
        <div class="ticket">
            <h4><%= ticket.getOrigin() %> to <%= ticket.getDestination() %></h4>
            <p>Travel Date: <%= ticket.getTravelDate() %></p>
            <div class="price"><%= formatRupiah.format(ticket.getBasePrice()) %></div>
            <p>Departure Time: <%= ticket.getDepartureTime() %></p>
            <p>Arrival Time: <%= ticket.getArrivalTime() %></p>
            <p>Status: <%= ticket.getTicketStatus() %></p>
            <p>Available Seats: <%= ticket.getStock() %></p>
            <a href="booking?menu=view&id=<%= ticket.getId() %>" class="btn">Book Now</a>
        </div>
        <% 
            } 
        } else { 
        %>
        <div class="text-center w-full">
            <p class="text-gray-600">No tickets available at the moment.</p>
        </div>
        <% } %>
    </div>
    <script>
    function smoothScroll(e, targetId) {
        e.preventDefault();
        document.getElementById(targetId).scrollIntoView({ 
            behavior: 'smooth',
            block: 'start'
        });
    }
    </script>
</body>
</html>
