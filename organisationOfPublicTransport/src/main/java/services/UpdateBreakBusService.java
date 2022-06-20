package services;


import java.sql.Connection;

import database.BusQueries;
import javafx.concurrent.Task;

public class UpdateBreakBusService extends Task<Void>{

	private int id;
	
	public UpdateBreakBusService(int id) {
		this.id = id;
	}
	
	@Override
	protected Void call() throws Exception {
		
		Connection conn = BusQueries.establishConnection();
		
		if(conn.isValid(0)) {
			BusQueries.updateBreakABusQueryById(id);
			
		} else {
			System.out.println("connection failed");
		}
		conn.close();
		return null;
	}

}
