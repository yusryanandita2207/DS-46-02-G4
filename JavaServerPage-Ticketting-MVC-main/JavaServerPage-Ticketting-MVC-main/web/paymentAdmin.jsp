<%@page import="java.util.*" %>
<%@page import="Models.Payment" %>
<%@page import="Models.Booking" %>
<%@page import="DAO.*" %>
<%@page import="java.text.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Payment> payments = (ArrayList<Payment>) request.getAttribute("payments");
    NumberFormat formatRupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management - Admin Dashboard | CarBook</title>
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
            <a href="bookingAdmin?menu=list" class="block py-3 px-4 rounded sidebar-item text-white mb-2">
                <i class="fas fa-book mr-3"></i>Bookings
            </a>
            <a href="#" class="block py-3 px-4 rounded sidebar-item text-white mb-2 bg-indigo-900">
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
                <h1 class="text-2xl font-bold mb-4 md:mb-0">Payment Management</h1>
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
                        <label class="block text-sm font-medium text-gray-700 mb-2">Transaction ID</label>
                        <input type="text" placeholder="Search by transaction ID..." class="w-full border border-gray-300 rounded-lg p-2">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Payment Date</label>
                        <input type="date" class="w-full border border-gray-300 rounded-lg p-2">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Payment Method</label>
                        <select class="w-full border border-gray-300 rounded-lg p-2">
                            <option value="">All Methods</option>
                            <option value="DANA">DANA</option>
                            <option value="GOPAY">GOPAY</option>
                            <option value="OVO">OVO</option>
                            <option value="BANK_TRANSFER">Bank Transfer</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                        <select class="w-full border border-gray-300 rounded-lg p-2">
                            <option value="">All Status</option>
                            <option value="SUCCESS">Success</option>
                            <option value="PENDING">Pending</option>
                            <option value="FAILED">Failed</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Payments Table -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="overflow-x-auto responsive">
                    <table class="table-auto w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Transaction ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment Method</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% if (payments != null && !payments.isEmpty()) {
                                for (Payment payment : payments) {
                            %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getTransactionId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getBookingId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= formatRupiah.format(payment.getAmount()) %></td>
                                <td class="px-6 py-4 whitespace-nowrap"><%= payment.getPaymentMethod() %></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <%= new SimpleDateFormat("dd-MM-yyyy HH:mm").format(payment.getPaymentDate()) %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        <%= payment.getPaymentStatus().equals("SUCCESS") ? "bg-green-100 text-green-800" : 
                                           payment.getPaymentStatus().equals("PENDING") ? "bg-yellow-100 text-yellow-800" : 
                                           "bg-red-100 text-red-800" %>">
                                        <%= payment.getPaymentStatus() %>
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <button class="text-blue-600 hover:text-blue-900 mr-3" title="View Details"
                                            onclick="location.href='paymentAdmin?menu=view&id=<%= payment.getId() %>'">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <% if (payment.getPaymentStatus().equals("PENDING")) { %>
                                        <button class="text-green-600 hover:text-green-900 mr-3" title="Approve"
                                                onclick="location.href='paymentAdmin?action=approve&id=<%= payment.getId() %>'">
                                            <i class="fas fa-check"></i>
                                        </button>
                                        <button class="text-red-600 hover:text-red-900" title="Reject"
                                                onclick="if(confirm('Are you sure you want to reject this payment?')) 
                                                        location.href='paymentAdmin?action=reject&id=<%= payment.getId() %>'">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    <% } %>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="8" class="text-center px-6 py-4">No payment data available.</td>
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