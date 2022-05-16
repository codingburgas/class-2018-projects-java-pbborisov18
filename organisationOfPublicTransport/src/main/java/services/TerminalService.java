package services;

import java.sql.Connection;
import java.sql.ResultSet;

import database.TerminalQuery;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Terminal;

public class TerminalService extends Task<ObservableList<Terminal>>{

	@Override
	protected ObservableList<Terminal> call() throws Exception {

		Connection conn = TerminalQuery.establishConnection();
		ObservableList<Terminal> terminals = FXCollections.observableArrayList();
		
		if(conn.isValid(0)) {
			
			ResultSet rs = TerminalQuery.executeTerminalQuery();
			
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
