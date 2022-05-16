package organisationOfPublicTransport.organisationOfPublicTransport;

import javafx.scene.control.ListCell;
import models.Bus;

public class BrokenBusBoxCell extends ListCell<Bus> {
	@Override
	protected void updateItem(Bus item, boolean empty) {
		super.updateItem(item, empty);

	     if (empty || item == null) {
	         setText(null);
	         setGraphic(null);
	     } else {
	    	 setText(item.busName());
	     }
	}
}
