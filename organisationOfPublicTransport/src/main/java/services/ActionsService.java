package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.common.collect.ListMultimap;
import com.google.common.collect.MultimapBuilder;

import database.ActionsQueries;
import database.BusQueries;
import database.EstablishConnection;
import database.RoutesQueries;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import models.Action;
import models.Bus;
import models.Route;
import utils.NotEnoughBusesException;



public class ActionsService extends Task<Void>{

	private ObservableList<Bus> buses = FXCollections.observableArrayList();
	private ObservableList<Route> routes = FXCollections.observableArrayList();
	
	private List<Bus> tempBusList = new ArrayList<Bus>();
	
//	public ActionsService(ObservableList<Bus> buses, ObservableList<Route> routes) {
//		this.buses = buses;
//		this.routes = routes;
//	}
	
	@Override
	protected Void call() throws NotEnoughBusesException, SQLException, InterruptedException{		

		Connection conn = EstablishConnection.establishConnection(false, null);

		if(conn.isValid(0)) {
			ResultSet rsBuses = BusQueries.selectBusQueryFromBusOriginal(conn);

			while(rsBuses.next()) {

				int busId = rsBuses.getInt("BusId");
				String busName = rsBuses.getString("BusName");
				int currentRouteId = rsBuses.getInt("CurrentRouteId");
				int currentTerminalId = rsBuses.getInt("CurrentTerminalId");
				boolean broken = rsBuses.getBoolean("Broken");
				boolean charging = rsBuses.getBoolean("Charging");
				int battery = rsBuses.getInt("Battery");
				int delay = rsBuses.getInt("Delay");

				Bus bus = new Bus(busId, busName, currentRouteId, currentTerminalId, broken, charging, battery, delay);

				buses.add(bus);
			}

			ResultSet rsRoutes = RoutesQueries.selectRouteById(0, true, conn);

			while(rsRoutes.next()) {

				int routeId = rsRoutes.getInt("RouteId");
				String routeName = rsRoutes.getString("RouteName");
				LocalTime routeDuration = rsRoutes.getTime("RouteDuration").toLocalTime();
				int batteryUsage = rsRoutes.getInt("BatteryUsage");
				int startTerminalId = rsRoutes.getInt("StartTerminalID");
				int destinationTerminalId = rsRoutes.getInt("DestinationTerminalId");
				LocalTime startInvervals = rsRoutes.getTime("StartIntervals").toLocalTime();

				Route route = new Route(routeId, routeName, routeDuration, batteryUsage, startTerminalId, destinationTerminalId, startInvervals);

				routes.add(route);		
			}


		}

		if(buses.equals(null) || routes.equals(null)) {
			return null;
		}
		
		ArrayList<Action> actions = algorithm();
				 
		if(actions == null) {
			throw new NotEnoughBusesException("There aren't enough buses to execute the algorithm!"); 
		}
		
		
		
		if(conn.isValid(0)) {
			//Have to re-design the algorithm for this to work
			BusQueries.updateAllBuses(tempBusList, conn);
			ActionsQueries.createActions(actions, conn);
			
//			if(success >= 1) {
//				System.out.println("poggers");
//			}

		} else {
			System.out.println("ActionsService: Connection is down");
		}
		
		conn.close();
		return null;
	}

	
	private ArrayList<Action> algorithm(){
		ArrayList<Action> actions = new ArrayList<>();
		
		//Used to artificially update the buses 'live' condition
		Boolean updatedBuses = false;
		
		try {
			LocalTime end = LocalTime.of(22, 00);

			ListMultimap<Comparable<LocalTime>, LinkedHashMap<Route, Boolean>> times = MultimapBuilder.treeKeys().linkedListValues().build();

			LinkedHashMap<Bus, LocalTime> activeBuses = new LinkedHashMap<>();
			LinkedHashMap<Bus, LocalTime> chargingBuses = new LinkedHashMap<>();

			for (Route route : routes) {
				LocalTime nextStart = LocalTime.of(6, 0);

				LocalTime interval = route.startIntervals();
//				ArrayList<LocalTime> startTimes = new ArrayList<>();
//				ArrayList<LocalTime> arrivalTimes = new ArrayList<>();
				
				while(nextStart.isBefore(end)) {
					
					nextStart = nextStart.plusHours(interval.getHour());
					nextStart = nextStart.plusMinutes(interval.getMinute());
					
					//if(nextStart.isAfter(LocalTime.now())) {
						LinkedHashMap<Route, Boolean> temp = new LinkedHashMap<>();
						temp.put(route, false);
						times.put(nextStart, temp);
						LinkedHashMap<Route, Boolean> temp2 = new LinkedHashMap<Route, Boolean>();
						temp2.put(route, true);
						times.put(nextStart.plusHours(route.routeDuration().getHour()).plusMinutes(route.routeDuration().getMinute()), temp2);
					//}
				}	
				

			}
			
			LocalTime chargingTime = LocalTime.of(0, 0);

			for (Comparable<LocalTime> time : times.keySet()) {
				//Used to artificially update the buses 'live' condition
				if(((LocalTime) time).isAfter(LocalTime.now()) && updatedBuses == false) {
					updatedBuses = true;
					
					//stupid ass java and it's pass by value stuff
					for (Bus bus : buses) {
						Bus tempBus = new Bus(bus.getBusId(), bus.getBusName(), bus.getCurrentRouteId(), bus.getCurrentTerminalId(), bus.isBroken(), bus.isCharging(), bus.getBattery(), bus.getDelay());
						tempBusList.add(tempBus);
					}
				} 

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


								if(bus.getBattery() < 45) {
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

							if(i == buses.size()-1) {
								return null;
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
							e.printStackTrace();
						}
					}
				}
			}
			
			return actions;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return actions;
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
