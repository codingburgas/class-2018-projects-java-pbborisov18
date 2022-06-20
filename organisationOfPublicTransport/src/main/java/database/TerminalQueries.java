package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.CountDownLatch;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;

public class TerminalQueries {
	
	public static ResultSet selectAllTerminalsQuery(Connection conn) throws SQLException {
		
		String query = "SELECT * " + "FROM Terminals ";
		
		PreparedStatement stmt;
		ResultSet rs = null;
		
		stmt = conn.prepareStatement(query);
		
		rs = stmt.executeQuery();
		
		return rs;
	}
	
}
