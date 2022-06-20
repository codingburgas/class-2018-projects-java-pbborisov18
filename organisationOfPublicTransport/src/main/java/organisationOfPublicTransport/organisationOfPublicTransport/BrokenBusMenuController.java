package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.AnchorPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import models.Bus;
import services.SelectABusService;
import services.UpdateBreakBusService;


public class BrokenBusMenuController {
	
	//1st window
	@FXML
	public Button searchBrokenBusButton;
	
	@FXML
	public TextField txtBrokenBusId;
	
	
	//2nd window
	@FXML
	private Label busName;
	
	@FXML
	private Circle activeStatus;
	
	@FXML
	private Label battery;
	
	@FXML
	private Label route;
	
	@FXML
	private Label active;
	
	@FXML
	private AnchorPane anchorPane;
	
	
	
	public void brokenBusMenuSearchListener(ActionEvent event) {
		if(isNumeric(txtBrokenBusId.getText())) {
			
			Task<Bus> task = new SelectABusService(Integer.parseInt(txtBrokenBusId.getText()));
    		Thread thread = new Thread(task);
    		thread.setDaemon(true);
    		
    		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					Bus bus = task.getValue();
					
					if(busExists(bus)) {
						changeToConfirmationScreen(bus);
					}
					
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
	
	public void changeToConfirmationScreen(Bus bus) {
		Stage thisStage = (Stage) txtBrokenBusId.getScene().getWindow();
		
		FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("bus.fxml"));
		Scene scene = null;
		fxmlLoader.setController(this);
		try {
			scene = new Scene(fxmlLoader.load());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Create the needed label and buttons
		Label confirmation = new Label();
		confirmation.setText("Is this the correct bus?");
		
		Button noButton = new Button("No");
		Button yesButton = new Button("Yes");
		
		//Set values to the pre-existing values
		assignValuesToConfirmationItems(bus);

   	 	//Add the newly created buttons and label
	    anchorPane.getChildren().add(confirmation);
	    anchorPane.getChildren().add(noButton);
	    anchorPane.getChildren().add(yesButton);
	    
	    anchorPane.setPrefHeight(150);
   	 	
	    //Rearrange the menu
	    rearrangeConfirmationMenu(noButton, yesButton);
	    assignTheButtonsListeners(noButton, yesButton, thisStage, bus);
	    
	    thisStage.setScene(scene);
	}
	
	public void assignTheButtonsListeners(Button no, Button yes, Stage stage, Bus bus) {
		
		no.setOnAction(event -> {
			FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("BrokenBus.fxml"));
			Scene scene = null;
			try {
				scene = new Scene(fxmlLoader.load());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			stage.setScene(scene);
		});
	
		
		yes.setOnAction(event -> {
			Task<Void> task = new UpdateBreakBusService(bus.busId());
    		
    		Thread thread = new Thread(task);
    		thread.setDaemon(true);
    		
    		
    		App.dialogs("Succesfully updated!", "Successfully updated!", AlertType.INFORMATION, no.getScene());
    		
    		stage.close();
    		
    		thread.start();
		});
		
	}

	public void assignValuesToConfirmationItems(Bus bus) {
		if(bus.charging().equals(true)) {
    		activeStatus.setFill(Color.YELLOW); 
    	} else {
    		activeStatus.setFill(Color.GREEN);
    	}
		
		busName.setText(bus.busName());
		battery.setText("Battery: " + bus.battery());
   	 	route.setText("Route: " + bus.currentRouteId());
	}
	
	public void rearrangeConfirmationMenu(Button noButton, Button yesButton) {
		busName.setTranslateY(20);
	    battery.setTranslateY(20);
	    route.setTranslateY(20);
	    activeStatus.setTranslateY(20);
	    active.setTranslateY(20);
	    
	    noButton.setTranslateX(40);
	    noButton.setTranslateY(100);
	    yesButton.setTranslateX(200);
	    yesButton.setTranslateY(100);
	}

	public boolean busExists(Bus bus) {
		if(bus == null) {
			App.dialogs("Bus with that Id doesn't exist", "Bus with that Id doesn't exist or is already broken!", AlertType.INFORMATION, txtBrokenBusId.getScene());   
			return false;
		}
		
		return true;
	}
	
	public boolean isNumeric(String string) {
	    int intValue;
			
	   	
	    if(string.equals("")) {
	    	App.dialogs("Id field can't be empty", "Id field can't be empty", AlertType.INFORMATION, txtBrokenBusId.getScene());
	        return false;
	    }
	    
	    try {
	        intValue = Integer.parseInt(string);
	        return true;
	    } catch (NumberFormatException e) {
	    	App.dialogs("Id field can be only a number", "Id field can only be a number", AlertType.INFORMATION, txtBrokenBusId.getScene());
	    	return false;
	    }

	}
	
}
