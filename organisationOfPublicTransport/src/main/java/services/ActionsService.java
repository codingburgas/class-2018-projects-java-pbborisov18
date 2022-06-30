package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Optional;

import com.google.common.collect.LinkedHashMultimap;
import com.google.common.collect.ListMultimap;
import com.google.common.collect.Multimap;
import com.google.common.collect.MultimapBuilder;

import database.ActionsQueries;
import database.BusQueries;
import database.EstablishConnection;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Action;
import models.Bus;
import models.Route;



public class ActionsService extends Task<Void>{

	private ObservableList<Bus> buses;
	private ObservableList<Route> routes;
	
	public ActionsService(ObservableList<Bus> buses, ObservableList<Route> routes) {
		this.buses = buses;
		this.routes = routes;
	}
	
	@Override
	protected Void call() {
		if(buses.equals(null) || routes.equals(null)) {
			return null;
		}
		ArrayList<Action> actions = algorithm();
		
		try {
			Connection conn = EstablishConnection.establishConnection(false, null);
			if(conn.isValid(0)) {
				int[] success = ActionsQueries.createActions(actions, conn);
				
//				if(success >= 1) {
//					System.out.println("poggers");
//				}
				
				conn.close();
				
				
			} else {
				System.out.println("ActionsService: Connection is down");
			}
			conn.close();
			
		
		} catch (InterruptedException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	
	private ArrayList<Action> algorithm(){
		try {
		LocalTime end = LocalTime.of(22, 00);

		ListMultimap<Comparable<LocalTime>, LinkedHashMap<Route, Boolean>> times = MultimapBuilder.treeKeys().linkedListValues().build();
		ArrayList<Action> actions = new ArrayList<>();
		LinkedHashMap<Bus, LocalTime> activeBuses = new LinkedHashMap<>();
		LinkedHashMap<Bus, LocalTime> chargingBuses = new LinkedHashMap<>();
		
		for (Route route : routes) {
			LocalTime nextStart = LocalTime.of(6, 0);

			LocalTime interval = route.startIntervals();
			ArrayList<LocalTime> startTimes = new ArrayList<>();
			ArrayList<LocalTime> arrivalTimes = new ArrayList<>();
	
			while(nextStart.isBefore(end)) {

				nextStart = nextStart.plusHours(interval.getHour());
				nextStart = nextStart.plusMinutes(interval.getMinute());

				LinkedHashMap<Route, Boolean> temp = new LinkedHashMap<>();
				temp.put(route, false);
				times.put(nextStart, temp);
				LinkedHashMap<Route, Boolean> temp2 = new LinkedHashMap<Route, Boolean>();
				temp2.put(route, true);
				times.put(nextStart.plusHours(route.routeDuration().getHour()).plusMinutes(route.routeDuration().getMinute()), temp2);

			}	

		}
		
		LocalTime chargingTime = LocalTime.of(0, 0);

		for (Comparable<LocalTime> time : times.keySet()) {
			for (LinkedHashMap<Route, Boolean> insideMap : times.get(time)) {
				for (Route route : insideMap.keySet()) {
					Bus bus = getKey(activeBuses,(LocalTime) time);

					for (int i = 0; i < buses.size(); i++) {


						if(insideMap.get(route).equals(true)) {

							activeBuses.get(bus);

							activeBuses.remove(bus);

							bus.setBattery(bus.getBattery() - route.batteryUsage());

							bus.setCurrentTerminalId(route.destinationTerminal());
							bus.setCurrentRouteId(0);
							Action action = new Action(bus.getBusId(),(LocalTime) time, "arrival " + route.destinationTerminal());
							actions.add(action);


							if(bus.getBattery() < 50) {
								Action action2 = new Action(bus.getBusId(), (LocalTime) time,"charge");
								actions.add(action2);
								bus.setCharging(true);
								LocalTime tempLocalTime = (LocalTime) time;
								chargingTime = LocalTime.of(tempLocalTime.getHour(), tempLocalTime.getMinute());

								chargingBuses.put(bus, chargingTime);
							}

							break;
						};

						if(buses.get(i).getCurrentTerminalId() == route.startTerminalId() && buses.get(i).getBattery() > route.batteryUsage() && buses.get(i).isCharging() == false) {
							buses.get(i).setCurrentTerminalId(0);
							buses.get(i).setCurrentRouteId(route.routeId());
							LocalTime tempLocalTime = (LocalTime) time;
							activeBuses.put(buses.get(i), (LocalTime) tempLocalTime.plusHours(route.routeDuration().getHour()).plusMinutes(route.routeDuration().getMinute()));
							Action action = new Action(buses.get(i).getBusId(), (LocalTime) time, "start " + route.routeId());
							actions.add(action);
							break;
						}


					}
					try {
						if (!chargingBuses.isEmpty()) {

							for (Iterator<Bus> iterator = chargingBuses.keySet().iterator(); iterator.hasNext();) {
								Bus chargingBus = (Bus) iterator.next();
								LocalTime tempTime = (LocalTime) time;

								LocalTime timeBeingCharged = tempTime
										.minusHours(chargingBuses.get(chargingBus).getHour())
										.minusMinutes(chargingBuses.get(chargingBus).getMinute());
								int minutes = timeBeingCharged.getHour() * 60;
								minutes += timeBeingCharged.getMinute();
								if (chargingBus.getBattery() + minutes >= 100) {
									iterator.remove();
									chargingBus.setBattery(100);
									chargingBus.setCharging(false);
									Action action = new Action(chargingBus.getBusId(), (LocalTime) time, "stop charging");
									actions.add(action);
								}
							}

						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}


		return actions;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public <K, V> K getKey(Map<K, V> map, V value){
		
        for (Map.Entry<K, V> entry: map.entrySet()){
        	if (value.equals(entry.getValue())) {
                return entry.getKey();
            }
        }
        return null;
    }
}
