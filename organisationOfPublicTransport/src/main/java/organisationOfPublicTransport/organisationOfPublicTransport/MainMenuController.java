package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;
import java.net.URL;
import java.sql.Time;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalUnit;
import java.util.HashMap;
import java.util.ResourceBundle;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.google.common.cache.LoadingCache;

import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.image.Image;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.StringConverter;
import models.Action;
import models.Bus;
import models.Route;
import models.Terminal;
import services.ActionsService;
import services.SelectActionsService;
import services.SelectAllNotBrokenBusesService;
import services.SelectAllRoutesService;
import services.SelectAllTerminalService;
import services.UpdateBusesBasedOnPredictionService;

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
	
	/* ACTIONS MENU */
	@FXML
	private ListView<Action> actionListView;
	@FXML
	private VBox actionsVBox;
	
	@FXML
	private Circle statusCircle;
	@FXML
	private Label informationStatusText;
	
	private ObservableList<Bus> busses = FXCollections.observableArrayList(); 
	private ObservableList<Terminal> terminals = FXCollections.observableArrayList(); 
	private ObservableList<Bus> getAllBuses = FXCollections.observableArrayList();
	private ObservableList<Route> routes = FXCollections.observableArrayList();
	private ObservableList<Action> actions = FXCollections.observableArrayList();
	
	//has to be initialized because I can't shutdown null
	//used for refreshing the bus, route and actions menu every 10 secs
	ScheduledExecutorService busExecutor = Executors.newScheduledThreadPool(1);
	ScheduledExecutorService routeExecutor = Executors.newScheduledThreadPool(1);
	ScheduledExecutorService actionsExecutor = Executors.newScheduledThreadPool(1);
	ScheduledExecutorService updateActionsExecutor = Executors.newScheduledThreadPool(1);
	ScheduledExecutorService displayActionsExecutor = Executors.newScheduledThreadPool(1);
	
	ProgressIndicator loadingCircle = new ProgressIndicator();
	
	//Executes when the main menu is loaded
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		displayBusSelection();
		displayRoutes();
		updateActions();
		//busStatusUpdate();
	}
	
	/* BUS */
	
	//Executes every 5 secs looking for changes in the busses list
	//If changes are found they are displayed
	public void displayBusses(int id, boolean allFlag) {	
		Runnable runnable = new Runnable() {
			public void run() {

				Task<ObservableList<Bus>> task = new SelectAllNotBrokenBusesService(id, allFlag);
				Thread thread = new Thread(task);
				thread.setDaemon(true);

				task.setOnSucceeded((WorkerStateEvent event) -> {
					busses = task.getValue();
					busListView.setItems(busses);					
					busListView.setCellFactory(busses -> new BusListViewCell());

				});

				thread.start();

			}
		};

		//schedules a task to be done every 10 secs
		busExecutor = Executors.newScheduledThreadPool(1);
		busExecutor.scheduleAtFixedRate(runnable, 0, 5, TimeUnit.SECONDS);

	}
	
	//Displays the terminals in the combo box in the correct way
	public void displayBusSelection() {
		Task<ObservableList<Terminal>> task = new SelectAllTerminalService();
		Thread thread = new Thread(task);
		thread.setDaemon(true);

		task.setOnSucceeded((WorkerStateEvent event) -> {
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

		});
		
//		task.setOnFailed(new EventHandler<WorkerStateEvent>() {
//			@Override
//			public void handle(WorkerStateEvent event) {
//				displayBusSelection();
//			}
//		});
		
		thread.start();
	}	
	
	
	
	//Makes the buses change (almost) instant
	public void busSelectionChangeListener() {
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
			Image icon = new Image(getClass().getResourceAsStream("/icon/busLogo.png"));
	        stage.getIcons().add(icon);
			
			stage.show();

			//Doesn't ignore children windows
//			stage.focusedProperty().addListener((ov, onHidden, onShown) -> {
//	            if(!stage.isFocused())
//	            	updateActionsExecutor.shutdown();
//					updateActions();
//				
//					
//	                Platform.runLater(() -> stage.close());
//	        });		
			
			//Might be useful later when I focus on UI
//			if(!stage.isFocused()) {
//				stage.close();
//			}

		} catch (IOException e) {
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
			Image icon = new Image(getClass().getResourceAsStream("/icon/busLogo.png"));
	        stage.getIcons().add(icon);
			
	        stage.show();
			
//			updateActionsExecutor.shutdown();
//			updateActions();
//			
//			displayBusSelection();
			
			//When there are no buses a pop-up appears telling the user that -> window loses focus and closes together with its child
			/*stage.focusedProperty().addListener((ov, onHidden, onShown) -> {
	            if(!stage.isFocused())
	                Platform.runLater(() -> stage.close());
	        });*/
	        
			//Might be useful later when I focus on UI
			/*if(!stage.isFocused()) {
				stage.hide();
			}*/

		} catch (IOException e) {
			
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
				task2.setOnSucceeded((WorkerStateEvent event) -> {

					getAllBuses = task2.getValue();
					cdLatch.countDown();


					task.setOnSucceeded((WorkerStateEvent event2) -> {
						routes = task.getValue();
						routeListView.setItems(routes);					
						routeListView.setCellFactory(routes -> new RouteListViewCell(getAllBuses));
					});



				});

				task2.setOnFailed((WorkerStateEvent event) -> {
					task2.cancel();
					cdLatch.countDown();
				});

				
				thread2.start();
				
				try {
					cdLatch.await();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
				thread.start();
				
		    }
		};
		
		routeExecutor = Executors.newScheduledThreadPool(1);
		routeExecutor.scheduleAtFixedRate(Runnable, 0, 5, TimeUnit.SECONDS);
	}

	//If the reroute button is pressed
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
			Image icon = new Image(getClass().getResourceAsStream("/icon/busLogo.png"));
	        stage.getIcons().add(icon);
			
			stage.show();
			
			
//			stage.focusedProperty().addListener((ov, onHidden, onShown) -> {
//	            if(!stage.isFocused())
//	                Platform.runLater(() -> stage.close());
//	        });
			
			
//			updateActionsExecutor.shutdown();
//			updateActions();
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
	//Displays actions
	public void displayActions() {
		Runnable Runnable = new Runnable() {
			public void run() {
				Task<ObservableList<Action>> task = new SelectActionsService();
				Thread thread = new Thread(task);
				thread.setDaemon(true);
				
				task.setOnSucceeded((WorkerStateEvent event) -> {
					actions = task.getValue();
					actionListView.setItems(actions);
					statusCircle.setFill(Color.GREEN);
					informationStatusText.setText("");

					actionListView.setCellFactory(actionListView -> new ActionListViewCell(actions, getAllBuses));
				});

				task.setOnFailed((WorkerStateEvent event) -> {
					statusCircle.setFill(Color.ORANGE);
					informationStatusText.setText("Failed to display!");
				});
				
				
				
				
				thread.start();
			}
		};

		displayActionsExecutor = Executors.newScheduledThreadPool(1);
		displayActionsExecutor.scheduleAtFixedRate(Runnable, 0, 5, TimeUnit.SECONDS);
	}
	
	//Simple algorithm which determines actions
	public void updateActions() {
		Runnable Runnable = new Runnable() {
			public void run() {
				//enableLoadingCircle();
				
				Task<Void> task = new ActionsService();
				Thread thread = new Thread(task);
				thread.setDaemon(true);

				task.setOnSucceeded((WorkerStateEvent event) -> {
					statusCircle.setFill(Color.YELLOW);
					//disableLoadingCircle();

					informationStatusText.setText("Successfull execution of the algorithm!");
					
					displayActionsExecutor.shutdown();
					
					displayActions();
				});

				task.setOnFailed((WorkerStateEvent event) -> {
					statusCircle.setFill(Color.RED);
					informationStatusText.setText("There aren't enough buses active!");
					disableLoadingCircle();

					System.out.println(task.getException());
					displayActionsExecutor.shutdown();
				});

				thread.start();	
			}
		};

		updateActionsExecutor = Executors.newScheduledThreadPool(1);
		updateActionsExecutor.scheduleAtFixedRate(Runnable, 0, 10, TimeUnit.SECONDS);
	}
	

	
	/* Additional */
	//Update bus info from actions
//	public void busStatusUpdate() {
//		Runnable Runnable = new Runnable() {
//			public void run() {
//				Task<Void> task = new UpdateBusesBasedOnPredictionService();
//				Thread thread= new Thread(task);
//				thread.setDaemon(true);
//
//				task.setOnSucceeded((WorkerStateEvent event) -> {
//					System.out.println("what");	
//				});
//
//				task.setOnFailed((WorkerStateEvent event) -> {
//					System.out.println("what2");
//				}); 
//
//				thread.start();	
//			}
//
//		};
//
//		ScheduledExecutorService busStatusExecutor = Executors.newScheduledThreadPool(1);
//		busStatusExecutor.scheduleAtFixedRate(Runnable, 0, 60, TimeUnit.SECONDS);
//	}
	
	//Loading circle
	public void enableLoadingCircle() {
		loadingCircle.setProgress(-1);
		loadingCircle.setVisible(true);
		actionsVBox.getChildren().add(1, loadingCircle);
	}
	
	public void disableLoadingCircle() {
		actionsVBox.getChildren().remove(loadingCircle);
	}
	
		
	
	
}
