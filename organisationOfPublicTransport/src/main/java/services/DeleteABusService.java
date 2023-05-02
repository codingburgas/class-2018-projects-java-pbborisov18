package services;

import java.sql.Connection;

import database.BusQueries;
import database.EstablishConnection;
import javafx.concurrent.Task;

public class DeleteABusService extends Task<Void> {

	int id;
	
	public DeleteABusService(int id) {
		this.id = id;
	}
	
	@Override
	protected Void call() throws Exception {

		Connection conn = EstablishConnection.establishConnection(false, null);

		if(conn.isValid(0)) {
			int success = BusQueries.deleteABus(id, conn);

			if(success > 0 ) {
				System.out.println("Successfully deleted!");
			} else {
				System.out.println("Failed to delete!");
			}

		}

		return null;
	}

}
