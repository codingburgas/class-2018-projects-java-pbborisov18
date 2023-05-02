package organisationOfPublicTransport.organisationOfPublicTransport;

import java.io.IOException;
import java.time.LocalTime;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Label;
import javafx.scene.control.ListCell;
import javafx.scene.layout.AnchorPane;
import models.Action;
import models.Bus;

public class ActionListViewCell extends ListCell<Action>{
		
	@FXML
	private AnchorPane anchorPane;
	
	@FXML
	private Label busName;
	
	@FXML
	private Label actionLabel;
	
	@FXML
	private Label timeLabel;
	
	private FXMLLoader mLLoader;
	
	private ObservableList<Action> actions;
	private ObservableList<Bus> buses;
	
	public ActionListViewCell(ObservableList<Action> actions, ObservableList<Bus> buses) {
		this.actions = actions;
		this.buses = buses;
	}	
	
	
	@Override
	public void updateItem(Action action, boolean empty) {
		// TODO Auto-generated method stub
		super.updateItem(action, empty);

		if (empty || action == null) {
			setText(null);
			setGraphic(null);
		} else {
			if(mLLoader == null) {
				mLLoader = new FXMLLoader(getClass().getResource("Action.fxml"));
				mLLoader.setController(this);
				
				try {
					mLLoader.load();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			for (Bus bus : buses) {
				if(action.busId() == bus.getBusId()) {
					busName.setText(bus.getBusName());
					timeLabel.setText("In " + action.time().minusHours(LocalTime.now().getHour()).minusMinutes(LocalTime.now().getMinute()).toString());
					String[] a = action.action().split(" ");

					if(a[0].equals("start")) {
						actionLabel.setText("Put " + bus.getBusName() + " on route " + a[1]);
					} else if(a[0].equals("arrival")) {
						actionLabel.setText(bus.getBusName() + " will arrive at terminal " + a[1]);
					} else if(a[0].equals("stop")){
						actionLabel.setText("Stop charging " + bus.getBusName());
					} else {
						actionLabel.setText("Start charging " + bus.getBusName());
					}

					break;

				}

				setText(null);
				setGraphic(anchorPane); 
			}
		}


	}
}

