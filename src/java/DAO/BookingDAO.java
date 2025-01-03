package DAO;

import Models.Booking;
import java.util.List;

public interface BookingDAO {
    void insert(Booking booking) throws Exception;
    void update(Booking booking) throws Exception;
    void delete(String id) throws Exception;
    Booking find(String id) throws Exception;
    List<Booking> findAll() throws Exception;
//    List<Booking> findByName(String name) throws Exception;
}   