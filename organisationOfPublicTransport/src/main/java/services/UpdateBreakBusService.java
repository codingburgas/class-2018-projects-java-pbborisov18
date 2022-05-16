package services;


import java.sql.Connection;

import database.BrokenBusQuery;
import javafx.concurrent.Task;

public class UpdateBreakBusService extends Task<Void>{

	private int id;
	
	public UpdateBreakBusService(int id) {
		this.id = id;
	}
	
	@Override
	protected Void call() throws Exception {
		
		Connection conn = BrokenBusQuery.establishConnection();
		
		if(conn.isValid(0)) {
			BrokenBusQuery.executeBreakABusQuery(id);
			
			
		} else {
			System.out.println("connection failed");
		}
		conn.close();
		return null;
	}

}
