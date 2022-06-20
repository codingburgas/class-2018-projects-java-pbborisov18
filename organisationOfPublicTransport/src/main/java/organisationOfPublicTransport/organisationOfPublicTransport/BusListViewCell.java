package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Label;
import javafx.scene.control.ListCell;
import javafx.scene.layout.AnchorPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import models.Bus;

public class BusListViewCell extends ListCell<Bus> {
	
	@FXML
	private Label busName;
	
	@FXML
	private Circle activeStatus;
	
	@FXML
	private Label battery;
	
	@FXML
	private Label route;
	
	@FXML
	private AnchorPane anchorPane;
	
	private FXMLLoader mLLoader;
	
	@Override
	protected void updateItem(Bus bus, boolean empty) {
		// TODO Auto-generated method stub
		super.updateItem(bus, empty);
		
		if (empty || bus == null) {
	         setText(null);
	         setGraphic(null);
	     } else {
	    	 if (mLLoader == null) {
	                mLLoader = new FXMLLoader(getClass().getResource("bus.fxml"));
	                mLLoader.setController(this);

	                try {
	                    mLLoader.load();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }

	         	}
	    	 
	    	 if(bus.isCharging().equals(true)) {
	    		activeStatus.setFill(Color.YELLOW); 
	    	 } else {
	    		activeStatus.setFill(Color.GREEN);
	    	 }
	    	 
	    	 busName.setText(bus.getBusName());
	    	 battery.setText("Battery: " + String.valueOf(bus.getBattery()));
	    	 route.setText("Route: " + String.valueOf(bus.getCurrentRouteId()));
	    	 
	         setText(null);
	         setGraphic(anchorPane);
	     }

		
	}
}
