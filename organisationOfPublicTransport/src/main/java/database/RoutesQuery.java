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

public class RoutesQuery {
static Connection conn;
	
	//flag is if you want to retrieve all routes present in the table
	//true to get everything from the table
	//false to get a specific route
	public static ResultSet executeSelectRoutes(int routeId, boolean allFlag) throws SQLException {
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
	
	public static void executeUpdateRoute(int routeId, LocalTime duration, LocalTime startInterval) {
		String query = 	"UPDATE Routes " + 
						"SET RouteDuration = ? , StartIntervals = ? " +
						"WHERE RouteId = ? ;";

		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(query);
			stmt.setTime(1, Time.valueOf(duration));
			stmt.setTime(2, Time.valueOf(startInterval));
			stmt.setInt(3, routeId);
			
			int count = stmt.executeUpdate();

			if(count > 0 ) {
				System.out.println("Successfully updated!");
			} else {
				System.out.println("Failed to update!");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
	public static Connection establishConnection() throws InterruptedException {
		CountDownLatch latch = new CountDownLatch(1);
		Task<Connection> task = new ConnectionToDB();
		Thread thread = new Thread(task);
		thread.setDaemon(true);
		
		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				conn = task.getValue();
				latch.countDown();
			}
		});
		
		task.setOnFailed(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				latch.countDown();
			}
		});
		
		thread.start();

		latch.await();
		
		return conn;
	}
}
