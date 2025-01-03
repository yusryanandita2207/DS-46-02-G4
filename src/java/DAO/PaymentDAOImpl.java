package DAO;

import Models.Payment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAOImpl implements PaymentDAO {
    private Connection con;

    public PaymentDAOImpl() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DatabaseConnection.getConnection();
    }

    @Override
    public void insert(Payment payment) throws Exception {
        String sql = "INSERT INTO payment (id, bookingId, amount, paymentMethod, paymentStatus, paymentDate, transactionId) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, payment.getId());
            ps.setString(2, payment.getBookingId());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMethod());
            ps.setString(5, payment.getPaymentStatus());
            ps.setTimestamp(6, new java.sql.Timestamp(payment.getPaymentDate().getTime()));
            ps.setString(7, payment.getTransactionId());
            
            ps.executeUpdate();
        }
    }

    @Override
    public void update(Payment payment) throws Exception {
        String sql = "UPDATE payment SET bookingId=?, amount=?, paymentMethod=?, paymentStatus=?, paymentDate=?, transactionId=? WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, payment.getBookingId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getPaymentMethod());
            ps.setString(4, payment.getPaymentStatus());
            ps.setTimestamp(5, new java.sql.Timestamp(payment.getPaymentDate().getTime()));
            ps.setString(6, payment.getTransactionId());
            ps.setString(7, payment.getId());
            
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(String id) throws Exception {
        String sql = "DELETE FROM payment WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public Payment find(String id) throws Exception {
        String sql = "SELECT * FROM payment WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Payment(
                    rs.getString("id"),
                    rs.getString("bookingId"),
                    rs.getDouble("amount"),
                    rs.getString("paymentMethod"),
                    rs.getString("paymentStatus"),
                    rs.getTimestamp("paymentDate"),
                    rs.getString("transactionId")
                );
            }
        }
        return null;
    }

    @Override
    public List<Payment> findAll() throws Exception {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payment";
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                payments.add(new Payment(
                    rs.getString("id"),
                    rs.getString("bookingId"),
                    rs.getDouble("amount"),
                    rs.getString("paymentMethod"),
                    rs.getString("paymentStatus"),
                    rs.getTimestamp("paymentDate"),
                    rs.getString("transactionId")
                ));
            }
        }
        return payments;
    }

    @Override
    public Payment findByBookingId(String bookingId) throws Exception {
        String sql = "SELECT * FROM payment WHERE bookingId=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Payment(
                    rs.getString("id"),
                    rs.getString("bookingId"),
                    rs.getDouble("amount"),
                    rs.getString("paymentMethod"),
                    rs.getString("paymentStatus"),
                    rs.getTimestamp("paymentDate"),
                    rs.getString("transactionId")
                );
            }
        }
        return null;
    }

    @Override
    public List<Payment> findByStatus(String status) throws Exception {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payment WHERE paymentStatus=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                payments.add(new Payment(
                    rs.getString("id"),
                    rs.getString("bookingId"),
                    rs.getDouble("amount"),
                    rs.getString("paymentMethod"),
                    rs.getString("paymentStatus"),
                    rs.getTimestamp("paymentDate"),
                    rs.getString("transactionId")
                ));
            }
        }
        return payments;
    }
}