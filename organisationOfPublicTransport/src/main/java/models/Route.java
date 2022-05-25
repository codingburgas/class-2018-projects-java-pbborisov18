package models;

import java.time.LocalTime;

public record Route(	int routeId, String routeName, 
						LocalTime routeDuration, int batteryUsage,
						int startTerminalId,int destinationTerminal, LocalTime startIntervals) {
	

}
