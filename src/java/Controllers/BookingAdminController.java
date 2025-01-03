package Controllers;

import DAO.BookingDAO;
import DAO.BookingDAOImpl;
import DAO.TicketDAO;
import DAO.TicketDAOImpl;
import Models.Booking;
import Models.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookingAdminController", urlPatterns = {"/bookingAdmin"})
public class BookingAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        if (menu == null) {
            menu = "list";
        }

        try {
            switch (menu) {
                case "list":
                    showBookingList(request, response);
                    break;
                case "view":
                    viewBookingDetail(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                default:
                    response.sendRedirect("bookingAdmin?menu=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    createBooking(request, response);
                    break;
                case "edit":
                    updateBooking(request, response);
                    break;
                case "delete":
                    deleteBooking(request, response);
                    break;
                case "cancel":
                    cancelBooking(request, response);
                    break;
                default:
                    response.sendRedirect("bookingAdmin?menu=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showBookingList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        BookingDAO bookingDAO = new BookingDAOImpl();
        List<Booking> bookings = bookingDAO.findAll();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/bookAdmin.jsp").forward(request, response);
    }

    private void viewBookingDetail(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            BookingDAO bookingDAO = new BookingDAOImpl();
            Booking booking = bookingDAO.find(id);
            if (booking != null) {
                // Get ticket details
                TicketDAO ticketDAO = new TicketDAOImpl();
                Ticket ticket = ticketDAO.find(booking.getTicketId());
                request.setAttribute("booking", booking);
                request.setAttribute("ticket", ticket);
                request.getRequestDispatcher("/viewBooking.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("bookingAdmin?menu=list");
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Get list of available tickets for the form
        TicketDAO ticketDAO = new TicketDAOImpl();
        List<Ticket> tickets = ticketDAO.findAll();
        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher("/addBooking.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            BookingDAO bookingDAO = new BookingDAOImpl();
            Booking booking = bookingDAO.find(id);
            if (booking != null) {
                TicketDAO ticketDAO = new TicketDAOImpl();
                List<Ticket> tickets = ticketDAO.findAll();
                request.setAttribute("booking", booking);
                request.setAttribute("tickets", tickets);
                request.getRequestDispatcher("/editBooking.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("bookingAdmin?menu=list");
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Ambil data dari form
        String ticketId = request.getParameter("ticketId");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Validasi stock
        TicketDAO ticketDAO = new TicketDAOImpl();
        Ticket ticket = ticketDAO.find(ticketId);
        
        if (ticket != null && ticket.getStock() >= quantity) {
            // Create booking
            Booking booking = new Booking();
            // Set booking details
            
            // Update ticket stock
            ticket.setStock(ticket.getStock() - quantity);
            ticketDAO.update(ticket);

            BookingDAO bookingDAO = new BookingDAOImpl();
            bookingDAO.insert(booking);

            request.getSession().setAttribute("message", "Booking created successfully!");
        } else {
            request.getSession().setAttribute("error", "Insufficient ticket stock!");
        }
        
        response.sendRedirect("bookingAdmin?menu=list");
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        // Update other fields as needed

        BookingDAO bookingDAO = new BookingDAOImpl();
        Booking booking = bookingDAO.find(id);
        if (booking != null) {
            booking.setName(name);
            booking.setPhone(phone);
            // Set other updated fields

            bookingDAO.update(booking);
            request.getSession().setAttribute("message", "Booking updated successfully!");
        }
        
        response.sendRedirect("bookingAdmin?menu=list");
    }

    private void deleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            BookingDAO bookingDAO = new BookingDAOImpl();
            Booking booking = bookingDAO.find(id);
            if (booking != null) {
                // Return ticket stock
                TicketDAO ticketDAO = new TicketDAOImpl();
                Ticket ticket = ticketDAO.find(booking.getTicketId());
                if (ticket != null) {
                    ticket.setStock(ticket.getStock() + booking.getQuantity());
                    ticketDAO.update(ticket);
                }

                bookingDAO.delete(id);
                request.getSession().setAttribute("message", "Booking deleted successfully!");
            }
        }
        response.sendRedirect("bookingAdmin?menu=list");
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String id = request.getParameter("bookingId");
        if (id != null && !id.isEmpty()) {
            BookingDAO bookingDAO = new BookingDAOImpl();
            Booking booking = bookingDAO.find(id);
            if (booking != null) {
                // Return ticket stock
                TicketDAO ticketDAO = new TicketDAOImpl();
                Ticket ticket = ticketDAO.find(booking.getTicketId());
                if (ticket != null) {
                    ticket.setStock(ticket.getStock() + booking.getQuantity());
                    ticketDAO.update(ticket);
                }

                // Instead of deleting, you might want to update status to 'CANCELLED'
                bookingDAO.delete(id); // or update status if you have status field

                request.getSession().setAttribute("message", "Booking cancelled successfully!");
            }
        }
        response.sendRedirect("bookingAdmin?menu=list");
    }
}