package DAO;

import Models.Executive;
import Models.Ticket;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TicketDAOImpl implements TicketDAO{
    private Connection con;

        public TicketDAOImpl() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DatabaseConnection.getConnection();
    }
  @Override
    public void insert(Ticket ticket) throws Exception {
        String sql = "INSERT INTO ticket (reservationNumber, travelDate, ticketStatus, origin, destination, stock, departureTime, arrivalTime, basePrice, facilities) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, ticket.getReservationNumber());
            ps.setString(2, ticket.getTravelDate());
            ps.setString(3, ticket.getTicketStatus());
            ps.setString(4, ticket.getOrigin());
            ps.setString(5, ticket.getDestination());
            ps.setInt(6, ticket.getStock());
            ps.setString(7, ticket.getDepartureTime());
            ps.setString(8, ticket.getArrivalTime());
            ps.setDouble(9, ticket.getBasePrice());
            ps.setString(10, ticket instanceof Executive ? ((Executive) ticket).getFacilities() : null);

            int rows = ps.executeUpdate();
            System.out.println(rows + " rows inserted.");
        }
    }

    @Override
    public void update(Ticket ticket) throws Exception {
    String sql = "UPDATE ticket SET reservationNumber = ?, travelDate = ?, ticketStatus = ?, origin = ?, destination = ?, stock = ?, departureTime = ?, arrivalTime = ?, basePrice = ?, facilities = ? WHERE id = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, ticket.getReservationNumber());
        ps.setString(2, ticket.getTravelDate());
        ps.setString(3, ticket.getTicketStatus());
        ps.setString(4, ticket.getOrigin());
        ps.setString(5, ticket.getDestination());
        ps.setInt(6, ticket.getStock());
        ps.setString(7, ticket.getDepartureTime());
        ps.setString(8, ticket.getArrivalTime());
        ps.setDouble(9, ticket.getBasePrice());
        ps.setString(10, ticket instanceof Executive ? ((Executive) ticket).getFacilities() : null);
        ps.setString(11, ticket.getId());

        int rows = ps.executeUpdate();
        System.out.println(rows + " rows updated.");
    }
}

    @Override
    public void delete(String id) throws Exception {
        String sql = "DELETE FROM ticket WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            int rows = ps.executeUpdate();
            System.out.println(rows + " rows deleted.");
        }
    }

    @Override
   public Ticket find(String id) throws Exception {
    System.out.println("Finding ticket with ID: " + id);
    String sql = "SELECT * FROM ticket WHERE id = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            // Mapping data ke objek Ticket
            return new Ticket(
                rs.getString("id"),
                rs.getString("reservationNumber"),
                rs.getString("travelDate"),
                rs.getString("ticketStatus"),
                rs.getString("origin"),
                rs.getString("destination"),
                rs.getInt("stock"),
                rs.getString("departureTime"),
                rs.getString("arrivalTime"),
                rs.getDouble("basePrice")
            );
        }
    }
    return null; // Jika data tidak ditemukan
}


    @Override
    public List<Ticket> findAll() throws Exception {
        String sql = "SELECT * FROM ticket";
        List<Ticket> tickets = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tickets.add(new Ticket(
                    rs.getString("id"),
                    rs.getString("reservationNumber"),
                    rs.getString("travelDate"),
                    rs.getString("ticketStatus"),
                    rs.getString("origin"),
                    rs.getString("destination"),
                    rs.getInt("stock"),
                    rs.getString("departureTime"),
                    rs.getString("arrivalTime"),
                    rs.getDouble("basePrice")
                ));
            }
        }
        return tickets;
    }
}