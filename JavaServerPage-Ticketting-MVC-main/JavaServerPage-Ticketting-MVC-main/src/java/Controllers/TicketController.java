package Controllers;

import DAO.TicketDAO;
import DAO.TicketDAOImpl;
import Models.Executive;
import Models.Regular;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Models.Ticket;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Controller for managing Ticket operations
 */
@WebServlet(name = "TicketController", urlPatterns = {"/ticket"})
public class TicketController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        if (session.getAttribute("user") == null) {
//            response.sendRedirect("index.jsp");
//            return;
//        }

        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("tiketting?menu=admin");
            return;
        }

        Ticket ticketModel = new Ticket();

        if ("view".equals(menu)) {
            List<Ticket> tickets = new ArrayList<>();
            try {
                tickets = ticketModel.get();
                request.setAttribute("tickets", tickets);
                request.getRequestDispatcher("/ticketAdmin.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to fetch tickets: " + e.getMessage());
                request.getRequestDispatcher("/ticketAdmin.jsp").forward(request, response);
            }
        } else if ("add".equals(menu)) {
            request.getRequestDispatcher("/addTicketByAdmin.jsp").forward(request, response);

        } else if ("edit".equals(menu)) {
             String id = request.getParameter("id"); // Pastikan ID tiket diterima
    if (id != null && !id.isEmpty()) {
        try {
            TicketDAO ticketDAO = new TicketDAOImpl();
            Ticket ticket = ticketDAO.find(id); // Ambil tiket dari database
            if (ticket != null) {
                request.setAttribute("ticket", ticket); // Set tiket ke request
                request.getRequestDispatcher("/editTicket.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("error", "Ticket not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching ticket: " + e.getMessage());
        }
    } else {
        request.setAttribute("error", "Invalid ticket ID.");
    }
    response.sendRedirect("ticket?menu=view");
    }
   }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String action = request.getParameter("action");
          Ticket ticketModel = new Ticket();

    if ("add".equals(action)) {
        try {
            TicketDAO ticketDAO = new TicketDAOImpl();
            String reservationNumber = request.getParameter("reservationNumber");
            String travelDate = request.getParameter("travelDate");
            String ticketStatus = request.getParameter("ticketStatus");
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");
            int stock = Integer.parseInt(request.getParameter("stock")); 
            String departureTime = request.getParameter("departureTime");
            String arrivalTime = request.getParameter("arrivalTime");
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            String ticketType = request.getParameter("ticketType");
            
           
            if (reservationNumber == null || reservationNumber.isEmpty()) {
                throw new Exception("Reservation number is required.");
            }
            if (!"active".equalsIgnoreCase(ticketStatus) && !"cancelled".equalsIgnoreCase(ticketStatus) && !"Available".equalsIgnoreCase(ticketStatus)) {
                throw new Exception("Invalid ticket status: " + ticketStatus);
            }
            if (reservationNumber == null || reservationNumber.isEmpty()) {
                throw new Exception("Reservation number is required.");
            }
                            // Validate time format
                if (!departureTime.matches("\\d{2}:\\d{2}:\\d{2}")) {
                    departureTime += ":00";
                }
                if (!arrivalTime.matches("\\d{2}:\\d{2}:\\d{2}")) {
                    arrivalTime += ":00";
                }


            if ("Executive".equals(ticketType)) {
                String facilities = request.getParameter("facilities");
                ticketModel = new Executive(
                    "",
                    reservationNumber,
                    travelDate,
                    ticketStatus,
                    origin,
                    destination,
                    stock,
                    departureTime,
                    arrivalTime,
                    basePrice,
                    facilities
                );
            } else {
                ticketModel = new Regular(
                    "",
                    reservationNumber,
                    travelDate,
                    ticketStatus,
                    origin,
                    destination,
                    stock,
                    departureTime,
                    arrivalTime,
                    basePrice
                );
            }

            ticketDAO.insert(ticketModel);
            System.out.println("Reservation Number: " + reservationNumber);
            System.out.println("Travel Date: " + travelDate);
            System.out.println("Ticket Status: " + ticketStatus);

//               if (ticketModel.getMessage().contains("error")) {
//                   throw new Exception(ticketModel.getMessage());
//               }
//               
            request.getSession().setAttribute("message", "Ticket added successfully!");
            response.sendRedirect("ticket?menu=view");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to add ticket: " + e.getMessage());
            request.getRequestDispatcher("/addTicketByAdmin.jsp").forward(request, response);
            return;
        }
    }
            else if ("edit".equals(action)) {
                try {
                    TicketDAO ticketDAO = new TicketDAOImpl();

                    String id = request.getParameter("id");
                    String reservationNumber = request.getParameter("reservationNumber");
                    String travelDate = request.getParameter("travelDate");
                    String ticketStatus = request.getParameter("ticketStatus");
                    String origin = request.getParameter("origin");
                    String destination = request.getParameter("destination");
                    int stock = Integer.parseInt(request.getParameter("stock"));
                    String departureTime = request.getParameter("departureTime");
                    String arrivalTime = request.getParameter("arrivalTime");
                    double basePrice = Double.parseDouble(request.getParameter("basePrice"));
                    String ticketType = request.getParameter("ticketType");

                    // Validate mandatory fields
                    if (id == null || id.isEmpty()) {
                        throw new Exception("Ticket ID is required for editing.");
                    }
                    if (reservationNumber == null || reservationNumber.isEmpty()) {
                        throw new Exception("Reservation number is required.");
                    }

                    // Validate time format
                    if (!departureTime.matches("\\d{2}:\\d{2}:\\d{2}")) {
                        departureTime += ":00";
                    }
                    if (!arrivalTime.matches("\\d{2}:\\d{2}:\\d{2}")) {
                        arrivalTime += ":00";
                    }

                    Ticket ticket;

                    if ("Executive".equals(ticketType)) {
                        String facilities = request.getParameter("facilities");
                        ticket = new Executive(
                            id,
                            reservationNumber,
                            travelDate,
                            ticketStatus,
                            origin,
                            destination,
                            stock,
                            departureTime,
                            arrivalTime,
                            basePrice,
                            facilities
                        );
                    } else {
                        ticket = new Regular(
                            id,
                            reservationNumber,
                            travelDate,
                            ticketStatus,
                            origin,
                            destination,
                            stock,
                            departureTime,
                            arrivalTime,
                            basePrice
                        );
                    }

                    // Call update method in DAO
                    ticketDAO.update(ticket);
                    HttpSession session = request.getSession();
                    session.setAttribute("message", "Ticket updated successfully!");
                    System.out.println(request.getAttribute("message"));
                    response.sendRedirect("ticket?menu=view");
                    return;

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to update ticket: " + e.getMessage());
                    request.getRequestDispatcher("/ticket/edit.jsp").forward(request, response);
                    
                    return;
                }

        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            ticketModel.setId(id);
            ticketModel.delete();
        }

        response.sendRedirect("ticket?menu=view");
    }

    @Override
    public String getServletInfo() {
        return "Controller for managing tickets";
    }
}
