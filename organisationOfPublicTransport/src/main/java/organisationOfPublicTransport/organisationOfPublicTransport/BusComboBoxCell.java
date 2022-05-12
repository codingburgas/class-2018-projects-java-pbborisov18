package organisationOfPublicTransport.organisationOfPublicTransport;

import javafx.scene.control.ListCell;
import models.Terminal;

public class BusComboBoxCell extends ListCell<Terminal> {
	@Override
	protected void updateItem(Terminal item, boolean empty) {
		super.updateItem(item, empty);

	     if (empty || item == null) {
	         setText(null);
	         setGraphic(null);
	     } else {
	    	 setText(item.terminalName());
	     }
	}
}
