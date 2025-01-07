package Controllers;

import DAO.BookingDAO;
import DAO.BookingDAOImpl;
import DAO.PaymentDAO;
import DAO.PaymentDAOImpl;
import DAO.TicketDAO;
import DAO.TicketDAOImpl;
import Models.Booking;
import Models.Payment;
import Models.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet(name = "PaymentController", urlPatterns = {"/payment"})
public class PaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        if (menu == null) menu = "list";

        try {
            switch (menu) {
                case "process":
                    showPaymentForm(request, response);
                    break;
                case "list":
                    listPayments(request, response);
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
                case "process":
                    processPayment(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showPaymentForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String bookingId = request.getParameter("bookingId");
        BookingDAO bookingDAO = new BookingDAOImpl();
        Booking booking = bookingDAO.find(bookingId);

        if (booking != null) {
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/payment.jsp").forward(request, response);
        } else {
            response.sendRedirect("booking?menu=list");
        }
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String bookingId = request.getParameter("bookingId");
        String paymentMethod = request.getParameter("paymentMethod");
        double amount = Double.parseDouble(request.getParameter("amount"));
                
                BookingDAO bookingDAO = new BookingDAOImpl();
                Booking booking = bookingDAO.find(bookingId);
                
                TicketDAO ticketDAO = new TicketDAOImpl();
                Ticket ticket = ticketDAO.find(booking.getTicketId());

        Payment payment = new Payment();
        payment.setId(UUID.randomUUID().toString());
        payment.setBookingId(bookingId);
        payment.setAmount(amount);
        payment.setPaymentMethod(paymentMethod);
        payment.setPaymentStatus("PENDING");
        payment.setPaymentDate(new Date());
        payment.setTransactionId(UUID.randomUUID().toString());

        PaymentDAO paymentDAO = new PaymentDAOImpl();
        paymentDAO.insert(payment);

        // Simulasi proses pembayaran
        // Dalam implementasi nyata, ini akan terhubung ke payment gateway
        payment.setPaymentStatus("SUCCESS");
        paymentDAO.update(payment);
        request.setAttribute("booking", booking);
                request.setAttribute("ticket", ticket);
                request.setAttribute("payment", payment);

    request.getSession().setAttribute("message", "Payment processed successfully!");
//    response.sendRedirect("booking?menu=list"); 
 request.getRequestDispatcher("/eticket.jsp").forward(request, response);
    }

    private void listPayments(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        PaymentDAO paymentDAO = new PaymentDAOImpl();
        request.setAttribute("payments", paymentDAO.findAll());
        request.getRequestDispatcher("/bookTicket.jsp").forward(request, response);
    }
}