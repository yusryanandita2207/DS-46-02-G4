/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Ticket;
import java.util.List;

public interface TicketDAO {
    void insert(Ticket ticket) throws Exception;
    void update(Ticket ticket) throws Exception;
    void delete(String id) throws Exception;
    Ticket find(String id) throws Exception;
    List<Ticket> findAll() throws Exception;
}