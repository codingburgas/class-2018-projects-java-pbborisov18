package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;
import java.time.LocalTime;
import java.util.ArrayList;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Stage;
import models.Route;
import services.SelectAllRoutesService;
import services.UpdateRerouteService;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;

public class RerouteMenuController {
	
	//1st window
	@FXML
	private TextField txtRouteId;
	
	@FXML
	private Button rerouteButton;
	
	
	//2nd window
	
	@FXML
	private TextField routeId;
	
	@FXML
	private TextField routeName;

	@FXML
	private ComboBox<Integer> hrDuration;
	
	@FXML
	private ComboBox<Integer> minDuration;

	@FXML
	private TextField routeDestination;

	@FXML
	private ComboBox<Integer> hrStartIntervals;
	
	@FXML
	private ComboBox<Integer> minStartIntervals;
	
	@FXML
	private Button update;
	
	
	
	public void rerouteListener(ActionEvent event) {
		if(isNumeric(txtRouteId.getText())) {
			
			Task<ObservableList<Route>> task = new SelectAllRoutesService(Integer.parseInt(txtRouteId.getText()), false);
    		Thread thread = new Thread(task);
    		thread.setDaemon(true);
    		
    		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					ObservableList<Route> routeList = task.getValue();
					
					//Add a null to the list so no exception is thrown at the next line if the list happens to be empty
					routeList.add(null);
					Route route = routeList.get(0);
					
					if(routeExists(route)) {
						changeToEditScreen(route);
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
	
	public void changeToEditScreen(Route route) {
		Stage thisStage = (Stage) txtRouteId.getScene().getWindow();
		
		FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("Reroute.fxml"));
		Scene scene = null;
		fxmlLoader.setController(this);
		try {
			scene = new Scene(fxmlLoader.load());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		assignValuesToEditMenuItems(route);
		assignListenersToEditMenuButton(update, route);
	    
	    thisStage.setScene(scene);
		
	}

	public void assignListenersToEditMenuButton(Button update, Route route) {
		
		update.setOnAction(event ->{
			LocalTime duration = LocalTime.of(hrDuration.getValue(), minDuration.getValue());
			LocalTime startIntervals = LocalTime.of(hrStartIntervals.getValue(), minStartIntervals.getValue());
		
			Task<Integer> task = new UpdateRerouteService(route.routeId(), duration, startIntervals, update);
    		
    		Thread thread = new Thread(task);
    		thread.setDaemon(true);
    		
    		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					try{
						if(task.getValue() == 1) {
							App.dialogs("Successfuly updated", "Successfuly updated!", AlertType.INFORMATION, update.getScene());
						} else {
							App.dialogs("Failed to update", "Failed to update!", AlertType.INFORMATION, update.getScene());
						}
					} catch(NullPointerException e) {
						App.dialogs("Failed to update", "Failed to update!", AlertType.INFORMATION, update.getScene());
						System.out.println(e);
						Stage stage = (Stage) update.getScene().getWindow();
			    		stage.close();
					}
					
					
				}
    		});
    		
    		thread.start();
		});
	}

	public void assignValuesToEditMenuItems(Route route) {
		routeId.setText(String.valueOf(route.routeId()));
		routeName.setText(route.routeName());
		
		routeDestination.setText(String.valueOf(route.destinationTerminal()));
		
		hrDuration.setItems(hoursList());
		hrDuration.getSelectionModel().select(route.routeDuration().getHour());
		minDuration.setItems(minsList());
		minDuration.getSelectionModel().select(route.routeDuration().getMinute());
		
		hrStartIntervals.setItems(hoursList());
		hrStartIntervals.getSelectionModel().select(route.startIntervals().getHour());
		minStartIntervals.setItems(minsList());
		minStartIntervals.getSelectionModel().select(route.startIntervals().getMinute());
		
		routeDestination.setDisable(true);
		routeName.setDisable(true);
		routeId.setDisable(true);
	}	

	public ObservableList<Integer> minsList(){
		ObservableList<Integer> minutes = FXCollections.observableArrayList();

		for (int i = 0; i <= 59; i++){
		   minutes.add(i);
		}
		
		return minutes;
		
	}
	
	public ObservableList<Integer> hoursList(){
		ObservableList<Integer> hours = FXCollections.observableArrayList();

		for (int i = 0; i <= 23; i++){
		   hours.add(i);
		}
		
		return hours;
		
	}
	
	public boolean routeExists(Route route) {
		if(route == null) {
			App.dialogs("Route with that Id doesn't exist", "Route with that Id doesn't exist!", AlertType.INFORMATION, txtRouteId.getScene());   
			return false;
		}
		
		return true;
	}
	
	public boolean isNumeric(String string) {
			
	   	
	    if(string.equals("")) {
	    	App.dialogs("Id field can't be empty", "Id field can't be empty", AlertType.INFORMATION, txtRouteId.getScene());
	        return false;
	    }
	    
	    try {
	        int intValue = Integer.parseInt(string);
	        return true;
	    } catch (NumberFormatException e) {
	    	App.dialogs("Id field can be only a number", "Id field can only be a number", AlertType.INFORMATION, txtRouteId.getScene());
	    	return false;
	    }

	}
}
