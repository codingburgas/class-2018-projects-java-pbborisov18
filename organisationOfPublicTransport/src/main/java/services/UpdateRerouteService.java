package services;

import java.sql.Connection;
import java.time.LocalTime;

import database.BrokenBusQuery;
import database.RoutesQuery;
import javafx.concurrent.Task;

public class UpdateRerouteService extends Task<Void> {
	
	int id;
	LocalTime duration;
	LocalTime startIntervals;
	
	public UpdateRerouteService(int id, LocalTime duration, LocalTime startIntervals) {
		this.id = id;
		this.duration = duration;
		this.startIntervals = startIntervals;
	}
	
	@Override
	protected Void call() throws Exception {
		Connection conn = RoutesQuery.establishConnection();
		
		if(conn.isValid(0)) {
			RoutesQuery.executeUpdateRoute(id, duration, startIntervals);
			
		} else {
			System.out.println("connection failed");
		}
		
		conn.close();
		
		return null;
	}

}
