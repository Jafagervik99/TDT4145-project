# Training Diary

JDBC project for __TDT4145__ Data Modelling, Databases and Database Management Systems

By Ask Sommervoll, Claus Martinsen, Henrik Fauskanger and Nora Bodin

## About

For this small project we implemented a [Active Domain Object][ado] pattern for database 
access, providing a simple programmatic interface for retrieving and operating on 
the data.

## How to run

1) Run the __updated__ [SQL script][sql_script] for creating the required database structure on your 
preffered MySQL server.

2) Run the [main method][main] to launch the application.

3) Click the `Instillinger` button to access database settings. Change the URL, username 
and password to match your setup.

## Classes

### Persistence

Our Active Domain Object classes represent the entities we care about in the database 
and provides the necessary methods for interacting with them.

The most important method of all _ADOs_ is `.save()`, which saves the objects state to the database.

For in-depth information about how the classes work, see the respective `JavaDoc`.

![Persistence diagram][persistence diagram]

### UI

We use JavaFX for our GUI and have one Controller for each screen in the application. The controllers 
use our Active Domain Objects to interact with the database, decoupling UI from database logic.

[Page][page] is an Enum for all FXML pages. 

[TrainingApp][app] is the Application which launches the JavaFX GUI.

![UI diagram][ui diagram]

[ado]: http://www.diranieh.com/DataAccessPatterns/ActiveDomainObject.htm
[persistence diagram]: docs/persistence_classes.png "Persistence diagram"
[ui diagram]: docs/ui_classes.png "UI diagram"
[sql_script]: docs/treningsDb_v2.sql
[main]: src/main/java/databaser/Main.java
[page]: src/main/java/databaser/ui/Page.java
[app]: src/main/java/databaser/ui/TrainingApp.java
