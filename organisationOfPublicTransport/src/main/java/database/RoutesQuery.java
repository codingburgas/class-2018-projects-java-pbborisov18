package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.CountDownLatch;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;

public class RoutesQuery {
static Connection conn;
	
	//flag is if you want to retrieve all busses present in the table THAT ARE NOT BROKEN
	//true to get everything from the table except the broken buses
	//false to get a specific terminal busses
	public static ResultSet executeSelectRoutes() throws SQLException {
		
		String query = "SELECT * " + "FROM Routes ;" ;
		
		PreparedStatement stmt;
			
		stmt = conn.prepareStatement(query);
		
		ResultSet rs = stmt.executeQuery();
		
		return rs;
		
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
