package Models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Booking extends Model<Booking> {
    private String id;
    private String ticketId;
    private String name;
    private String phone;
    private Date birthDate;
    private Date bookingDate;
    private int quantity;

    public Booking() {
        this.table = "booking";
        this.primaryKey = "id";
    }

    public Booking(String id, String ticketId, String name, String phone, Date birthDate, Date bookingDate, int quantity) {
        this.id = id;
        this.ticketId = ticketId;
        this.name = name;
        this.phone = phone;
        this.birthDate = birthDate;
        this.bookingDate = bookingDate;
        this.quantity = quantity;
    }
    

    // Getter dan Setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTicketId() {
        return ticketId;
    }

    public void setTicketId(String ticketId) {
        this.ticketId = ticketId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    Booking toModel(ResultSet rs) {
        try {
            return new Booking(
                rs.getString("id"),
                rs.getString("ticketId"),
                rs.getString("name"),
                rs.getString("phone"),
                rs.getDate("birthDate"),
                rs.getTimestamp("bookingDate"),
                rs.getInt("quantity")
            );
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            return null;
        }
    }
}