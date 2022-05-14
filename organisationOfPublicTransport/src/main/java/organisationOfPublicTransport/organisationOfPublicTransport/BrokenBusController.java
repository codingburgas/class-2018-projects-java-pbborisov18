package organisationOfPublicTransport.organisationOfPublicTransport;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert.AlertType;
import models.Bus;
import services.BreakABusService;

public class BrokenBusController {
	
	@FXML
	public Button searchBrokenBusButton;
	
	@FXML
	public TextField txtBrokenBusId;
	
	public void brokenBusMenuSearchListener(ActionEvent event) {
		if(isNumeric(txtBrokenBusId.getText())) {
			
			Task<Bus> task = new BreakABusService(Integer.parseInt(txtBrokenBusId.getText()));
    		Thread thread = new Thread(task);
    		thread.setDaemon(true);
    		
    		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					Bus bus = task.getValue();
					busExists(bus);
				}
            });
			
			task.setOnFailed(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					
				}
            });
    		
    		thread.start();
		}
		
	}
	
	public boolean busExists(Bus bus) {
		if(bus == null) {
			App.dialogs("Bus with that Id doesn't exist", "Bus with that Id doesn't exist or is already broken!", AlertType.INFORMATION, txtBrokenBusId.getScene());   
			return false;
		}
		
		return true;
	}
	
	public boolean fieldEmpty() {
		if(txtBrokenBusId.getText().equals("")) {
			return true;
		} else {
			return false;
		}		
	}
	
	public boolean isNumeric(String string) {
	    int intValue;
			
	   	
	    if(string.equals("")) {
	    	App.dialogs("Id field can't be empty", "Id field can't be empty", AlertType.INFORMATION, txtBrokenBusId.getScene());
	        return false;
	    }
	    
	    try {
	        intValue = Integer.parseInt(string);
	    } catch (NumberFormatException e) {
	    	App.dialogs("Id field can be only a number", "Id field can only be a number", AlertType.INFORMATION, txtBrokenBusId.getScene());
	    	return false;
	    }
	    return true;
	}
	
}
