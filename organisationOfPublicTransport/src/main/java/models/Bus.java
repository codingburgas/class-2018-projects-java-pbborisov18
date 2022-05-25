package models;

public record Bus(	int busId, String busName, int currentRouteId, 
					int currentTerminalId, Boolean broken, 
					Boolean charging, int battery, int delay) {
	
}
