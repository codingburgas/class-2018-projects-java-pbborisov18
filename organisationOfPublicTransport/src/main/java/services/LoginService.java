package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.LoginQuery;
import javafx.application.Platform;
import javafx.concurrent.Task;
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
	

	public LoginService(TextField txtUsername, PasswordField txtPassword) {
		this.username = txtUsername.getText();
		this.password = txtPassword.getText();
		this.objUsername = txtUsername;
		this.objPassword = txtPassword;
	}

	@Override
	protected Void call() throws Exception {
		loginLogic();
		
		return null;
	}
	
	private void loginLogic() throws SQLException, InterruptedException {
		ResultSet rs;
		
		Connection conn = LoginQuery.establishConnection(objPassword);
		rs = LoginQuery.executeLoginQuery(conn);		
		
		if(userExists(username, rs)) {

			if(successfulLogin(rs, username, password)) {
				System.out.println("Successful Login");
				
				Platform.runLater(new Runnable() { // Have to use this so I can call the dialogs method and show an error to the user
					@Override
					public void run() {
						try {
							App.setRoot("primary");
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				});
				
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
