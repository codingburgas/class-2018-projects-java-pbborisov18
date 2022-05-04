package organisationOfPublicTransport.organisationOfPublicTransport;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import services.BusesService;

public class MainMenuController {
	
	public static void ass() {
		
		Runnable helloRunnable = new Runnable() {
		    public void run() {
		    	
		    	Task<Void> task = new BusesService();
				Thread thread = new Thread(task);
				thread.setDaemon(true);
				
				task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						System.out.println("it done");
					}
		        });
				
				task.setOnFailed(new EventHandler<WorkerStateEvent>() {
					@Override
					public void handle(WorkerStateEvent event) {
						System.out.println("it done");
					}
		        });
				
				thread.start();
		    }
		};
		
		ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
		executor.scheduleAtFixedRate(helloRunnable, 0, 10, TimeUnit.SECONDS);
		
	}
}
