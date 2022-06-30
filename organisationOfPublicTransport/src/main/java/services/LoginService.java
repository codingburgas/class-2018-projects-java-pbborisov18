package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.EstablishConnection;
import database.LoginQuery;
import javafx.application.Platform;
import javafx.concurrent.Task;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import models.Admin;
import organisationOfPublicTransport.organisationOfPublicTransport.App;
import utils.PasswordHasher;
import javafx.scene.control.Alert.AlertType;

public class LoginService extends Task<Admin>{
	
	private String username;
	private String password;
	private TextField objUsername;
	private PasswordField objPassword;
	Admin admin;
	

	public LoginService(TextField txtUsername, PasswordField txtPassword) {
		this.username = txtUsername.getText();
		this.password = txtPassword.getText();
		this.objUsername = txtUsername;
		this.objPassword = txtPassword;
	}

	@Override
	protected Admin call() throws Exception {
		
		Admin admin = loginLogic();
		
		
		return admin;
	}
	
	private Admin loginLogic() throws SQLException, InterruptedException {
		ResultSet rs;
		
		Connection conn = EstablishConnection.establishConnection(true,objPassword);
		rs = LoginQuery.selectAllAdminsQuery(conn);		
		
		if(userExists(username, rs)) {

			if(successfulLogin(rs, username, password)) {
				System.out.println("Successful Login");
				getShiftAdminInfo(rs);
				Platform.runLater(new Runnable() { // Have to use this so I can call the dialogs method and show an error to the user
					@Override
					public void run() {
						try {
							App.setRoot("MainMenu");
							
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
		
		return admin;
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
	
	private Admin getShiftAdminInfo(ResultSet rs) throws SQLException {
		int shiftId = rs.getInt("ShiftId");
		String shiftUsername = rs.getString("ShiftUsername");
		
		
		admin = new Admin(shiftId, shiftUsername);
		
		return admin;
	}

}
