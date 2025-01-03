/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Os 10
 */
public class ShuttleService {
    private String id;
    private String name;
    private int capacity;
    private int availableSeats;

    public ShuttleService(String id, String name, int capacity, int availableSeats) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.availableSeats = availableSeats;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getCapacity() {
        return capacity;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }

    public boolean hasAvailableSeats(int numSeatsRequired) {
        return availableSeats >= numSeatsRequired;
    }

    public void bookShuttleSeats(int numSeats) {
        availableSeats -= numSeats;
    }
}
