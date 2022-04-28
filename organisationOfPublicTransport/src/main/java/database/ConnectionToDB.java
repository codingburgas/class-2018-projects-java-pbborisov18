package database;

import java.sql.Connection;
import java.sql.DriverManager;
import javafx.concurrent.Task;

public class ConnectionToDB extends Task<Connection>{

	@Override
	protected Connection call() throws Exception {
		String url = "jdbc:sqlserver://localhost\\SQLEXPRESS01;databaseName=OrganisationOfPublicTransport;encrypt=false;trustServerCertificate=true";
		String user = "sa";
		String pass = "ass";
		
		Connection conn = DriverManager.getConnection(url, user, pass);	
		
		return conn;
	}

}
