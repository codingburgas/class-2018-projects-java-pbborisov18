package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;

import database.RoutesQueries;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Route;

public class SelectAllRoutesService extends Task<ObservableList<Route>>{

	private int id;
	private boolean all; 
	
	public SelectAllRoutesService(int id, boolean all){
		this.id = id;
		this.all = all;
	}
	
	@Override
	protected ObservableList<Route> call() {
		ObservableList<Route> routes = null;
		
		try {
			Connection conn = RoutesQueries.establishConnection();
			
			if(conn.isValid(0)) {
				
				routes = FXCollections.observableArrayList();
				ResultSet rs = RoutesQueries.selectRouteById(id, all);
				
				while(rs.next()) {
					
					int routeId = rs.getInt("RouteId");
					String routeName = rs.getString("RouteName");
					LocalTime routeDuration = rs.getTime("RouteDuration").toLocalTime();
					int batteryUsage = rs.getInt("BatteryUsage");
					int startTerminalId = rs.getInt("StartTerminalID");
					int destinationTerminalId = rs.getInt("DestinationTerminalId");
					LocalTime startInvervals = rs.getTime("StartIntervals").toLocalTime();
					
					Route route = new Route(routeId, routeName, routeDuration, batteryUsage, startTerminalId, destinationTerminalId, startInvervals);
					
					routes.add(route);		
				}
			conn.close();	
			} else {
				System.out.println("SelectAllRoutesService: connection is down");
			}
		}  catch(SQLException | InterruptedException e) {
			e.printStackTrace();
		}
		
		
		return routes;
	}

}
