package databaser.ui;

import databaser.persistence.*;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ØktController {

    public static Treningsøkt økt;
    public static Øvelse currentØvelse;

    public Label øktLabel;

    //Ny øvelse
    public ChoiceBox<Øvelsesgruppe> gruppeChoiceBox;
    public ComboBox<String> øvelseChoiceBox;
    public TextArea nyØvelseKommentar;
    public TextField setsTextField;
    public TextField repsTextField;
    public TextField weightTextField;
    public Button nyØvelseButton;

    public ListView<Øvelse> øvelseListView;

    public ArrayList<Øvelse> øvelseArrayList = new ArrayList<>();


    public void setØkt(Treningsøkt økt) {
        this.økt = økt;
    }

    public void initialize() {
        setØktLabel();
        updateGruppeChoiceBox();
        resetØvelseInputFields();
        updateØvelseListView();
    }

    private void setØktLabel() {
        øktLabel.setText(økt.toString());
    }

    public void updateØvelseListView(){
        ObservableList<Øvelse> items = øvelseListView.getItems();
        items.clear();

        List<Øvelse> øvelser = økt.getØvelser();

        items.addAll(øvelser);
    }

    public void goToDagbok(ActionEvent event) throws IOException {
        URL resource = getClass().getResource("/Dagbok.fxml");
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(resource);
        Parent root = loader.load();

        Stage primaryStage = (Stage) øktLabel.getScene().getWindow();
        primaryStage.setScene(new Scene(root, 1280, 720));
        primaryStage.show();
    }

    private void updateGruppeChoiceBox() {
        ObservableList<Øvelsesgruppe> items = gruppeChoiceBox.getItems();
        items.clear();
        List<Øvelsesgruppe> grupper = Øvelsesgruppe.getAll();

        for (Øvelsesgruppe gruppe : grupper) {
            items.add(gruppe);
        }
    }

    public void resetØvelseInputFields() {

        setsTextField.setVisible(false);
        repsTextField.setVisible(false);
        weightTextField.setVisible(false);
        nyØvelseKommentar.setVisible(false);
        weightTextField.setText("");
        repsTextField.setText("");
        setsTextField.setText("");
        nyØvelseKommentar.setText("");

    }


    public void setInputFieldVisibility() {
        Øvelse øvelse = findØvelseFromString();
        if (øvelse instanceof Apparatøvelse) {
            setsTextField.setVisible(true);
            repsTextField.setVisible(true);
            weightTextField.setVisible(true);
            nyØvelseKommentar.setVisible(false);
        } else if (øvelse instanceof Friøvelse) {
            setsTextField.setVisible(false);
            repsTextField.setVisible(false);
            weightTextField.setVisible(false);
            nyØvelseKommentar.setVisible(true);

        }

    }

    public void updateØvelseChoiceBox() {
        øvelseChoiceBox.getItems().clear();
        Øvelsesgruppe gruppe = gruppeChoiceBox.getValue();
        øvelseArrayList.clear();
        øvelseArrayList.addAll(gruppe.getØvelser());

        for(Øvelse øvelse: øvelseArrayList){
            øvelseChoiceBox.getItems().add(øvelse.toString());
        }


    }

    public Øvelse findØvelseFromString(){
        String ovString = øvelseChoiceBox.getValue();
        for(Øvelse øvelse: øvelseArrayList){
            if (øvelse.toString().equals(ovString)){
                return øvelse;
            }
        }
        return null;
    }

        public void addØvelse(){
            Øvelse øvelse = findØvelseFromString();
            if(øvelse instanceof Apparatøvelse){
                addApparatØvelse((Apparatøvelse) øvelse);
            }
            else if (øvelse instanceof Friøvelse){
                addFriØvelse((Friøvelse) øvelse);
            }
        }
        public void addApparatØvelse(Apparatøvelse øvelse){
            int kilo = Integer.parseInt(weightTextField.getText());
            int reps = Integer.parseInt(repsTextField.getText());
            int sets = Integer.parseInt(setsTextField.getText());

            resetØvelseInputFields();

            økt.addApparatøvelse(øvelse,kilo,reps,sets);

        }

    public void addFriØvelse(Friøvelse øvelse) {
        String desc = nyØvelseKommentar.getText();

        økt.addFriøvelse(øvelse, desc);
    }
    public void handleNyØvelse(){
        resetØvelseInputFields();
        addØvelse();
        updateØvelseListView();
    }
}
