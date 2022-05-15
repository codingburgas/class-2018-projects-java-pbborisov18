package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.ListView;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.StringConverter;
import models.Bus;
import models.Terminal;
import services.BusesService;
import services.TerminalService;

public class MainMenuController implements Initializable  {
	
	/* BUS MENU */
	@FXML
	private ListView<Bus> busListView;
	
	@FXML
	private ComboBox<Terminal> busComboBox;
	
	@FXML
	private Button brokenBusButton;
	
	
	public static ObservableList<Bus> busses; 
	public static ObservableList<Terminal> terminals; 
	
	//has to be initialized because I can't shutdown null
	//used for refreshing the bus menu every 10 secs
	ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
	
	/* BUS */
	
	//Executes every 10 secs looking for changes in the busses list
	//If changes are found they are displayed
	public void displayBusses(int id, boolean flag) {	
		Runnable helloRunnable = new Runnable() {
		    public void run() {
		    	busses = FXCollections.observableArrayList();
		    	
		    	Task<ObservableList<Bus>> task = new BusesService(id, flag);
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
		
		//schedules a task to be done every 10 secs
		executor = Executors.newScheduledThreadPool(1);
		executor.scheduleAtFixedRate(helloRunnable, 0, 10, TimeUnit.SECONDS);
		
	}
	
	//Displays the terminals in the combo box in the correct way
	public void displayBusSelection() {
		
		Task<ObservableList<Terminal>> task = new TerminalService();
		Thread thread = new Thread(task);
		thread.setDaemon(true);

		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				//assigns the terminals we got from the query
				terminals = task.getValue();
				terminals.add(new Terminal(0, "All"));

				StringConverter<Terminal> converter = new StringConverter<Terminal>() {
					@Override
					public String toString(Terminal object) {
						return object.terminalName();
					}

					@Override
					public Terminal fromString(String string) {
						return null;
					}
				};

				busComboBox.setConverter(converter);
				busComboBox.setItems(terminals);
				busComboBox.getSelectionModel().selectLast();
				busComboBox.setCellFactory(terminals -> new BusComboBoxCell());
			}
		});

		thread.start();
	}

	//Waits for a change in the combo box
	public void busSelectionChangeListener(ActionEvent event) {
		//kills the previous threadpool which updates the bus menu
		executor.shutdownNow();
		//a new threadpool is created inside
		if(busComboBox.getValue().terminalId() == 0) {
			displayBusses(busComboBox.getValue().terminalId(), true);	
		} else {
			displayBusses(busComboBox.getValue().terminalId(), false);
		}
		
	}
	
	public void brokenBusButtonListener(ActionEvent event) {
		
		Parent part;
		try {
			part = FXMLLoader.load(getClass().getResource("BrokenBus.fxml"));
			Stage stage = new Stage();
			Scene scene = new Scene(part);
			stage.setScene(scene);
			stage.initOwner(brokenBusButton.getScene().getWindow());
			//stage.resizableProperty().setValue(false);
			//stage.initStyle(StageStyle.TRANSPARENT);
			stage.initModality(Modality.APPLICATION_MODAL);
			stage.show();

			//Might be useful later when I focus on UI
			/*if(!stage.isFocused()) {
				stage.hide();
			}*/

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	/* ROUTES */
	
	public void displayRoutes() {
		
	}
	
	/* ACTIONS */
	
	public void displayActions() {
		
	}


	//Executes when the main menu is loaded
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		displayBusSelection();
		
	}	
	
	
}
