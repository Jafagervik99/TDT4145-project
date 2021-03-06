package databaser.ui.controllers;

import databaser.ui.Page;
import databaser.ui.TrainingApp;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;

public abstract class BaseController implements Initializable {

    @FXML
    public void goTo(ActionEvent event, Page page) throws IOException {
        URL resource = getClass().getResource(page.fxmlPath());
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(resource);
        Parent root = loader.load();

        Stage primaryStage = TrainingApp.primaryStage;
        primaryStage.setTitle(page.title());
        primaryStage.setScene(new Scene(root, TrainingApp.WIDTH, TrainingApp.HEIGHT));
        primaryStage.show();
    }
}
