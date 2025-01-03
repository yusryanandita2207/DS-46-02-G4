<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Ticket"%>
<%@page import="Models.Regular"%>
<%@page import="Models.Executive"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit Ticket</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            .card-header {
                background-color: #4e73df;
                color: white;
                border-radius: 15px 15px 0 0 !important;
                padding: 1.5rem;
            }
            .form-label {
                font-weight: 600;
                color: #4e73df;
                margin-bottom: 0.5rem;
            }
            .form-control, .form-select {
                border-radius: 8px;
                padding: 0.75rem;
                border: 1px solid #e3e6f0;
            }
            .form-control:focus, .form-select:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 0.2rem rgba(78,115,223,0.25);
            }
            .btn-primary {
                background-color: #4e73df;
                border-color: #4e73df;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                border-radius: 8px;
            }
            .btn-primary:hover {
                background-color: #2e59d9;
                border-color: #2e59d9;
            }
            .btn-secondary {
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                border-radius: 8px;
            }
            .input-group-text {
                background-color: #4e73df;
                color: white;
                border: none;
                border-radius: 8px 0 0 8px;
            }
            .was-validated .form-control:invalid, .was-validated .form-select:invalid {
                border-color: #e74a3b;
            }
            .invalid-feedback {
                color: #e74a3b;
            }
        </style>
    </head>
    <body>
         <%
        Ticket ticket = (Ticket) request.getAttribute("ticket");
        if (ticket == null) {
    %>
        <div class="container my-5">
            <div class="alert alert-danger text-center">
                <h4>Data Tiket Not Found.</h4>
                <a href="ticket?menu=view" class="btn btn-primary mt-3">Back To Dashboard</a>
            </div>
        </div>
    <%
        } else {
    %>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h2 class="mb-0"><i class="fas fa-edit me-2"></i>Edit Ticket</h2>
                        </div>
                        <div class="card-body p-4">
                            <form action="ticket" method="POST" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="<%= ticket.getId() %>">
                                
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="reservationNumber" class="form-label">
                                                <i class="fas fa-hashtag me-2"></i>Reservation Number
                                            </label>
                                            <input type="text" class="form-control" id="reservationNumber" name="reservationNumber" value="<%= ticket.getReservationNumber() %>" required>
                                            <div class="invalid-feedback">Please enter a reservation number.</div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="travelDate" class="form-label">
                                                <i class="fas fa-calendar me-2"></i>Travel Date
                                            </label>
                                            <input type="date" class="form-control" id="travelDate" name="travelDate" value="<%= ticket.getTravelDate() %>" required>
                                            <div class="invalid-feedback">Please select a travel date.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="ticketStatus" class="form-label">
                                                <i class="fas fa-info-circle me-2"></i>Ticket Status
                                            </label>
                                            <select class="form-select" id="ticketStatus" name="ticketStatus" required>
                                                <option value="Available" <%= "Available".equals(ticket.getTicketStatus()) ? "selected" : "" %>>Available</option>
                                                <option value="Booked" <%= "Booked".equals(ticket.getTicketStatus()) ? "selected" : "" %>>Booked</option>
                                                <option value="Cancelled" <%= "Cancelled".equals(ticket.getTicketStatus()) ? "selected" : "" %>>Cancelled</option>
                                            </select>
                                            <div class="invalid-feedback">Please select a status.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="ticketType" class="form-label">
                                                <i class="fas fa-tag me-2"></i>Ticket Type
                                            </label>
                                            <select class="form-select" id="ticketType" name="ticketType" required onchange="toggleFacilities()">
                                                <option value="Executive" <%= ticket instanceof Executive ? "selected" : "" %>>Executive</option>
                                                <option value="Regular" <%= ticket instanceof Regular ? "selected" : "" %>>Regular</option>
                                            </select>
                                            <div class="invalid-feedback">Please select a ticket type.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="origin" class="form-label">
                                                <i class="fas fa-plane-departure me-2"></i>Origin
                                            </label>
                                            <input type="text" class="form-control" id="origin" name="origin" value="<%= ticket.getOrigin() %>" required>
                                            <div class="invalid-feedback">Please enter an origin.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="destination" class="form-label">
                                                <i class="fas fa-plane-arrival me-2"></i>Destination
                                            </label>
                                            <input type="text" class="form-control" id="destination" name="destination" value="<%= ticket.getDestination() %>" required>
                                            <div class="invalid-feedback">Please enter a destination.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="departureTime" class="form-label">
                                                <i class="fas fa-clock me-2"></i>Departure Time
                                            </label>
                                            <input type="time" class="form-control" id="departureTime" name="departureTime" value="<%= ticket.getDepartureTime() %>" required>
                                            <div class="invalid-feedback">Please select a departure time.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="arrivalTime" class="form-label">
                                                <i class="fas fa-clock me-2"></i>Arrival Time
                                            </label>
                                            <input type="time" class="form-control" id="arrivalTime" name="arrivalTime" value="<%= ticket.getArrivalTime() %>" required>
                                            <div class="invalid-feedback">Please select an arrival time.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="stock" class="form-label">
                                                <i class="fas fa-cubes me-2"></i>Stock
                                            </label>
                                            <input type="number" class="form-control" id="stock" name="stock" value="<%= ticket.getStock() %>" required min="0">
                                            <div class="invalid-feedback">Please enter a valid stock number.</div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="basePrice" class="form-label">
                                                <i class="fas fa-dollar-sign me-2"></i>Base Price
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">$</span>
                                                <input type="number" class="form-control" id="basePrice" name="basePrice" value="<%= ticket.getBasePrice() %>" required step="0.01" min="0">
                                                <div class="invalid-feedback">Please enter a valid price.</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3" id="facilitiesDiv" style="<%= ticket instanceof Executive ? "block" : "none" %>">
                                            <label for="facilities" class="form-label">
                                                <i class="fas fa-concierge-bell me-2"></i>Facilities (Optional)
                                            </label>
                                            <input type="text" class="form-control" id="facilities" name="facilities" value="<%= ticket instanceof Executive ? ((Executive) ticket).getFacilities() : "" %>" placeholder="Enter facilities (optional)">
                                            <small class="text-muted">Leave empty if no special facilities</small>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 d-flex justify-content-end gap-2">
                                    <a href="ticket?menu=view" class="btn btn-secondary">
                                        <i class="fas fa-times me-2"></i>Cancel
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <%
        }
    %>

        <script>
            function toggleFacilities() {
                const ticketType = document.getElementById('ticketType').value;
                const facilitiesDiv = document.getElementById('facilitiesDiv');
                facilitiesDiv.style.display = ticketType === 'Executive' ? 'block' : 'none';
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>