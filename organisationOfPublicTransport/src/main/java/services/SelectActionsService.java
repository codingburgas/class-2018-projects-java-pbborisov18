package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.time.LocalTime;

import database.ActionsQueries;
import database.BusQueries;
import database.EstablishConnection;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Action;
import models.Bus;

public class SelectActionsService extends Task<ObservableList<Action>> {

	@Override
	protected ObservableList<Action> call() throws Exception {
		Connection conn = EstablishConnection.establishConnection(false, null);
		ObservableList<Action> actions = FXCollections.observableArrayList();

		if(conn.isValid(0)) {
			ResultSet rs = ActionsQueries.selectAllActions(conn);

			while(rs.next()) {

				int busId = rs.getInt("BusId");
				LocalTime time = rs.getTime("Time").toLocalTime();
				String action = rs.getString("Text");

				Action a = new Action(busId, time, action);
				if(a.time().isAfter(LocalTime.now())) {
					actions.add(a);
				}

			}
		}
		
		conn.close();
		
		return actions;
	}

}
