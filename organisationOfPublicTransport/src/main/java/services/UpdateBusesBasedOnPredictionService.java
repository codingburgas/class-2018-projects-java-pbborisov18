package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;

import database.ActionsQueries;
import database.BusQueries;
import database.EstablishConnection;
import javafx.collections.FXCollections;
import javafx.concurrent.Task;
import models.Action;
import models.Bus;
import models.Route;

public class UpdateBusesBasedOnPredictionService extends Task<Void>{
	
	@Override
	protected Void call() throws Exception {
		ArrayList<Bus> buses = getBuses();
		ArrayList<Action> actions = getActions();
		
		System.out.println(buses);
		System.out.println(actions);
		
		return null;
	}
	
	private ArrayList<Bus> getBuses() throws InterruptedException, SQLException{
		ArrayList<Bus> buses = new ArrayList<>();
		
		Connection conn = EstablishConnection.establishConnection(false, null);
		
		if(conn.isValid(0)) {
			
			ResultSet rs = BusQueries.selectBusQueryByTerminalNotBroken(0, true, conn);
			
			while(rs.next()) {
				
				int busId = rs.getInt("BusId");
				String busName = rs.getString("BusName");
				int currentRouteId = rs.getInt("CurrentRouteId");
				int currentTerminalId = rs.getInt("CurrentTerminalId");
				boolean broken = rs.getBoolean("Broken");
				boolean charging = rs.getBoolean("Charging");
				int battery = rs.getInt("Battery");
				int delay = rs.getInt("Delay");

				Bus bus = new Bus(busId, busName, currentRouteId, currentTerminalId, broken, charging, battery, delay);
				
				buses.add(bus);
			}
		
		} else {
			System.out.println("UpdateBusesBasedOnPredictionService: Connection is down");
		}
		
		conn.close();	
		
		return buses;
	}
	
	private ArrayList<Route> getRoutes() {
		ArrayList<Route> routes = new ArrayList<>();
		
		
		
		return routes;
	}
	
	private ArrayList<Action> getActions() throws InterruptedException, SQLException{
		ArrayList<Action> actions = new ArrayList<>();
		
		Connection conn = EstablishConnection.establishConnection(false, null);
		
		if(conn.isValid(0)) {

			ResultSet rs = ActionsQueries.selectAllActions(conn);

			while(rs.next()) {

				int busId = rs.getInt("BusId");
				LocalTime time = rs.getTime("Time").toLocalTime();
				String action = rs.getString("Text");

				Action a = new Action(busId, time, action);
				if(a.time().isBefore(LocalTime.now())) {
					actions.add(a);
				}

			}

		} else {
			System.out.println("UpdateBusesBasedOnPredictionService: Connection is down");
		}
		
		conn.close();
		return actions;
	}

}
