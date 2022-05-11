package organisationOfPublicTransport.organisationOfPublicTransport;

import java.net.URL;
import java.util.ResourceBundle;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ListView;
import models.Bus;
import services.BusesService;

public class MainMenuController implements Initializable  {
	
	@FXML
	private ListView<Bus> busListView;
	
	public static ObservableList<Bus> busses; 
	
	public void displayBusses() {
		
		Runnable helloRunnable = new Runnable() {
		    public void run() {
		    	
		    	busses = FXCollections.observableArrayList();
		    	
		    	Task<ObservableList<Bus>> task = new BusesService();
				Thread thread = new Thread(task);
				thread.setDaemon(true);
				
				task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						busses = task.getValue();
						busListView.setItems(busses);					
						busListView.setCellFactory(busses -> new BusListViewCell());
					}
		        });
				
				task.setOnFailed(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						
					}
		        });
				
				thread.start();
				
		    }
		};
		
		ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
		executor.scheduleAtFixedRate(helloRunnable, 0, 10, TimeUnit.SECONDS);
		
	}
	
	
	public void getRoutesFromService() {
		
	}
	
	public void getActionsFromService() {
		
	}


	//Executes when the main menu is loaded
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		displayBusses();
		
	}	
	
	
}
