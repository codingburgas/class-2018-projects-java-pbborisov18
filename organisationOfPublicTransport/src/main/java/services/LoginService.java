package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.ConnectionToDB;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

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
		// TODO Auto-generated method stub
		return null;
	}
	
	private Connection establishConnection() {
		
		Task<Connection> task = new ConnectionToDB();
		Thread thread = new Thread(task);
		thread.setDaemon(true);
		
		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				conn = task.getValue();
			}
		});
		
		task.setOnFailed(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				conn = task.getValue();
			}
		});
		
		thread.start();
		
		return conn;
	}
	
	private boolean userExists(String username, ResultSet rs) throws SQLException {
		if(!rs.isBeforeFirst()) {   //Username doesn't exist
			return false;
		} else { 					//Username exists
			return true;
		}
	}
	
	

}
