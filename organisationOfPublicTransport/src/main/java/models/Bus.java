package models;

import java.util.Objects;

public class Bus {
	
	public int busId;
	public String busName; 
	public int currentRouteId; 
	public int currentTerminalId; 
	public Boolean broken; 
	public Boolean charging; 
	public int battery; 
	public int delay;
	
	public Bus(int busId, String busName, int currentRouteId, int currentTerminalId, boolean broken,
			boolean charging, int battery, int delay) {
		
		this.busId = busId;
		this.busName = busName;
		this.currentRouteId = currentRouteId;
		this.currentTerminalId = currentTerminalId;
		this.broken = broken;
		this.charging = charging;
		this.battery = battery;
		this.delay = delay;
	}

	
	
	@Override
	public int hashCode() {
		return Objects.hash(battery, broken, busId, busName, charging, currentRouteId, currentTerminalId, delay);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Bus other = (Bus) obj;
		return battery == other.battery && broken == other.broken && busId == other.busId
				&& Objects.equals(busName, other.busName) && charging == other.charging
				&& currentRouteId == other.currentRouteId && currentTerminalId == other.currentTerminalId
				&& delay == other.delay;
	}

	@Override
	public String toString() {
		return "BusClass [busId=" + busId + ", busName=" + busName + ", currentRouteId=" + currentRouteId
				+ ", currentTerminalId=" + currentTerminalId + ", broken=" + broken + ", charging=" + charging
				+ ", battery=" + battery + ", delay=" + delay + "]";
	}



	public int getBusId() {
		return busId;
	}



	public void setBusId(int busId) {
		this.busId = busId;
	}



	public String getBusName() {
		return busName;
	}



	public void setBusName(String busName) {
		this.busName = busName;
	}



	public int getCurrentRouteId() {
		return currentRouteId;
	}



	public void setCurrentRouteId(int currentRouteId) {
		this.currentRouteId = currentRouteId;
	}



	public int getCurrentTerminalId() {
		return currentTerminalId;
	}



	public void setCurrentTerminalId(int currentTerminalId) {
		this.currentTerminalId = currentTerminalId;
	}



	public Boolean isBroken() {
		return broken;
	}



	public void setBroken(boolean broken) {
		this.broken = broken;
	}



	public Boolean isCharging() {
		return charging;
	}



	public void setCharging(boolean charging) {
		this.charging = charging;
	}



	public int getBattery() {
		return battery;
	}



	public void setBattery(int battery) {
		this.battery = battery;
	}



	public int getDelay() {
		return delay;
	}



	public void setDelay(int delay) {
		this.delay = delay;
	}
	
	

}
