<%@page import="Models.Ticket"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Book Ticket</title>
   <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
   <style>
       body {
           font-family: 'Montserrat', sans-serif;
           background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
           min-height: 100vh;
           padding: 2rem 0;
       }
       .container {
           max-width: 800px;
           margin: 0 auto;
           padding: 2rem;
       }
       .card {
           background-color: rgba(255, 255, 255, 0.95);
           border-radius: 16px;
           box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
           padding: 2.5rem;
           backdrop-filter: blur(10px);
       }
       .ticket-details {
           background: linear-gradient(to right, #f6f8fb, #f0f4f8);
           padding: 1.5rem;
           border-radius: 12px;
           margin-bottom: 2rem;
           border: 1px solid #e2e8f0;
       }
       .ticket-details p {
           margin-bottom: 1rem;
           color: #4a5568;
           display: flex;
           align-items: center;
           padding: 0.5rem;
           border-bottom: 1px solid #e2e8f0;
       }
       .ticket-details p:last-child {
           border-bottom: none;
       }
       .ticket-details strong {
           color: #2d3748;
           min-width: 150px;
           display: inline-block;
           font-weight: 600;
       }
       .route-info {
           background: #805ad5;
           color: white;
           padding: 1rem;
           border-radius: 8px;
           margin-bottom: 1.5rem;
           text-align: center;
       }
       .route-info span {
           font-size: 1.25rem;
           font-weight: 600;
       }
       .form-group {
           margin-bottom: 1.5rem;
       }
       .form-group label {
           display: block;
           font-weight: 600;
           margin-bottom: 0.5rem;
           color: #4a5568;
       }
       .form-group input {
           width: 100%;
           padding: 0.75rem 1rem;
           border: 2px solid #e2e8f0;
           border-radius: 8px;
           font-size: 1rem;
           transition: all 0.3s ease;
       }
       .form-group input:focus {
           outline: none;
           border-color: #805ad5;
           box-shadow: 0 0 0 3px rgba(128, 90, 213, 0.2);
       }
       .btn {
           background: linear-gradient(to right, #6b46c1, #805ad5);
           color: white;
           padding: 0.75rem 2rem;
           border-radius: 8px;
           font-size: 1rem;
           font-weight: 600;
           transition: all 0.3s ease;
           border: none;
       }
       .btn:hover {
           transform: translateY(-2px);
           box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
       }
       .back-btn {
           position: absolute;
           top: 2rem;
           left: 2rem;
           color: white;
           text-decoration: none;
           font-weight: 600;
           display: flex;
           align-items: center;
           gap: 0.5rem;
       }
       .back-btn:hover {
           text-decoration: underline;
       }
       .price-tag {
           background: #f0f4f8;
           padding: 1rem;
           border-radius: 8px;
           font-weight: 600;
           color: #4a5568;
           text-align: center;
           border: 2px solid #e2e8f0;
       }
   </style>
</head>
<body>
   <a href="index.jsp" class="back-btn"> Back to Home</a>
   <div class="container">
       <div class="card">
           <h1 class="text-3xl font-bold mb-6 text-gray-800 text-center">Book Your Ticket</h1>
           <% if (request.getAttribute("ticket") != null) {
                Ticket ticket = (Ticket) request.getAttribute("ticket");
                NumberFormat formatRupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
           %>
           <div class="route-info">
               <span><%= ticket.getOrigin() %></span>
               <span class="mx-4">To</span>
               <span><%= ticket.getDestination() %></span>
           </div>

           <div class="ticket-details">
               <h2 class="text-xl font-semibold mb-4 text-gray-800">Ticket Details</h2>
               <p><strong>Travel Date:</strong> <%= ticket.getTravelDate() %></p>
               <p><strong>Departure Time:</strong> <%= ticket.getDepartureTime() %></p>
               <p><strong>Arrival Time:</strong> <%= ticket.getArrivalTime() %></p>
               <p><strong>Available Seats:</strong> <%= ticket.getStock() %> tickets</p>
               <p><strong>Price per Ticket:</strong> <%= formatRupiah.format(ticket.getBasePrice()) %></p>
           </div>

           <form action="booking" method="post" class="space-y-6">
               <input type="hidden" name="action" value="book">
               <input type="hidden" name="ticketId" value="<%= ticket.getId() %>">
               
               <div class="form-group">
                   <label for="name">Full Name:</label>
                   <input type="text" id="name" name="name" placeholder="Enter your full name" required>
               </div>
               
               <div class="form-group">
                   <label for="phone">Phone Number:</label>
                   <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required>
               </div>
               
               <div class="form-group">
                   <label for="birthDate">Date of Birth:</label>
                   <input type="date" id="birthDate" name="birthDate" required>
               </div>
               
               <div class="form-group">
                   <label for="quantity">Number of Tickets:</label>
                   <input type="number" id="quantity" name="quantity" min="1" max="<%= ticket.getStock() %>" value="1" required>
               </div>

               <div class="flex justify-between items-center mt-8">
                   <div class="price-tag text-lg">
                       Total Price: <%= formatRupiah.format(ticket.getBasePrice()) %>
                   </div>
                   <button type="submit" class="btn">
                       Confirm Booking
                   </button>
               </div>
           </form>
           <% } else { %>
               <div class="text-center text-gray-600">
                   <p>No ticket selected.</p>
                   <a href="index.jsp" class="btn mt-4">Browse Tickets</a>
               </div>
           <% } %>
       </div>
   </div>

   <script>
       // Menghitung total harga saat quantity berubah
       document.getElementById('quantity').addEventListener('change', function() {
           const basePrice = <%= request.getAttribute("ticket") != null ? ((Ticket)request.getAttribute("ticket")).getBasePrice() : 0 %>;
           const quantity = this.value;
           const totalPrice = basePrice * quantity;
           // Format ke Rupiah
           const formatter = new Intl.NumberFormat('id-ID', {
               style: 'currency',
               currency: 'IDR',
               minimumFractionDigits: 0
           });
           document.querySelector('.price-tag').textContent = `Total Price: ${formatter.format(totalPrice)}`;
       });
   </script>
</body>
</html>