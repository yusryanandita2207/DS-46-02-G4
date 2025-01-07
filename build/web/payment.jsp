<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Models.Booking"%>
<%@ page import="Models.Ticket"%>
<%@ page import="DAO.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
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
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
        }
        .payment-option {
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .payment-option:hover {
            border-color: #805ad5;
        }
        .payment-option.selected {
            border-color: #805ad5;
            background-color: #f8f7ff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">Payment Details</h1>
            
            <%
                Booking booking = (Booking) request.getAttribute("booking");
                if (booking != null) {
                    TicketDAO ticketDAO = new TicketDAOImpl();
                    Ticket ticket = ticketDAO.find(booking.getTicketId());
                    NumberFormat formatRupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
                    double totalAmount = ticket.getBasePrice() * booking.getQuantity();
            %>
                <div class="bg-purple-50 p-4 rounded-lg mb-6">
                    <h2 class="font-semibold text-lg mb-3">Booking Summary</h2>
                    <p class="mb-2"><span class="font-medium">Passenger:</span> <%= booking.getName() %></p>
                    <p class="mb-2"><span class="font-medium">Route:</span> <%= ticket.getOrigin() %> → <%= ticket.getDestination() %></p>
                    <p class="mb-2"><span class="font-medium">Travel Date:</span> <%= ticket.getTravelDate() %></p>
                    <p class="mb-2"><span class="font-medium">Quantity:</span> <%= booking.getQuantity() %> ticket(s)</p>
                    <p class="text-xl font-bold mt-4">Total Amount: <%= formatRupiah.format(totalAmount) %></p>
                </div>

                <form action="payment" method="post" id="paymentForm" class="space-y-6">
                    <input type="hidden" name="action" value="process">
                    <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                    <input type="hidden" name="amount" value="<%= totalAmount %>">
                    
                    <div class="mb-4">
                        <h3 class="font-semibold mb-3">Select Payment Method</h3>
                        
                        <div class="payment-option" onclick="selectPayment('DANA')">
                            <input type="radio" name="paymentMethod" value="DANA" required>
                            <label class="ml-2">DANA</label>
                        </div>
                        
                        <div class="payment-option" onclick="selectPayment('GOPAY')">
                            <input type="radio" name="paymentMethod" value="GOPAY" required>
                            <label class="ml-2">GOPAY</label>
                        </div>
                        
                        <div class="payment-option" onclick="selectPayment('OVO')">
                            <input type="radio" name="paymentMethod" value="OVO" required>
                            <label class="ml-2">OVO</label>
                        </div>
                        
                        <div class="payment-option" onclick="selectPayment('BANK_TRANSFER')">
                            <input type="radio" name="paymentMethod" value="BANK_TRANSFER" required>
                            <label class="ml-2">Bank Transfer</label>
                        </div>
                    </div>

                    <div class="flex justify-between items-center mt-8">
                        <a href="index.jsp" class="text-purple-600 hover:text-purple-800">Cancel Payment</a>
                        <button type="submit" class="bg-purple-600 text-white px-6 py-2 rounded-lg hover:bg-purple-700 transition-all">
                            Pay Now
                        </button>
                    </div>
                </form>
            <% } else { %>
                <div class="text-center text-gray-600">
                    <p>No booking information found.</p>
                    <a href="index.jsp" class="text-purple-600 hover:text-purple-800 mt-4 inline-block">Back to Home</a>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        function selectPayment(method) {
            // Hapus kelas selected dari semua opsi
            document.querySelectorAll('.payment-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Tambah kelas selected ke opsi yang dipilih
            const selectedOption = document.querySelector(`input[value="${method}"]`).closest('.payment-option');
            selectedOption.classList.add('selected');
            
            // Check radio button
            document.querySelector(`input[value="${method}"]`).checked = true;
        }
    </script>
</body>
</html>