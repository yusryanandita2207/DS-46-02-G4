package Models;

/**
 * Executive Ticket model
 */

public class Executive extends Ticket {
    private final double EXECUTIVE_PRICE_MULTIPLIER = 1.5;
    private String facilities;

    public Executive(String id, String reservationNumber, String travelDate,
                     String ticketStatus, String origin, String destination,
                     int stock, String departureTime, String arrivalTime,
                     double basePrice, String facilities) {
        super(id, reservationNumber, travelDate, ticketStatus, origin,
              destination, stock, departureTime, arrivalTime, basePrice);
        this.facilities = facilities;
           this.table = "ticket"; 
//           this.primaryKey = "id";
    }

    // Getter dan Setter untuk fasilitas
    public String getFacilities() {
        return facilities;
    }

    public void setFacilities(String facilities) {
        this.facilities = facilities;
    }

    // Metode untuk menghitung harga akhir
    public double getFinalPrice() {
        return getBasePrice() * 1.5;
    }
    
}
