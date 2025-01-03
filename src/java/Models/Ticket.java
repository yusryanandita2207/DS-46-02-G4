package Models;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Ticket model class
 */
public class Ticket extends Model<Ticket> {
    private String id;
    private String reservationNumber;
    private String travelDate;
    private String ticketStatus;
    private String origin;
    private String destination;
    private int stock;
    private double basePrice;
    private String departureTime;
    private String arrivalTime;
    private String ticketType;
    

    public Ticket() {
        this.table = "ticket";
        this.primaryKey = "id";
    }

    public Ticket(String id, String reservationNumber, 
                  String travelDate, String ticketStatus, String origin,
                  String destination, int stock, String departureTime,String arrivalTime,double basePrice,String ticketType) {
        this.table = "ticket";
        this.primaryKey = "id";
        this.id = id;
        this.reservationNumber = reservationNumber;
 
        this.travelDate = travelDate;
        this.ticketStatus = ticketStatus;
        this.origin = origin;
        this.destination = destination;
        this.stock = stock;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        setBasePrice(basePrice);
        setTicketType(ticketType);


    }



    public Ticket toModel(ResultSet rs) {
    try {
        String ticketType = rs.getString("ticketType");
        if ("Executive".equals(ticketType)) {
            return new Executive(
                    rs.getString("id"),
                    rs.getString("reservationNumber"),
                    rs.getString("travelDate"),
                    rs.getString("ticketStatus"),
                    rs.getString("origin"),
                    rs.getString("destination"),
                    rs.getInt("stock"),
                    rs.getString("departureTime"),    
                    rs.getString("arrivalTime"),
                    rs.getDouble("basePrice"),
                    rs.getString("facilities")  // Pastikan 'facilities' tidak null
            );
        } else {
            return new Regular(
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
    } catch (SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return null;
    }
}


        public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public String getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReservationNumber() {
        return reservationNumber;
    }

    public void setReservationNumber(String reservationNumber) {
        this.reservationNumber = reservationNumber;
    }


    public String getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(String travelDate) {
        this.travelDate = travelDate;
    }

    public String getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }
    
}
