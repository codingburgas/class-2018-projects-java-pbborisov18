package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;

import models.Action;

public class ActionsQueries {
	
	public static int[] createActions(ArrayList<Action> actions, Connection conn) {
		String executeBeforeQuery = "DELETE FROM Actions";
		String query = 	"DBCC CHECKIDENT (Actions, RESEED, 0)" +
						"DBCC CHECKIDENT (Actions)" +
						"INSERT INTO dbo.Actions VALUES (?, ?, ?);";
						
		int[] success;
		
		
		try {
			PreparedStatement beforestmt = conn.prepareStatement(executeBeforeQuery);
			beforestmt.executeUpdate();
			beforestmt.close();
			
			PreparedStatement stmt = conn.prepareStatement(query);
			
			int counter = 0;
			for (Action action : actions) {

				stmt.setInt(1, action.busId());
				stmt.setTime(2, Time.valueOf(action.time()));
				stmt.setString(3, action.action());

				stmt.addBatch();

				counter++;
			}
			success = new int[counter+1];	
			stmt.executeBatch();
			return success;		
			
		} catch(SQLException e) {
			e.printStackTrace();
			return null;
		}

		
		
	}

	public static ResultSet selectAllActions(Connection conn) {
		String query = 	"SELECT * " + 
						"FROM Actions;";

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
}
