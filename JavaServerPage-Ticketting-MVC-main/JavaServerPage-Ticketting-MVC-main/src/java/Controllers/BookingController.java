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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@WebServlet(name = "BookingController", urlPatterns = {"/booking"})
public class BookingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");

        if (menu == null) menu = "list";

        try {
            switch (menu) {
                case "view":
                    viewBooking(request, response);
                    break;
                case "list":
                    listBookings(request, response);
                    break;
                case "book":
                    showBookingForm(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
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
                case "book":
                    processBooking(request, response);
                    break;
                case "cancel":
                    cancelBooking(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showBookingForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String ticketId = request.getParameter("id");
        TicketDAO ticketDAO = new TicketDAOImpl();
        Ticket ticket = ticketDAO.find(ticketId);

        if (ticket != null) {
            request.setAttribute("ticket", ticket);
            request.getRequestDispatcher("/bookTicket.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void processBooking(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
    try {
        String ticketId = request.getParameter("ticketId");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        
        // Validasi format tanggal
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        Date birthDate = sdf.parse(request.getParameter("birthDate"));
        
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if (name == null || name.trim().isEmpty()) {
            throw new Exception("Name is required");
        }
        if (phone == null || !phone.matches("\\d{10,12}")) {
            throw new Exception("Invalid phone number");
        }
        if (quantity <= 0) {
            throw new Exception("Invalid quantity");
        }

        TicketDAO ticketDAO = new TicketDAOImpl();
        Ticket ticket = ticketDAO.find(ticketId);

        if (ticket == null) {
            throw new Exception("Ticket not found");
        }

        // Validasi ketersediaan tiket
        if (ticket.getStock() < quantity) {
            request.setAttribute("error", "Insufficient ticket stock");
            request.setAttribute("ticket", ticket);
            request.getRequestDispatcher("/bookTicket.jsp").forward(request, response);
            return;
        }

        // Kurangi stok
        ticket.setStock(ticket.getStock() - quantity);
        ticketDAO.update(ticket);

        // Buat booking
        Booking booking = new Booking();
        booking.setId(UUID.randomUUID().toString());
        booking.setTicketId(ticketId);
        booking.setName(name);
        booking.setPhone(phone);
        booking.setBirthDate(birthDate);
        booking.setBookingDate(new Date());
        booking.setQuantity(quantity);

        BookingDAO bookingDAO = new BookingDAOImpl();
        bookingDAO.insert(booking);

        request.getSession().setAttribute("message", "Booking successful!");
         response.sendRedirect("payment?menu=process&bookingId=" + booking.getId());
//        response.sendRedirect("booking?menu=list");
        
    } catch (Exception e) {
        request.setAttribute("error", e.getMessage());
        showBookingForm(request, response);
    }
}

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String bookingId = request.getParameter("bookingId");

        BookingDAO bookingDAO = new BookingDAOImpl();
        Booking booking = bookingDAO.find(bookingId);

        if (booking != null) {
            // Kembalikan stok
            TicketDAO ticketDAO = new TicketDAOImpl();
            Ticket ticket = ticketDAO.find(booking.getTicketId());
            ticket.setStock(ticket.getStock() + booking.getQuantity());
            ticketDAO.update(ticket);

            // Batalkan booking
            bookingDAO.delete(bookingId);

            request.getSession().setAttribute("message", "Booking cancelled successfully");
            response.sendRedirect("booking?menu=list");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
private void viewBooking(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
    String ticketId = request.getParameter("id");
    
    try {
        TicketDAO ticketDAO = new TicketDAOImpl();
        Ticket ticket = ticketDAO.find(ticketId);

        if (ticket != null) {
            request.setAttribute("ticket", ticket);
            request.getRequestDispatcher("/bookTicket.jsp").forward(request, response);
        } else {
            // Jika tiket tidak ditemukan, redirect ke halaman utama
            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp"); 
    }
}

    private void listBookings(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        BookingDAO bookingDAO = new BookingDAOImpl();
        request.setAttribute("bookings", bookingDAO.findAll());
        request.getRequestDispatcher("/listBookings.jsp").forward(request, response);
    }
}