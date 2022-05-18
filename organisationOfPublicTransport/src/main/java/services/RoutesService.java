package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.RoutesQuery;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Route;

public class RoutesService extends Task<ObservableList<Route>>{

	@Override
	protected ObservableList<Route> call() {
		ObservableList<Route> routes = null;
		
		try {
			Connection conn = RoutesQuery.establishConnection();
			
			if(conn.isValid(0)) {
				
				routes = FXCollections.observableArrayList();
				ResultSet rs = RoutesQuery.executeSelectRoutes();
				
				while(rs.next()) {
					
					int routeId = rs.getInt("RouteId");
					String routeName = rs.getString("RouteName");
					String routeDuration = rs.getString("RouteDuration");
					int destinationTerminalId = rs.getInt("DestinationTerminalId");
					
					Route route = new Route(routeId, routeName, routeDuration, destinationTerminalId);
					
					routes.add(route);		
				}
			conn.close();	
			} else {
				System.out.println("connection is down");
			}
		}  catch(SQLException | InterruptedException e) {
			e.printStackTrace();
		}
		
		
		return routes;
	}

}
