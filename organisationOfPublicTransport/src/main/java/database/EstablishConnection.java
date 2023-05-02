package database;

import java.sql.Connection;
import java.util.concurrent.CountDownLatch;

import javafx.application.Platform;
import javafx.concurrent.Task;
import javafx.concurrent.WorkerStateEvent;
import javafx.event.EventHandler;
import javafx.scene.Node;
import javafx.scene.control.Alert.AlertType;
import organisationOfPublicTransport.organisationOfPublicTransport.App;

public class EstablishConnection {
	static Connection conn;
	
	//popup if you want a pop up
	//if popup is true you MUST provide a node otherwise can be null
	public static Connection establishConnection(boolean popup, Node node) throws InterruptedException {
		CountDownLatch latch = new CountDownLatch(1);
		Task<Connection> task = new ConnectionToDB();
		Thread thread = new Thread(task);
		thread.setDaemon(true);
		
		if(popup == false) {
			task.setOnFailed(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					latch.countDown();
				}
			});
		} else {

			task.setOnFailed(new EventHandler<WorkerStateEvent>() {
				@Override
				public void handle(WorkerStateEvent event) {
					Platform.runLater(new Runnable() {
						@Override
						public void run() {
							if(node != null) {
								App.dialogs("Connection failed!", "Connection failed!", AlertType.ERROR, node.getScene());
							} else {
								System.out.println("ERROR: EstablishConnection can't be true and null at the same time");
							}
						}
					});
					latch.countDown();
				}

			});
		}
		
		task.setOnSucceeded(new EventHandler<WorkerStateEvent>() {
			@Override
			public void handle(WorkerStateEvent event) {
				conn = task.getValue();
				latch.countDown();
			}
		});
		
		thread.start();

		latch.await();
		
		return conn;
	}
}
