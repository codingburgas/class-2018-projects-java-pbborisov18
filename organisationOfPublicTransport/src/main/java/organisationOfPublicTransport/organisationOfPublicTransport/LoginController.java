package organisationOfPublicTransport.organisationOfPublicTransport;


import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.VBox;
import services.LoginService;

public class LoginController {
	@FXML
    private TextField txtUsername;
    @FXML
    private PasswordField txtPassword;
    @FXML
    private Button loginButton;
    @FXML
    private VBox vBoxLogin;
    @FXML
    private ProgressIndicator loading;
    
    public void enterPressed(ActionEvent event){
    	
    	if(fieldsEmpty()) {
    		App.dialogs("Both fields need a value!", "Both fields have to have a value!", AlertType.INFORMATION, txtUsername.getScene());
    	} else {
    		disableLoginUI();
    		
    		Task<Void> task = new LoginService(txtUsername, txtPassword);
    		
    		Thread thread = new Thread(task);
    		thread.setDaemon(true);
			
			task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					enableLoginUI();
				}
            });
			
			task.setOnFailed(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					enableLoginUI();
				}
            });

			thread.start();
    	}
    	
    }
    
    /* Checks if both username and password fields have values
     * if no  - returns false
     * if yes - returns true
     */
    private Boolean fieldsEmpty() {
    	if(txtUsername.getText().equals("") || txtPassword.getText().equals("")) {
    		return true;
    	} else {
    		return false;
    	}
    }
    
    //Freezes login UI and shows the loading indicator
    private void disableLoginUI() {
    	//freezing the login ui so multiple requests can't be sent
		txtUsername.setDisable(true);
		txtPassword.setDisable(true);
		loginButton.setDisable(true);
		
		//showing the loading indicator
		loading.setProgress(-1);
		loading.setVisible(true);
    }
    
    //Unfreezes the login ui and hides the loading indicator
    private void enableLoginUI() {
    	//unfreezing ui
		txtUsername.setDisable(false);
		txtPassword.setDisable(false);
		loginButton.setDisable(false);
		
		loading.setVisible(false);
    }
}
