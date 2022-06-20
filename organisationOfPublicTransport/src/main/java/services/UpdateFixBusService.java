package services;

import java.sql.Connection;
import java.sql.SQLException;

import database.BusQueries;
import database.EstablishConnection;
import javafx.concurrent.Task;

public class UpdateFixBusService extends Task<Void>{

	private int id;
	private int terminalId;
	
	public UpdateFixBusService(int id, int terminalId) {
		this.id = id;
		this.terminalId = terminalId;
	}
	
	@Override
	protected Void call() {
		
		
		try {
			Connection conn = EstablishConnection.establishConnection(false, null);
			if(conn.isValid(0)) {
				BusQueries.updateFixABusQuery(id, terminalId, conn);
			} else {
				System.out.println("connection failed");
			}
			conn.close();
		} catch (InterruptedException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}
}
