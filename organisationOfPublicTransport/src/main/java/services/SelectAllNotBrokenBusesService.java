package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.BusQueries;
import database.EstablishConnection;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Bus;

public class SelectAllNotBrokenBusesService extends Task<ObservableList<Bus>> {

	int id;
	boolean flag;
	
	public SelectAllNotBrokenBusesService(int id, boolean flag){
		this.id = id;
		this.flag = flag;
	}
	
	@Override
	protected ObservableList<Bus> call() {
		ObservableList<Bus> busses = null;
		
		try {
			Connection conn = EstablishConnection.establishConnection(false, null);
		
			if(conn.isValid(0)) {
				
				busses = FXCollections.observableArrayList();
				ResultSet rs = BusQueries.selectBusQueryByTerminalNotBroken(id, flag, conn);	
				
				while(rs.next()) {
					
					int busId = rs.getInt("BusId");
					String busName = rs.getString("BusName");
					int currentRouteId = rs.getInt("CurrentRouteId");
					int currentTerminalId = rs.getInt("CurrentTerminalId");
					boolean broken = rs.getBoolean("Broken");
					boolean charging = rs.getBoolean("Charging");
					int battery = rs.getInt("Battery");
					int delay = rs.getInt("Delay");

					Bus a = new Bus(busId, busName, currentRouteId, currentTerminalId, broken, charging, battery, delay);
					
					busses.add(a);
				}
			conn.close();	
			} else {
				System.out.println("SelectAllNotBrokenBusesService: Connection is down");
			}
		} catch (SQLException | InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return busses;
	}
	
}
