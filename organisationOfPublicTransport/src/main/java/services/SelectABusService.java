package services;

import java.sql.Connection;
import java.sql.ResultSet;

import database.BusQueries;
import database.EstablishConnection;
import javafx.concurrent.Task;
import models.Bus;

public class SelectABusService extends Task<Bus> {

	int id;
	
	public SelectABusService(int id){
		this.id = id;
	}
	
	@Override
	protected Bus call() throws Exception {
		
		Connection conn = EstablishConnection.establishConnection(false, null);
		Bus bus = null;
		if(conn.isValid(0)) {
			ResultSet rs = BusQueries.selectNotBrokenBusQueryById(id, conn);
			
			while(rs.next()) {
				int busId = rs.getInt("BusId");
				String busName = rs.getString("BusName");
				int currentRouteId = rs.getInt("CurrentRouteId");
				int currentTerminalId = rs.getInt("CurrentTerminalId");
				boolean broken = rs.getBoolean("Broken");
				boolean charging = rs.getBoolean("Charging");
				int battery = rs.getInt("Battery");
				int delay = rs.getInt("Delay");

				bus = new Bus(busId, busName, currentRouteId, currentTerminalId, broken, charging, battery, delay);
				
			}
			
			conn.close();
			
			return bus;
			
		} else {
			System.out.println("SelectABusService: Connection is down");
		}
		conn.close();
		return null;
	}

}
