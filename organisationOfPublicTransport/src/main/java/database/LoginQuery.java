package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.CountDownLatch;

import javafx.application.Platform;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.PasswordField;
import organisationOfPublicTransport.organisationOfPublicTransport.App;

public class LoginQuery{

	public static ResultSet selectAllAdminsQuery(Connection conn) {
		String query = "SELECT * " + "FROM dbo.AdminsShift ";
		
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
	
}
