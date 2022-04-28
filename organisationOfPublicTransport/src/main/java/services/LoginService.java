package services;

import java.sql.Connection;

import javafx.concurrent.Task;
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
	
	
	
	

}
