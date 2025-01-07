<%@page import="java.util.*" %>
<%@page import="Models.Ticket"  %>
<%@page import="Models.Executive" %>
<%@page import="Models.Regular" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Ticket> tickets = (ArrayList<Ticket>) request.getAttribute("tickets");
    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Management - Admin Dashboard | CarBook</title>
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

    <!-- Sidebar (Same as dashboard) -->
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

        <!-- Ticket Management Content -->
        <div class="container mx-auto p-4">
            <!-- Header and Actions -->
            <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
                <h1 class="text-2xl font-bold mb-4 md:mb-0">Ticket Management</h1>
                <div class="flex flex-col md:flex-row gap-3">
                <button onclick="location.href='ticket?menu=add'" class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700">
                    <i class="fas fa-plus mr-2"></i>Add New Ticket
                </button>
                </div>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Ticket Type</label>
                        <select class="w-full border border-gray-300 rounded-lg p-2">
                            <option value="">All Types</option>
                            <option value="regular">Regular</option>
                            <option value="executive">Executive</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                        <select class="w-full border border-gray-300 rounded-lg p-2">
                            <option value="">All Status</option>
                            <option value="active">Active</option>
                            <option value="completed">Completed</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date Range</label>
                        <input type="date" class="w-full border border-gray-300 rounded-lg p-2">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                        <input type="text" placeholder="Search tickets..." class="w-full border border-gray-300 rounded-lg p-2">
                    </div>
                    <div>
                        <%
                            String message = (String) request.getAttribute("message");
                            if (message != null && !message.isEmpty()) {
                        %>
                            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                                <strong><i class="fas fa-check-circle me-2"></i>Success!</strong> <%= message %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <%
                            }
                        %>
                        
                        
                    </div>
                </div>
            </div>

            <!-- Tickets Table -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="overflow-x-auto responsive">
                    <table class="table-auto w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Ticket ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Reservation Number</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Route</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Travel Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Departure Time</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Arrival Time</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Type</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Price</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Stock</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% if (tickets != null && !tickets.isEmpty()) { %>
                                <% for (Ticket ticket : tickets) { %>
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap"><%= ticket.getId() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap"><%= ticket.getReservationNumber() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="text-gray-900"><%= ticket.getOrigin() %></span>
                                            <span class="text-gray-500 mx-2">→</span>
                                            <span class="text-gray-900"><%= ticket.getDestination() %></span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap"><%= ticket.getTravelDate() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap"><%= ticket.getDepartureTime() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap"><%= ticket.getArrivalTime() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full <%= ticket instanceof Executive ? "bg-purple-100 text-purple-800" : "bg-blue-100 text-blue-800" %>">
                                                <%= ticket instanceof Executive ? "Executive" : "Regular" %>
                                            </span>
                                            <% if (ticket instanceof Executive) { %>
                                                <% Executive execTicket = (Executive) ticket; %>
                                                <span class="block text-xs text-gray-500 mt-1">
                                                    <%= execTicket.getFacilities() %>
                                                </span>
                                            <% } %>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="text-gray-900">
                                                Rp <%= String.format("%,.2f", ticket instanceof Executive ? ((Executive) ticket).getFinalPrice() : ((Regular) ticket).getFinalPrice()) %>
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="<%= ticket.getStock() > 0 ? "text-green-600" : "text-red-600" %>">
                                                <%= ticket.getStock() %>
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full <%= ticket.getTicketStatus().equals("Active") ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800" %>">
                                                <%= ticket.getTicketStatus() %>
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <button class="text-indigo-600 hover:text-indigo-900 mr-3" title="Edit" onclick="location.href='ticket?menu=edit&id=<%= ticket.getId() %>'">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="text-blue-600 hover:text-blue-900 mr-3" title="View" onclick="location.href='ticket?menu=view&id=<%= ticket.getId() %>'">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                                <form method="POST" action="<%= request.getContextPath() %>/ticket">
                                                        <input type="hidden" name="action" value="delete" />
                                                        <input type="hidden" name="id" value="<%= ticket.getId() %>" />
                                                <button class="text-red-600 hover:text-red-900" title="Delete" onclick="return confirm('Are You Sure Want to Delete This Ticket?')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                                </form>
                       
                                        </td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr>
                                    <td colspan="11" class="text-center px-6 py-4">No ticket data available.</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                    <div class="flex-1 flex justify-between sm:hidden">
                        <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            Previous
                        </a>
                        <a href="#" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            Next
                        </a>
                    </div>
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">
                                Showing <span class="font-medium">1</span> to <span class="font-medium">10</span> of <span class="font-medium">97</span> results
                            </p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">Previous</span>
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">1</a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">2</a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">3</a>
                                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">Next</span>
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