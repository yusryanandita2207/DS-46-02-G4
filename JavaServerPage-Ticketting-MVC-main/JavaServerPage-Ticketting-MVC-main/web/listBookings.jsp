<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Models.Booking" %>
<%@ page import="Models.Ticket" %>
<%@ page import="DAO.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking List</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f0f4f8;
        }
    </style>
</head>
<body class="p-6">
    <div class="max-w-6xl mx-auto">
        <div class="bg-white rounded-lg shadow-lg p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-bold text-gray-800">Booking List</h1>
                <a href="index.jsp" class="bg-purple-600 text-white px-4 py-2 rounded hover:bg-purple-700">Back to Home</a>
            </div>

            <% 
            String message = (String) request.getSession().getAttribute("message");
            if (message != null) {
            %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                    <%= message %>
                </div>
            <%
                request.getSession().removeAttribute("message");
            }
            %>

            <div class="overflow-x-auto">
                <table class="min-w-full table-auto">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Booking ID</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Passenger Name</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Route</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Travel Date</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Quantity</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Booking Date</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <%
                        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                        TicketDAO ticketDAO = new TicketDAOImpl();

                        if (bookings != null && !bookings.isEmpty()) {
                            for (Booking booking : bookings) {
                                Ticket ticket = ticketDAO.find(booking.getTicketId());
                        %>
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4 text-sm text-gray-500"><%= booking.getId() %></td>
                            <td class="px-6 py-4 text-sm text-gray-500"><%= booking.getName() %></td>
                            <td class="px-6 py-4 text-sm text-gray-500">
                                <%= ticket != null ? ticket.getOrigin() + " → " + ticket.getDestination() : "N/A" %>
                            </td>
                            <td class="px-6 py-4 text-sm text-gray-500">
                                <%= ticket != null ? ticket.getTravelDate() : "N/A" %>
                            </td>
                            <td class="px-6 py-4 text-sm text-gray-500"><%= booking.getQuantity() %></td>
                            <td class="px-6 py-4 text-sm text-gray-500">
                                <%= dateTimeFormat.format(booking.getBookingDate()) %>
                            </td>
                            <td class="px-6 py-4 text-sm">
                                <form action="booking" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to cancel this booking?')" 
                                            class="text-red-600 hover:text-red-800">
                                        Cancel
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="px-6 py-4 text-center text-gray-500">No bookings found</td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>