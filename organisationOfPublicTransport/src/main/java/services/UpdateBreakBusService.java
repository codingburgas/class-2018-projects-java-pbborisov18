package services;


import java.sql.Connection;

import database.BusQueries;
import database.EstablishConnection;
import javafx.concurrent.Task;

public class UpdateBreakBusService extends Task<Void>{

	private int id;
	
	public UpdateBreakBusService(int id) {
		this.id = id;
	}
	
	@Override
	protected Void call() throws Exception {
		
		Connection conn = EstablishConnection.establishConnection(false, null);
		
		if(conn.isValid(0)) {
			BusQueries.updateBreakABusQueryById(id, conn);
			
		} else {
			System.out.println("connection failed");
		}
		conn.close();
		return null;
	}

}
