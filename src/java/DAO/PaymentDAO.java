package DAO;

import Models.Payment;
import java.util.List;

public interface PaymentDAO {
    void insert(Payment payment) throws Exception;
    void update(Payment payment) throws Exception;
    void delete(String id) throws Exception;
    Payment find(String id) throws Exception;
    List<Payment> findAll() throws Exception;
    Payment findByBookingId(String bookingId) throws Exception;
    List<Payment> findByStatus(String status) throws Exception;
}