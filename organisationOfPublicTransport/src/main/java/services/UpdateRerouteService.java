package services;

import java.sql.Connection;
import java.time.LocalTime;

import database.RoutesQueries;
import javafx.concurrent.Task;
import javafx.scene.control.Button;

public class UpdateRerouteService extends Task<Integer> {
	
	int id;
	private Button update; 
	LocalTime duration;
	LocalTime startIntervals;
	
	public UpdateRerouteService(int id, LocalTime duration, LocalTime startIntervals, Button update) {
		this.id = id;
		this.duration = duration;
		this.startIntervals = startIntervals;
		this.update = update;
	}
	
	@Override
	protected Integer call() throws Exception {
		Connection conn = RoutesQueries.establishConnection();
		int successful = 0;
		
		
		if(conn.isValid(0)) {
			//0 - failed to update
			//1 - updated successfully
			successful = RoutesQueries.updateRouteById(id, duration, startIntervals);
		} else {
			System.out.println("connection failed");
		}
		
		conn.close();
		
		return successful;
	}
	


}
