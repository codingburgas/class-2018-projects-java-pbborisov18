package organisationOfPublicTransport.organisationOfPublicTransport;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Stage;
import javafx.util.StringConverter;
import models.Bus;
import models.Terminal;
import services.SelectAllBrokenBusesService;
import services.SelectAllTerminalService;
import services.UpdateFixBusService;

public class FixBusMenuController implements Initializable{

	@FXML
	private ComboBox<Bus> busCombobox;
	
	@FXML
	private ComboBox<Terminal> terminalCombobox;
	
	@FXML
	private Button confirmButton;
	 
	public ObservableList<Terminal> terminals; 
	public ObservableList<Bus> buses;


	public void displayTerminals() {
			
			Task<ObservableList<Terminal>> task = new SelectAllTerminalService();
			Thread thread = new Thread(task);
			thread.setDaemon(true);
			
			task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					//assigns the terminals we got from the query
					terminals = task.getValue();
					
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
					
					
					terminalCombobox.setConverter(converter);
					terminalCombobox.setItems(terminals);
					terminalCombobox.getSelectionModel().selectFirst();
					terminalCombobox.setCellFactory(terminals -> new BusComboBoxCell());
					
				}
			});

			thread.start();
	}

	
	public void displayBrokenBusses() {
		Task<ObservableList<Bus>> task = new SelectAllBrokenBusesService();
		Thread thread = new Thread(task);
		thread.setDaemon(true);
		
		
		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				
				buses = task.getValue();
				
				noBusesLeftToFix(buses);
				
				
				
				StringConverter<Bus> converter = new StringConverter<Bus>() {
					@Override
					public String toString(Bus object) {
						
						return object.busName();
					}

					@Override
					public Bus fromString(String string) {
						return null;
					}
				};
				
				
				busCombobox.setConverter(converter);
				busCombobox.setItems(buses);
				busCombobox.getSelectionModel().selectFirst();
				busCombobox.setCellFactory(buses -> new BrokenBusBoxCell());
				
			}
		});

		thread.start();
}
	
	
	public void noBusesLeftToFix(ObservableList<Bus> buses) {
		if(buses.isEmpty()) {
			App.dialogs("No broken buses", "No broken buses", AlertType.INFORMATION, busCombobox.getScene());
			Stage stage = (Stage) busCombobox.getScene().getWindow();
			stage.close();
		}
	}
	
	public void confirmButton(ActionEvent event) {
			
		Task<Void> task = new UpdateFixBusService(	busCombobox.getValue().busId(), 
													terminalCombobox.getValue().terminalId());
		
		Thread thread = new Thread(task);
		thread.setDaemon(true);
		
		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				App.dialogs("Succesfully updated!", "Successfully updated!", AlertType.INFORMATION, busCombobox.getScene());
				Stage stage = (Stage) busCombobox.getScene().getWindow();
				stage.close();
			}
		});
		
		thread.start();
		
	}

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		displayTerminals();
		displayBrokenBusses();
		
	}
	
}
