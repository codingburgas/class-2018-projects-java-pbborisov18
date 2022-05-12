package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.BusQuery;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Bus;

public class BusesService extends Task<ObservableList<Bus>> {

	@Override
	protected ObservableList<Bus> call() throws Exception {
		
		Connection conn = BusQuery.establishConnection();
		ObservableList<Bus> busses = null;
		
		if(conn.isValid(0)) {
			
			busses = FXCollections.observableArrayList();
			ResultSet rs = BusQuery.executeBusQuery(1, true);	
			
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
				
				busses.add(a);
			}
		}
		return busses;
	}
	
	
	public ObservableList<Bus> getBusses(int id, boolean flag) throws InterruptedException, SQLException{
		Connection conn = BusQuery.establishConnection();
		ObservableList<Bus> busses = null;
		
		busses = FXCollections.observableArrayList();
		//if flag is true retrieves all busses
		ResultSet rs = BusQuery.executeBusQuery(id, flag);	
		
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
			
			busses.add(a);
		}
		
		return busses;
	}
	
	
	
}
