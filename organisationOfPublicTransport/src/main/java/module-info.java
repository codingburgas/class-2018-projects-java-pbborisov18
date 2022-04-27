module organisationOfPublicTransport.organisationOfPublicTransport {
    requires javafx.controls;
    requires javafx.fxml;

    opens organisationOfPublicTransport.organisationOfPublicTransport to javafx.fxml;
    exports organisationOfPublicTransport.organisationOfPublicTransport;
}
