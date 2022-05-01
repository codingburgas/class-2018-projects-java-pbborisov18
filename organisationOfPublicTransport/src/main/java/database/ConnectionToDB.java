package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javafx.concurrent.Task;

public class ConnectionToDB extends Task<Connection>{

	@Override
	protected Connection call() throws Exception {
		return dbConnection();
	}
	
	private Connection dbConnection() throws SQLException {
		String url = "jdbc:sqlserver://localhost\\SQLEXPRESS01;databaseName=OrganisationOfPublicTransport;encrypt=false;trustServerCertificate=true";
		String user = "sa";
		String pass = "ass";
		
		Connection conn;
		
		conn = DriverManager.getConnection(url, user, pass);	
		return conn;
	}

}
