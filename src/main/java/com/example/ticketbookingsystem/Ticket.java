package com.example.ticketbookingsystem;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Projections;
import org.bson.conversions.Bson;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static com.mongodb.client.model.Filters.eq;

public class Ticket extends Database{
    private MongoCollection<TicketStruct> collection = database.getCollection("tickets", TicketStruct.class);
    public List<String> getBookedSeats(int TMDBid, String showtime, String showdate){
        Bson filter = Filters.and(Filters.eq("TMDBid", TMDBid), Filters.eq("showtime", showtime), Filters.eq("showdate", showdate));
        MongoIterable<TicketStruct> ticket = collection.find(filter).projection(Projections.include("seats"));
        Iterator<TicketStruct> iterator = ticket.iterator();
        List<String> seats = new ArrayList<>();
        while(iterator.hasNext()){
            for (String seat : iterator.next().seats) {
                if(!seats.contains(seat))
                    seats.add(seat);
            }
        }
        return seats;
    }
}
