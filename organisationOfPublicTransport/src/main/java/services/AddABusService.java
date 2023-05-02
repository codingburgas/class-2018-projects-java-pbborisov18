package services;

import java.sql.Connection;

import database.BusQueries;
import database.EstablishConnection;
import javafx.concurrent.Task;
import models.Bus;

public class AddABusService extends Task<Void> {

	Bus bus;
	
	public AddABusService(Bus bus) {
		this.bus = bus;
	}
	
	@Override
	protected Void call() throws Exception {

		Connection conn = EstablishConnection.establishConnection(false, null);

		if(conn.isValid(0)) {
			int success = BusQueries.insertAddABus(bus, conn);

			if(success > 0 ) {
				System.out.println("Successfully added!");
			} else {
				System.out.println("Failed to add!");
			}

		}

		return null;
	}

}
