package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.CountDownLatch;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;

public class BusQueries {
	
	static Connection conn;
	
	//flag is if you want to retrieve all busses present in the table THAT ARE NOT BROKEN
	//true to get everything from the table except the broken buses
	//false to get a specific terminal busses
	public static ResultSet selectBusQueryByTerminalNotBroken(int terminalId, boolean allFlag) throws SQLException {
		
		String query;
		
		PreparedStatement stmt;
		
		if(allFlag) {
			query = "SELECT * " + "FROM Bus " + "WHERE Broken = 'False'" ;
			stmt = conn.prepareStatement(query);
	
		} else {
			
			query = "SELECT * " + "FROM Bus " + "WHERE CurrentTerminalId = ? AND Broken = 'False'" ;
			
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, terminalId);
			
		}
		
		ResultSet rs = stmt.executeQuery();
		
		return rs;
		
	}
	
	public static ResultSet selectNotBrokenBusQueryById(int busId) {
		String query = 	"SELECT * " +
						"FROM dbo.Bus " +
						"WHERE BusId = ? and Broken = 'False';";
		PreparedStatement stmt;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, busId);
			
			rs = stmt.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public static void updateBreakABusQueryById(int busId) {
		String query = 	"UPDATE dbo.Bus " + 
						"SET Broken = 'True' " +
						"WHERE BusId = ? ;";
		
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, busId);
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
	
	public static ResultSet selectAllBrokenBusesQuery() {
		String query = 	"SELECT * " + 
						"FROM Bus " + 
						"WHERE Broken = 'True' ;";
		
		PreparedStatement stmt;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(query);
			
			rs = stmt.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public static void updateFixABusQuery(int busId, int terminalId) {
		String query = 	"UPDATE dbo.Bus " + 
						"SET Broken = 'False', CurrentTerminalId = ? " +
						"WHERE BusId = ? ;";

		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, terminalId);
			stmt.setInt(2, busId);
			
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