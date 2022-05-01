module organisationOfPublicTransport.organisationOfPublicTransport {
    requires javafx.controls;
    requires javafx.fxml;
	requires javafx.graphics;
	requires java.sql;
	requires org.assertj.core;
	
    opens organisationOfPublicTransport.organisationOfPublicTransport to javafx.fxml;
    exports organisationOfPublicTransport.organisationOfPublicTransport;
}
