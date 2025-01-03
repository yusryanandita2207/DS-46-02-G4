package Models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Payment extends Model<Payment> {
    private String id;
    private String bookingId;
    private double amount;
    private String paymentMethod;
    private String paymentStatus;
    private Date paymentDate;
    private String transactionId;

    public Payment() {
        this.table = "payment";
        this.primaryKey = "id";
    }

    public Payment(String id, String bookingId, double amount, String paymentMethod, 
                  String paymentStatus, Date paymentDate, String transactionId) {
        this.id = id;
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.paymentDate = paymentDate;
        this.transactionId = transactionId;
        this.table = "payment";
        this.primaryKey = "id";
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }
    
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }
    
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    @Override
    Payment toModel(ResultSet rs) {
        try {
            return new Payment(
                rs.getString("id"),
                rs.getString("bookingId"),
                rs.getDouble("amount"),
                rs.getString("paymentMethod"),
                rs.getString("paymentStatus"),
                rs.getTimestamp("paymentDate"),
                rs.getString("transactionId")
            );
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            return null;
        }
    }
}