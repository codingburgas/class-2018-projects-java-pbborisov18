package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.CountDownLatch;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;

public class BrokenBusQuery {
	
	static Connection conn;
	
	public static ResultSet executeBreakABusQuery(int busId) {
		String query = 	"SELECT * " +
						"FROM dbo.Bus " +
						"WHERE BusId = ? ;";
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
