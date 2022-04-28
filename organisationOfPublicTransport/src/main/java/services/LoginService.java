package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.ConnectionToDB;
import javafx.application.Platform;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import organisationOfPublicTransport.organisationOfPublicTransport.App;
import utils.PasswordHasher;
import javafx.scene.control.Alert.AlertType;

public class LoginService extends Task<Void>{
	
	private String username;
	private String password;
	private TextField objUsername;
	private PasswordField objPassword;
	private Connection conn;

	public LoginService(TextField txtUsername, PasswordField txtPassword) {
		this.username = txtUsername.getText();
		this.password = txtPassword.getText();
		this.objUsername = txtUsername;
		this.objPassword = txtPassword;
	}

	@Override
	protected Void call() throws Exception {
		ResultSet rs;
		
		conn = establishConnection();

		rs = executeLoginQuery(conn);
		
		if(userExists(username, rs)) {

			if(successfulLogin(rs, username, password)) {
				System.out.println("Successful Login");
				
			} else {
				Platform.runLater(new Runnable() { // Have to use this so I can call the dialogs method and show an error to the user
					@Override
					public void run() {
						App.dialogs("Incorrect password!", "Incorrect password!", AlertType.INFORMATION, objPassword.getScene());
					}
				});
			}
			conn.close();
			
		} else {
			Platform.runLater(new Runnable() {
				@Override
				public void run() {
					App.dialogs("Incorrect username!", "Incorrect username!", AlertType.INFORMATION, objPassword.getScene());
				}
			});
			
			conn.close();
		}
		
		return null;
	}
	
	private ResultSet executeLoginQuery(Connection conn) {
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
	//Works the first time. Doesn't work after that ?????????????????
	private Connection establishConnection() {
		
		Task<Connection> task = new ConnectionToDB();
		Thread thread = new Thread(task);
		thread.setDaemon(true);
		
		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				conn = task.getValue();
				System.out.println("1"+conn);
			}
		});
		
		task.setOnFailed(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				
				Platform.runLater(new Runnable() {
					@Override
					public void run() {
						App.dialogs("Connection failed!", "Connection failed!", AlertType.ERROR, objPassword.getScene());
					}
				});
				
				System.out.println( "2"+ task.getValue());
			}
		});
		
		thread.start();

		try {
			thread.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("3rd thread: " + thread.getId());
		
		System.out.println("3"+conn);
		
		return conn;
	}
	
	private Boolean userExists(String username, ResultSet rs) throws SQLException {
		while(rs.next()) {
			String user = rs.getString("ShiftUsername");
			if(username.equals(user)) {
				return true;
			}
		}
		return false;
	}
	
	private boolean successfulLogin(ResultSet rs, String username, String password) throws SQLException {
		
		byte[] dbSalt;
		String dbHashedPassword;

			dbSalt = rs.getBytes("Salt");
			dbHashedPassword = rs.getString("HashedPassword");
				
			password = PasswordHasher.passwordHasher(password, dbSalt);
				
			if(password.equals(dbHashedPassword)) {
				return true;
			} else {
				return false;
			}
				
	}

}
