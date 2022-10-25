package utils;

/**
 * The NotEnoughBusesException is a custom exception which should be thrown when there are not enough buses for the algorithm to work.
 * 
 * @author Petar Borisov
 */

public class NotEnoughBusesException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6740142740219312840L;
	
	public NotEnoughBusesException(String message) {
		super(message);
	}
	
	public NotEnoughBusesException(Throwable cause) {
		super(cause);
	}
	
	public NotEnoughBusesException(String message, Throwable cause) {
		super(message, cause);
	}
}
