package models;

import java.time.LocalTime;

public record Action(int busId, LocalTime time, String action) {
	
}
