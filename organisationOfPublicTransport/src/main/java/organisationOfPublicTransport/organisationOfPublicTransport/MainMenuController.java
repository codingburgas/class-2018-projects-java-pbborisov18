package organisationOfPublicTransport.organisationOfPublicTransport;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import models.Bus;
import services.BusesService;

public class MainMenuController {
	
	public static List<Bus> busses = new ArrayList<Bus>(); 
	
	public static void ass() {
		
		Runnable helloRunnable = new Runnable() {
		    public void run() {
		    	
		    	
		    	Task<List<Bus>> task = new BusesService();
				Thread thread = new Thread(task);
				thread.setDaemon(true);
				
				task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						busses = task.getValue();
					}
		        });
				
				task.setOnFailed(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						
					}
		        });
				
				for (Bus bus : busses) {
					System.out.println(bus.toString());
				}
				
				thread.start();
		    }
		};
		
		ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
		executor.scheduleAtFixedRate(helloRunnable, 0, 1, TimeUnit.SECONDS);
		
	}
}
