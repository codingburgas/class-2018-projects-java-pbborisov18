package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import models.Bus;

public class BusQueries {
	
	
	//flag is if you want to retrieve all busses present in the table THAT ARE NOT BROKEN
	//true to get everything from the table except the broken buses
	//false to get a specific terminal busses
	public static ResultSet selectBusQueryByTerminalNotBroken(int terminalId, boolean allFlag, Connection conn) throws SQLException {
		
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
	
	public static ResultSet selectNotBrokenBusQueryById(int busId, Connection conn) {
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
	
	public static void updateBreakABusQueryById(int busId, Connection conn) {
		String query = 	"UPDATE dbo.BusOriginal " + 
						"SET Broken = 'True' " +
						"WHERE BusId = ? " +
						"UPDATE dbo.Bus " +
						"SET Broken = 'True' " +
						"WHERE BusId = ? ;";
		
		
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, busId);
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
	
	public static ResultSet selectAllBrokenBusesQuery(Connection conn) {
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
	
	public static void updateFixABusQuery(int busId, int terminalId, Connection conn) {
		
		//Have to "fix" the query because of lack of planning
		//Current terminal has to be excluded otherwise the algorithm will fuck up
		//If you decide to update CurrentTerminalId like originally planned the algorithm
		//will start with the bus at that terminal (might be a wanted effect in the future)
		String query = 	"Update dbo.BusOriginal " +
						"SET Broken = 'False' " /*, CurrentTerminalId = ? "*/ +
						"WHERE BusId = ? ;";

		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(query);
			//stmt.setInt(1, terminalId);
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
	
	public static int[] updateAllBuses(List<Bus> buses, Connection conn) {
		
		String query = 	"UPDATE dbo.Bus " +  
							"SET BusName = ? ," +
							"CurrentRouteId = ? ," +
							"CurrentTerminalId = ? ,"+ 
							"Broken = ? ," + 
							"Charging = ? ," + 
							"Battery = ? ,"+ 
							"Delay = ? " +
						"WHERE BusId = ? ;";
		
		
		int[] success;
		
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			
			int counter = 0;
			
			for (Bus bus : buses) {

				stmt.setNString(1, bus.getBusName());
				
				if(bus.getCurrentRouteId() == 0) {
					stmt.setNull(2, Types.INTEGER);
				} else {
					stmt.setInt(2, bus.getCurrentRouteId());
				}
				
				if(bus.getCurrentTerminalId() == 0) {
					stmt.setNull(3, Types.INTEGER);
				} else {
					stmt.setInt(3, bus.getCurrentTerminalId());	
				}
				
				stmt.setBoolean(4, bus.isBroken());
				stmt.setBoolean(5, bus.isCharging());
				stmt.setInt(6, bus.getBattery());
				stmt.setInt(7, bus.getDelay());
				
				stmt.setInt(8, bus.getBusId());

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
	
	public static int insertAddABus(Bus bus, Connection conn) {
		String query = 	"DBCC CHECKIDENT (Bus, RESEED, 0)"
					  + "DBCC CHECKIDENT (Bus)"
					  + "INSERT INTO dbo.Bus VALUES (?,?,?,?,?,?,?);";
		
		
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(query);
			stmt.setString(1, bus.getBusName());
			stmt.setInt(2, bus.getCurrentRouteId());
			stmt.setInt(3, bus.getCurrentTerminalId());
			stmt.setBoolean(4, bus.isBroken());
			stmt.setBoolean(5, bus.isCharging());
			stmt.setInt(6, bus.getBattery());
			stmt.setInt(7, bus.getDelay());
			
			int count = stmt.executeUpdate();

			return count;

		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	public static int deleteABus(int id, Connection conn) {
		String query = 	"DELETE FROM Bus WHERE busId = ?;";
		
		
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(query);
			
			int count = stmt.executeUpdate();

			return count;

		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	//Simplest way to solve bad planning
	public static ResultSet selectBusQueryFromBusOriginal(Connection conn) throws SQLException {
		
		String query = "SELECT * " + "FROM BusOriginal " + "WHERE Broken = 'False'";

		PreparedStatement stmt;
			
		stmt = conn.prepareStatement(query);
		
		ResultSet rs = stmt.executeQuery();
		
		return rs;
		
	}
	
	
	
}