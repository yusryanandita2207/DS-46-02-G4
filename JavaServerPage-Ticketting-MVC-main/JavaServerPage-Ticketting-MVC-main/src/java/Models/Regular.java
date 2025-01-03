package Models;

/**
 * Regular Ticket model
 */
public class Regular extends Ticket {
    public Regular(String id, String reservationNumber, String travelDate, String ticketStatus,
                   String origin, String destination, int stock, 
                   String departureTime, String arrivalTime,double basePrice) {
        super(id, reservationNumber, travelDate, ticketStatus, origin, destination, stock,
              departureTime, arrivalTime,basePrice);
               this.table = "ticket"; 
//           this.primaryKey = "id";
    }

    public double getFinalPrice() {
        return getBasePrice();
    }
}

//    @Override
//    public String toString() {
//        return "Regular Ticket [id=" + getId() +
//               ", passengerName=" + getPassengerName() +
//               ", travelDate=" + getTravelDate() +
//               ", ticketStatus=" + getTicketStatus() +
//               ", origin=" + getOrigin() +
//               ", destination=" + getDestination() +
//               ", basePrice=" + getBasePrice() +
//               ", finalPrice=" + getFinalPrice() + "]";
//    }


    
