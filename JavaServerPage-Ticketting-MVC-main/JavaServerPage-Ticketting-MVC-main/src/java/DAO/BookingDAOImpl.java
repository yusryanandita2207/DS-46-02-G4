package DAO;

import Models.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BookingDAOImpl implements BookingDAO {
    private Connection con;

    public BookingDAOImpl() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DatabaseConnection.getConnection();
    }

    @Override
    public void insert(Booking booking) throws Exception {
        String sql = "INSERT INTO booking (id, ticketId, name, phone, birthDate, bookingDate, quantity) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, booking.getId());
            ps.setString(2, booking.getTicketId());
            ps.setString(3, booking.getName());
            ps.setString(4, booking.getPhone());
            ps.setDate(5, new java.sql.Date(booking.getBirthDate().getTime()));
            ps.setTimestamp(6, new java.sql.Timestamp(booking.getBookingDate().getTime()));
            ps.setInt(7, booking.getQuantity());

            int rowsAffected = ps.executeUpdate();
            System.out.println(rowsAffected + " booking inserted.");
        }
    }

    @Override
    public void update(Booking booking) throws Exception {
        String sql = "UPDATE booking SET ticketId=?, name=?, phone=?, birthDate=?, bookingDate=?, quantity=? WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, booking.getTicketId());
            ps.setString(2, booking.getName());
            ps.setString(3, booking.getPhone());
            ps.setDate(4, new java.sql.Date(booking.getBirthDate().getTime()));
            ps.setTimestamp(5, new java.sql.Timestamp(booking.getBookingDate().getTime()));
            ps.setInt(6, booking.getQuantity());
            ps.setString(7, booking.getId());

            int rowsAffected = ps.executeUpdate();
            System.out.println(rowsAffected + " booking updated.");
        }
    }

    @Override
    public void delete(String id) throws Exception {
        String sql = "DELETE FROM booking WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            int rowsAffected = ps.executeUpdate();
            System.out.println(rowsAffected + " booking deleted.");
        }
    }

    @Override
    public Booking find(String id) throws Exception {
        String sql = "SELECT * FROM booking WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Booking(
                        rs.getString("id"),
                        rs.getString("ticketId"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getDate("birthDate"),
                        rs.getTimestamp("bookingDate"),
                        rs.getInt("quantity")
                    );
                }
            }
        }
        return null;
    }

    @Override
    public List<Booking> findAll() throws Exception {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM booking";
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getString("id"),
                    rs.getString("ticketId"),
                    rs.getString("name"),
                    rs.getString("phone"),
                    rs.getDate("birthDate"),
                    rs.getTimestamp("bookingDate"),
                    rs.getInt("quantity")
                );
                bookings.add(booking);
            }
        }
        return bookings;
    }
}