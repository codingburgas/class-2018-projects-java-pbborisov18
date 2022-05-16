package services;

import java.sql.Connection;

import database.BrokenBusQuery;
import javafx.concurrent.Task;

public class UpdateFixBusService extends Task<Void>{

	private int id;
	private int terminalId;
	
	public UpdateFixBusService(int id, int terminalId) {
		this.id = id;
		this.terminalId = terminalId;
	}
	
	@Override
	protected Void call() throws Exception {
		
		Connection conn = BrokenBusQuery.establishConnection();
		
		if(conn.isValid(0)) {
			BrokenBusQuery.executeFixABusQuery(id, terminalId);
		} else {
			System.out.println("connection failed");
		}
		conn.close();
		return null;
	}
}
