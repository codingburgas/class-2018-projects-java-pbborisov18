package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;
import java.util.ArrayList;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Label;
import javafx.scene.control.ListCell;
import javafx.scene.layout.AnchorPane;
import models.Bus;
import models.Route;

public class RouteListViewCell extends ListCell<Route>{

	@FXML
	private Label routeName;
	
	@FXML
	private Label activeBusses;
	
	@FXML
	private Label nextBusToStartRoute;
	
	@FXML
	private Label nextBusToArrive;
	
	@FXML
	private AnchorPane anchorPane;
	
	private FXMLLoader mLLoader;
	
	private ObservableList<Bus> buses;
	
	public RouteListViewCell(ObservableList<Bus> buses) {
		this.buses = buses;
	}
	
	
	@Override
	protected void updateItem(Route route, boolean empty) {
		// TODO Auto-generated method stub
		super.updateItem(route, empty);
		
		if (empty || route == null) {
	         setText(null);
	         setGraphic(null);
	     } else {
	    	 if (mLLoader == null) {
	    		 mLLoader = new FXMLLoader(getClass().getResource("Route.fxml"));
	    		 mLLoader.setController(this);

	    		 try {
	    			 mLLoader.load();
	    		 } catch (IOException e) {
	    			 e.printStackTrace();
	    		 }

	    	 }

	    	 routeName.setText(route.routeName());

	    	 ArrayList<String> busIds = new ArrayList<String>();

	    	 for (Bus bus : buses) {
	    		 if(bus.getCurrentRouteId() == route.routeId()) {
	    			 busIds.add(Integer.toString(bus.getBusId()));
	    		 }
	    	 }
	    	 activeBusses.setText("Current Buses Active: " +  busIds.toString());
	    	 //nextBusToStartRoute.setText("test");
	    	 //nextBusToArrive.setText("test");

	    	 setText(null);
	    	 setGraphic(anchorPane);
	     }
	}
	
}
