<%@page import="java.util.*" %>
<%@page import="Models.Booking" %>
<%@page import="Models.Ticket" %>
<%@page import="DAO.*" %>
<%@page import="java.text.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Booking> bookings = (ArrayList<Booking>) request.getAttribute("bookings");
    NumberFormat formatRupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - Admin Dashboard | CarBook</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.16/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .responsive {
            overflow-x: auto;
        }
    </style>
</head>
<body class="bg-gray-100">
    <!-- Sidebar -->
        <div class="fixed inset-y-0 left-0 w-64 bg-indigo-800 text-white transition-all duration-300 z-30 md:translate-x-0" id="sidebar">
        <!-- ... (sidebar content sama) ... -->
                <div class="flex items-center justify-between p-4 border-b border-indigo-700">
            <span class="text-2xl font-semibold">CarBook</span>
            <button class="md:hidden" onclick="toggleSidebar()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <nav class="p-4">
            <a href="admin.jsp" class="block py-3 px-4 rounded sidebar-item text-white mb-2">
                <i class="fas fa-home mr-3"></i>Dashboard
            </a>
            <a href="ticket?menu=view" class="block py-3 px-4 rounded sidebar-item text-white mb-2">
                <i class="fas fa-ticket-alt mr-3"></i>Tickets
            </a>
            <a href="bookingAdmin?menu=view" class="block py-3 px-4 rounded sidebar-item text-white mb-2 ">
                <i class="fas fa-book mr-3"></i>Bookings
            </a>
            <a href="paymentAdmin?menu=view" class="block py-3 px-4 rounded sidebar-item text-white mb-2">
                <i class="fas fa-money-bill mr-3"></i>Payments
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="md:ml-64 min-h-screen transition-all duration-300" id="main-content">
        <!-- Top Navigation -->
        <div class="bg-white shadow-md">
            <div class="container mx-auto">
                <div class="flex items-center justify-between p-4">
                    <button class="md:hidden" onclick="toggleSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="flex items-center">
                        <div class="relative">
                            <i class="fas fa-bell text-gray-500 text-xl cursor-pointer"></i>
                            <span class="absolute -top-1 -right-1 bg-red-500 text-white rounded-full w-4 h-4 text-xs flex items-center justify-center">3</span>
                        </div>
                        <img src="" alt="Admin" class="w-8 h-8 rounded-full ml-4">
                    </div>
                </div>
            </div>
        </div>

        <!-- Content -->
        <div class="container mx-auto p-4">
            <!-- Header -->
            <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
                <h1 class="text-2xl font-bold mb-4 md:mb-0">Booking Management</h1>
                <!-- Message Alert -->
                <% String message = (String) request.getAttribute("message");
                   if (message != null && !message.isEmpty()) { %>
                <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
                    <p><i class="fas fa-check-circle mr-2"></i><%= message %></p>
                </div>
                <% } %>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                        <input type="text" placeholder="Search by passenger name..." class="w-full border border-gray-300 rounded-lg p-2">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Travel Date</label>
                        <input type="date" class="w-full border border-gray-300 rounded-lg p-2">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Booking Status</label>
                        <select class="w-full border border-gray-300 rounded-lg p-2">
                            <option value="">All Status</option>
                            <option value="confirmed">Confirmed</option>
                            <option value="pending">Pending Payment</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Payment Status</label>
                        <select class="w-full border border-gray-300 rounded-lg p-2">
                            <option value="">All</option>
                            <option value="paid">Paid</option>
                            <option value="pending">Pending</option>
                            <option value="failed">Failed</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Bookings Table -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="overflow-x-auto responsive">
                    <table class="table-auto w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Passenger Name</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Route</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Travel Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantity</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Price</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% if (bookings != null && !bookings.isEmpty()) {
                                for (Booking booking : bookings) {
                                    TicketDAO ticketDAO = new TicketDAOImpl();
                                    Ticket ticket = ticketDAO.find(booking.getTicketId());
                                    double totalPrice = ticket.getBasePrice() * booking.getQuantity();
                            %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap"><%= booking.getId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= booking.getName() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= booking.getPhone() %></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="text-gray-900"><%= ticket.getOrigin() %></span>
                                    <span class="text-gray-500 mx-2">→</span>
                                    <span class="text-gray-900"><%= ticket.getDestination() %></span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= ticket.getTravelDate() %></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <%= new SimpleDateFormat("dd-MM-yyyy HH:mm").format(booking.getBookingDate()) %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= booking.getQuantity() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= formatRupiah.format(totalPrice) %></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                        Pending
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <button class="text-blue-600 hover:text-blue-900 mr-3" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <form action="<%= request.getContextPath() %>/booking" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
<!--                                        <button type="submit" class="text-red-600 hover:text-red-900" 
                                                title="Cancel Booking" 
                                                onclick="return confirm('Are you sure you want to cancel this booking?')">
                                            <i class="fas fa-times"></i>
                                        </button>-->
                                    </form>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="10" class="text-center px-6 py-4">No booking data available.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">
                                Showing <span class="font-medium">1</span> to <span class="font-medium">10</span> of <span class="font-medium">20</span> results
                            </p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px">
                                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-indigo-600 hover:bg-gray-50">1</a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">2</a>
                                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            
            sidebar.classList.toggle('translate-x-0');
            sidebar.classList.toggle('-translate-x-full');
            mainContent.classList.toggle('md:ml-64');
            mainContent.classList.toggle('ml-0');
        }
    </script>
</body>
</html>