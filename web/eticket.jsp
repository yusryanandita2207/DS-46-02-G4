<%@page import="Models.Booking"%>
<%@page import="Models.Ticket"%>
<%@page import="Models.Payment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>E-Ticket - CarBook</title>
   <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   <style>
       body {
           font-family: 'Montserrat', sans-serif;
           background-color: #f3f4f6;
       }
       .ticket-container {
           background: white;
           box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
           position: relative;
           overflow: hidden;
       }
       .ticket-container::before {
           content: '';
           position: absolute;
           top: 0;
           left: 0;
           right: 0;
           height: 5px;
           background: linear-gradient(to right, #6b46c1, #805ad5);
       }
       @media print {
           .no-print {
               display: none;
           }
           body {
               background: white;
           }
       }
   </style>
</head>
<body class="p-8">
   <%
       Booking booking = (Booking) request.getAttribute("booking");
       Ticket ticket = (Ticket) request.getAttribute("ticket");
       Payment payment = (Payment) request.getAttribute("payment");
       SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
       NumberFormat formatRupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
       
       if (booking != null && ticket != null && payment != null) {
   %>
   <div class="max-w-2xl mx-auto">
       <div class="ticket-container rounded-lg p-8 mb-6">
           <div class="text-center mb-6">
               <h1 class="text-2xl font-bold text-gray-800">CarBook E-Ticket</h1>
               <p class="text-gray-600">Booking ID: <%= booking.getId() %></p>
           </div>

           <div class="border-b pb-4 mb-4">
               <div class="flex justify-between items-center mb-4">
                   <div>
                       <h2 class="text-3xl font-bold text-indigo-600"><%= ticket.getOrigin() %></h2>
                       <p class="text-gray-600">Departure: <%= ticket.getDepartureTime() %></p>
                   </div>
                   <div class="text-center">
                       <i class="fas fa-arrow-right text-gray-400 text-xl"></i>
                   </div>
                   <div class="text-right">
                       <h2 class="text-3xl font-bold text-indigo-600"><%= ticket.getDestination() %></h2>
                       <p class="text-gray-600">Arrival: <%= ticket.getArrivalTime() %></p>
                   </div>
               </div>
               <p class="text-gray-600">Travel Date: <%= ticket.getTravelDate() %></p>
           </div>

           <div class="grid grid-cols-2 gap-4 mb-6">
               <div>
                   <h3 class="font-semibold text-gray-700">Passenger Details</h3>
                   <p class="text-gray-600">Name: <%= booking.getName() %></p>
                   <p class="text-gray-600">Phone: <%= booking.getPhone() %></p>
               </div>
               <div>
                   <h3 class="font-semibold text-gray-700">Ticket Details</h3>
                   <p class="text-gray-600">Quantity: <%= booking.getQuantity() %> ticket(s)</p>
                   <p class="text-gray-600">Total Price: <%= formatRupiah.format(payment.getAmount()) %></p>
               </div>
           </div>

           <div class="bg-gray-50 p-4 rounded-lg">
               <h3 class="font-semibold text-gray-700 mb-2">Payment Information</h3>
               <p class="text-gray-600">Method: <%= payment.getPaymentMethod() %></p>
               <p class="text-gray-600">Status: <%= payment.getPaymentStatus() %></p>
               <p class="text-gray-600">Transaction ID: <%= payment.getTransactionId() %></p>
               <p class="text-gray-600">Date: <%= dateFormat.format(payment.getPaymentDate()) %></p>
           </div>

           <!-- QR Code section -->
           <div class="text-center mt-6">
               <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=<%= booking.getId() %>" 
                    alt="QR Code" class="mx-auto">
               <p class="text-sm text-gray-500 mt-2">Scan for verification</p>
           </div>
       </div>

       <div class="text-center no-print">
           <button onclick="window.print()" class="bg-indigo-600 text-white px-6 py-2 rounded-lg hover:bg-indigo-700">
               <i class="fas fa-print mr-2"></i>Print E-Ticket
           </button>
           <a href="index.jsp" class="ml-4 text-indigo-600 hover:text-indigo-800">Back to Home</a>
       </div>
   </div>
   <% } else { %>
   <div class="text-center">
       <p class="text-red-600">Ticket information not found.</p>
       <a href="index.jsp" class="text-indigo-600 hover:text-indigo-800">Back to Home</a>
   </div>
   <% } %>

 
</body>
</html>