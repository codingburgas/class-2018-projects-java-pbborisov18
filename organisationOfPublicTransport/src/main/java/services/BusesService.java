package services;

import java.sql.Connection;
import java.sql.ResultSet;

import database.BusQuery;
import javafx.concurrent.Task;

public class BusesService extends Task<Void> {

	
	@Override
	protected Void call() throws Exception {
		
		Connection conn = BusQuery.establishConnection();
		
		if(conn.isValid(0)) {
			ResultSet rs = BusQuery.executeBusQuery(1);	
			
			while(rs.next()) {
				System.out.println(rs.getString("BusName"));
			}
		}
			
		return null;
	}
	
	
	
	
}
