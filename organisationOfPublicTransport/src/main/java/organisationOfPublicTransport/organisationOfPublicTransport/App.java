package organisationOfPublicTransport.organisationOfPublicTransport;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.image.Image;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCombination;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;
import java.io.IOException;


public class App extends Application {

    private static Scene scene;
       
    @Override
    public void start(Stage stage) throws IOException {
    	scene = new Scene(loadFXML("login"));
        
        stage.setFullScreen(true);
        stage.setFullScreenExitHint("");
        stage.setFullScreenExitKeyCombination(KeyCombination.NO_MATCH);
        
        stage.addEventHandler(KeyEvent.KEY_PRESSED, event -> {
            if (KeyCode.F11.equals(event.getCode())) {
                stage.setFullScreen(!stage.isFullScreen());
            }
        });
        
        Image icon = new Image(getClass().getResourceAsStream("/icon/busLogo.png"));
        stage.getIcons().add(icon);
        
        //css
        //scene.getStylesheets().add(getClass().getResource("/OrganisationOfPublicTransport/Login/css/login.css").toExternalForm());
        
        stage.setScene(scene);
        stage.show();
    }

    public static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }
 
    
    public static void dialogs(String title, String text, AlertType type, Scene s) {
    	Alert alert = new Alert(type);

    	alert.setTitle(title);
		alert.setHeaderText(null);
		alert.setContentText(text);
		alert.initOwner(s.getWindow());
		alert.showAndWait();
    }

    public static void main(String[] args) {
        launch();
    }

}