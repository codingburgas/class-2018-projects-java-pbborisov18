package services;

import java.sql.Connection;
import java.sql.ResultSet;

import database.BrokenBusQuery;
import database.TerminalQuery;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Bus;
import models.Terminal;

public class BrokenBusService extends Task<ObservableList<Bus>> {

	
	@Override
	protected ObservableList<Bus> call() throws Exception {
		
		Connection conn = BrokenBusQuery.establishConnection();
		ObservableList<Bus> buses = FXCollections.observableArrayList();
		
		if(conn.isValid(0)) {
			ResultSet rs = BrokenBusQuery.executeSelectBrokenBusesQuery();
			
			while(rs.next()) {
				
				int busId = rs.getInt("BusId");
				String busName = rs.getString("BusName");
				int currentRouteId = rs.getInt("CurrentRouteId");
				int currentTerminalId = rs.getInt("CurrentTerminalId");
				boolean broken = rs.getBoolean("Broken");
				boolean charging = rs.getBoolean("Charging");
				int battery = rs.getInt("Battery");
				int delay = rs.getInt("Delay");

				Bus a = new Bus(busId, busName, currentRouteId, currentTerminalId, broken, charging, battery, delay);
				
				buses.add(a);
			}
		}
		conn.close();
		return buses;
	}

}
