package models;

public record Bus(	int busId, String busName, int currentRouteId, 
					int CurrentTerminalId, Boolean broken, 
					Boolean charging, int battery, int delay) {
	
}
