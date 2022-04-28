module organisationOfPublicTransport.organisationOfPublicTransport {
    requires javafx.controls;
    requires javafx.fxml;
	requires javafx.graphics;
	requires java.sql;

    opens organisationOfPublicTransport.organisationOfPublicTransport to javafx.fxml;
    exports organisationOfPublicTransport.organisationOfPublicTransport;
}
