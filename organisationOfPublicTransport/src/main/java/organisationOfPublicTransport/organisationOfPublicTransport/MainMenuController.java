package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;
import java.net.URL;
import java.sql.Time;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalUnit;
import java.util.ResourceBundle;
import java.util.concurrent.CountDownLatch;
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
import models.Route;
import models.Terminal;
import services.SelectAllNotBrokenBusesService;
import services.SelectAllRoutesService;
import services.SelectAllTerminalService;

public class MainMenuController implements Initializable  {
	
	/* BUS MENU */
	@FXML
	private ListView<Bus> busListView;
	
	@FXML
	private ComboBox<Terminal> busTerminalComboBox;
	
	@FXML
	private Button brokenBusButton;
	
	/* ROUTES MENU */
	@FXML
	private ListView<Route> routeListView;
	
	
	
	private ObservableList<Bus> busses; 
	private ObservableList<Terminal> terminals; 
	private ObservableList<Bus> getAllBuses;
	private ObservableList<Route> routes;
	
	//has to be initialized because I can't shutdown null
	//used for refreshing the bus menu every 10 secs
	ScheduledExecutorService busExecutor = Executors.newScheduledThreadPool(1);
	ScheduledExecutorService routeExecutor = Executors.newScheduledThreadPool(1);
	ScheduledExecutorService actionsExecutor = Executors.newScheduledThreadPool(1);
	
	/* BUS */
	
	//Executes every 10 secs looking for changes in the busses list
	//If changes are found they are displayed
	public void displayBusses(int id, boolean flag) {	
		Runnable runnable = new Runnable() {
		    public void run() {
		    	busses = FXCollections.observableArrayList();
		    	
		    	Task<ObservableList<Bus>> task = new SelectAllNotBrokenBusesService(id, flag);
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
				
				thread.start();
				
		    }
		};
		
		//schedules a task to be done every 10 secs
		busExecutor = Executors.newScheduledThreadPool(1);
		busExecutor.scheduleAtFixedRate(runnable, 0, 10, TimeUnit.SECONDS);
		
	}
	
	//Displays the terminals in the combo box in the correct way
	public void displayBusSelection() {
		Task<ObservableList<Terminal>> task = new SelectAllTerminalService();
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

				busTerminalComboBox.setConverter(converter);
				busTerminalComboBox.setItems(terminals);
				busTerminalComboBox.getSelectionModel().selectLast();
				busTerminalComboBox.setCellFactory(terminals -> new BusComboBoxCell());
			}
		});
		
		task.setOnFailed(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				displayBusSelection();
			}
		});
		
		thread.start();
	}	
	
	//Waits for a change in the combo box
	public void busSelectionChangeListener(ActionEvent event) {
		//kills the previous threadpool which updates the bus menu
		busExecutor.shutdownNow();
		//a new threadpool is created inside
		if(busTerminalComboBox.getValue().terminalId() == 0) {
			displayBusses(busTerminalComboBox.getValue().terminalId(), true);	
		} else {
			displayBusses(busTerminalComboBox.getValue().terminalId(), false);
		}
		
	}
	
	//If the Broken bus buttons is pressed this executes
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
	
	//If the fix bus buttons is pressed
	public void fixBusButtonListener(ActionEvent event) {
		
		Parent part;
		try {
			part = FXMLLoader.load(getClass().getResource("FixBus.fxml"));
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
	//Executes every 10 secs looking for changes in the bus list
	//Updates the info on the route menu
	public void displayRoutes() {
		Runnable Runnable = new Runnable() {
		    public void run() {
		    	
		    	CountDownLatch cdLatch = new CountDownLatch(1);
		    	
		    	//Get all Buses in db
		    	Task<ObservableList<Bus>> task2 = new SelectAllNotBrokenBusesService(0, true);;
				Thread thread2 = new Thread(task2);
				thread2.setDaemon(true);
		    	
				//Get all Routes in db
		    	Task<ObservableList<Route>> task = new SelectAllRoutesService(0, true);;
				Thread thread = new Thread(task);
				thread.setDaemon(true);
				
				//When all the buses are in the Observable list
				//Then all the routes are gotten from the db and placed in the cells together with the bus info
				task2.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						
						getAllBuses = task2.getValue();
						cdLatch.countDown();
						
						
						task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
							@Override
							public void handle(WorkerStateEvent event) {
								routes = task.getValue();
								routeListView.setItems(routes);					
								routeListView.setCellFactory(routes -> new RouteListViewCell(getAllBuses));
							}
				        });
						
						
					}
		        });
				
				task2.setOnFailed(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						task2.cancel();
						cdLatch.countDown();
					}
				});
				
				
				thread2.start();
				
				try {
					cdLatch.await();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				thread.start();
				
		    }
		};
		
		routeExecutor = Executors.newScheduledThreadPool(1);
		routeExecutor.scheduleAtFixedRate(Runnable, 0, 10, TimeUnit.SECONDS);
	}

	public void rerouteListener(ActionEvent event) {
		Parent part;
		try {
			part = FXMLLoader.load(getClass().getResource("RerouteSearch.fxml"));
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
	
	
	/* ACTIONS */
	//Not working no time to fully implement
	public void displayActions() {
		Runnable Runnable = new Runnable() {
			public void run() {
				
				LocalTime start = LocalTime.of(6, 0);
				LocalTime now = LocalTime.now();
				
				
				LocalTime end = LocalTime.of(23, 00);
				
				for (Route route : routes) {
					//System.out.println(route.routeName());
					LocalTime nextStart = LocalTime.of(6, 0);
					
					LocalTime interval = route.startIntervals();
					
					while(nextStart.isBefore(end)) {
						nextStart = nextStart.plusHours(interval.getHour());
						nextStart = nextStart.plusMinutes(interval.getMinute());
						//System.out.println(nextStart);
						/*for (Bus bus : buses) {
							if(bus.currentTerminalId() == route.startTerminalId() && bus.battery() > route.batteryUsage()) {
								
							}
						}*/
					}					
					
				}
			}
		};

		routeExecutor = Executors.newScheduledThreadPool(1);
		routeExecutor.scheduleAtFixedRate(Runnable, 5, 60, TimeUnit.SECONDS);
	}
	
	public void startActions() {
		
	}


	//Executes when the main menu is loaded
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		displayBusSelection();
		displayRoutes();
		
		 
		//Not working
		displayActions();
	}	
	
	
}
