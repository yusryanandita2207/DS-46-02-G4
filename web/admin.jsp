<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("admin") == null) {
        response.sendRedirect("./login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Management Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.16/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .chart-container {
            height: 300px;
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
                <a href="<%= request.getContextPath() %>/AuthController?action=logout" class="block py-3 px-4 rounded sidebar-item text-white mt-4 bg-red-500 hover:bg-red-600">
                <i class="fas fa-sign-out-alt mr-3"></i>Logout
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
                        <img src="/api/placeholder/32/32" alt="Admin" class="w-8 h-8 rounded-full ml-4">
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Content -->
        <div class="container mx-auto p-4">
            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-indigo-100 text-indigo-500">
                            <i class="fas fa-ticket-alt text-2xl"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-gray-500 text-sm">Total Tickets</h3>
                            <p class="text-2xl font-semibold">1,258</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-green-100 text-green-500">
                            <i class="fas fa-check-circle text-2xl"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-gray-500 text-sm">Active Tickets</h3>
                            <p class="text-2xl font-semibold">842</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-yellow-100 text-yellow-500">
                            <i class="fas fa-crown text-2xl"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-gray-500 text-sm">Executive Tickets</h3>
                            <p class="text-2xl font-semibold">416</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-red-100 text-red-500">
                            <i class="fas fa-dollar-sign text-2xl"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-gray-500 text-sm">Total Revenue</h3>
                            <p class="text-2xl font-semibold">$52,489</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Tickets Table -->
            <div class="bg-white rounded-lg shadow-md mb-8">
                <div class="p-4 border-b border-gray-200">
                    <h2 class="text-xl font-semibold">Recent Tickets</h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Customer</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">#TK001</td>
                                <td class="px-6 py-4 whitespace-nowrap">John Doe</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-indigo-100 text-indigo-800">Executive</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Active</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <button class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</button>
                                    <button class="text-red-600 hover:text-red-900">Delete</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">#TK002</td>
                                <td class="px-6 py-4 whitespace-nowrap">Jane Smith</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Regular</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">Pending</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <button class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</button>
                                    <button class="text-red-600 hover:text-red-900">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Quick Actions & Activity Log -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold mb-4">Quick Actions</h3>
                    <div class="grid grid-cols-2 gap-4">
                        <button class="p-4 bg-indigo-500 text-white rounded-lg hover:bg-indigo-600">
                            <i class="fas fa-plus mb-2"></i>
                            <span class="block">Add Ticket</span>
                        </button>
                        <button class="p-4 bg-green-500 text-white rounded-lg hover:bg-green-600">
                            <i class="fas fa-file-export mb-2"></i>
                            <span class="block">Export Report</span>
                        </button>
                        <button class="p-4 bg-yellow-500 text-white rounded-lg hover:bg-yellow-600">
                            <i class="fas fa-envelope mb-2"></i>
                            <span class="block">Send Notice</span>
                        </button>
                        <button class="p-4 bg-purple-500 text-white rounded-lg hover:bg-purple-600">
                            <i class="fas fa-cog mb-2"></i>
                            <span class="block">Settings</span>
                        </button>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold mb-4">Recent Activity</h3>
                    <div class="space-y-4">
                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-indigo-100 rounded-full flex items-center justify-center text-indigo-500">
                                <i class="fas fa-ticket-alt"></i>
                            </div>
                            <div class="ml-4">
                                <p class="text-sm">New ticket created by John Doe</p>
                                <p class="text-xs text-gray-500">2 minutes ago</p>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-green-100 rounded-full flex items-center justify-center text-green-500">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-4">
                                <p class="text-sm">Ticket #TK001 marked as completed</p>
                                <p class="text-xs text-gray-500">1 hour ago</p>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-yellow-100 rounded-full flex items-center justify-center text-yellow-500">
                                <i class="fas fa-edit"></i>
                            </div>
                            <div class="ml-4">
                                <p class="text-sm">Ticket #TK002 updated</p>
                                <p class="text-xs text-gray-500">2 hours ago</p>
                            </div>
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