package Models;

/**
 * Regular Ticket model
 */
public class Regular extends Ticket {

    private final Object facilities;
    public Regular(String id, String reservationNumber, String travelDate, String ticketStatus,
                   String origin, String destination, int stock, 
                   String departureTime, String arrivalTime,double basePrice) {
        super(id, reservationNumber, travelDate, ticketStatus, origin, destination, stock,
              departureTime, arrivalTime,basePrice,"Regular");
               this.table = "ticket"; 
               this.facilities = null;
//           this.primaryKey = "id";
    }

    public double getFinalPrice() {
        return getBasePrice();
    }
}


    
