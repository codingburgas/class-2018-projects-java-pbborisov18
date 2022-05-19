package models;

import java.time.LocalTime;

public record Route(	int routeId, String routeName, 
						LocalTime routeDuration, int destinationTerminal, LocalTime startIntervals) {

}
