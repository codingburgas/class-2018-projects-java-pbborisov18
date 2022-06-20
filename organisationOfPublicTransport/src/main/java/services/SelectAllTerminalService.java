package services;

import java.sql.Connection;
import java.sql.ResultSet;

import database.TerminalQueries;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Terminal;

public class SelectAllTerminalService extends Task<ObservableList<Terminal>>{

	@Override
	protected ObservableList<Terminal> call() throws Exception {

		Connection conn = TerminalQueries.establishConnection();
		ObservableList<Terminal> terminals = FXCollections.observableArrayList();
		
		if(conn.isValid(0)) {
			
			ResultSet rs = TerminalQueries.selectAllTerminalsQuery();
			
			while(rs.next()) {
				int terminalId = rs.getInt("Id");
				String terminalName = rs.getString("TerminalName");
				
				Terminal a = new Terminal(terminalId, terminalName);
				
				terminals.add(a);
			}
				
		}
		conn.close();
		return terminals;
	}

}
