package services;

import java.time.LocalTime;

import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Action;
import models.Bus;
import models.Route;


//NOT WORKING AND NOT IN USE
public class ActionsService extends Task<ObservableList<Action>>{

	private ObservableList<Bus> buses;
	private ObservableList<Route> routes;
	
	public ActionsService(ObservableList<Bus> buses, ObservableList<Route> routes) {
		this.buses = buses;
		this.routes = routes;
	}
	
	@Override
	protected ObservableList<Action> call() throws Exception {
		LocalTime start = LocalTime.of(6, 0);
		LocalTime now = LocalTime.now();
		
		
		LocalTime end = LocalTime.of(23, 00);
		
		for (Route route : routes) {
			System.out.println(route.routeName());
			LocalTime nextStart = LocalTime.of(6, 0);
			
			LocalTime interval = route.startIntervals();
			
			while(nextStart.isBefore(end)) {
				nextStart = nextStart.plusHours(interval.getHour());
				nextStart = nextStart.plusMinutes(interval.getMinute());
				
				/*for (Bus bus : buses) {
					if(bus.currentTerminalId() == route.startTerminalId() && bus.battery() > route.batteryUsage()) {
						
					}
				}*/
			}					
			
		}
		
//		while(nextStart.isBefore(now)){
//			nextStart = nextStart.plus(interval);
//		}
		
		return null;
	}

}
