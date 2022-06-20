package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.concurrent.CountDownLatch;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;

public class RoutesQueries {
	
	//flag is if you want to retrieve all routes present in the table
	//true to get everything from the table
	//false to get a specific route
	public static ResultSet selectRouteById(int routeId, boolean allFlag, Connection conn) throws SQLException {
		
		String query = null;
		
		PreparedStatement stmt;		
		
		if(allFlag) {
			query = "SELECT * " + "FROM Routes ;" ;
			stmt = conn.prepareStatement(query);
		} else {
			query = "SELECT * " + "FROM Routes " + "WHERE RouteId = ? ;" ;
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, routeId);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		return rs;
		
	}
	
	public static int updateRouteById(int routeId, LocalTime duration, LocalTime startInterval, Connection conn) {
		String query = 	"UPDATE Routes " + 
						"SET RouteDuration = ? , StartIntervals = ? " +
						"WHERE RouteId = ? ;";
		int count = 0;
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(query);
			stmt.setTime(1, Time.valueOf(duration));
			stmt.setTime(2, Time.valueOf(startInterval));
			stmt.setInt(3, routeId);
			
			count = stmt.executeUpdate();

			return count;

		} catch (SQLException e) {
			e.printStackTrace();
		}	
		
		return count;
	}
	
}
