package services;


import java.sql.Connection;

import database.BrokenBusQuery;
import javafx.concurrent.Task;
import models.Bus;

public class UpdateABusService extends Task<Bus>{

	int id;
	
	public UpdateABusService(int id) {
		this.id = id;
	}
	
	@Override
	protected Bus call() throws Exception {
		
		Connection conn = BrokenBusQuery.establishConnection();
		
		if(conn.isValid(0)) {
			BrokenBusQuery.executeBreakABusQuery(id);
			
			
		} else {
			System.out.println("connection failed");
		}
		
		return null;
	}

}
