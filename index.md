<a href="https://npedraza09.github.io">Back to My Portfolio</a>

<a class="anchor" id="Index"></a>
# Index

- [Abstract](#Abstract)
- [1. Introduction](#Introduction)
- [2. Structure](#Structure)
    - [2.1 Servers](#Servers)
    - [2.2 Repositories](#Repositories)
    - [2.3 Files](#Files)
- [3. Code](#Code)
    - [3.1 Flask Project](#Flask)
    - [3.2 DebeziumCDC](#Debezium)
    - [3.3 Java-Quick-Start](#Java)
- [4. Analysis](#Analysis)
- [5. Conclusion](#Conclusion)


<a class="anchor" id="Abstract"></a>
##  Abstract





[Back to top](#Index)

<a class="anchor" id="Introduction"></a>
## 1. Introduction




[Back to top](#Index)

<a class="anchor" id="Structure"></a>
## 2. Structure

<a class="anchor" id="Servers"></a>
### 2.1 Servers

* MBTA Server
This server is crucial as it contains all real-time information on the buses. The MBTA API gets its information from this server, and I make calls to the MBTA API.
  
* MySQL Server
The MySQL server collects data from the MBTA API and stores it in a MySQL database.

* Web Server
This server initiates the web application in a port and sets the routes on the page.

* Debezium Server
This server collects data from the MySQL database using Debezium and stores it in a MongoDB collection.
  
* MongoDB Server
Stores data given by the Debezium server in a collection.
  
* JavaMaven Server
Finally, the JavaMaven server allows me to perform CRUD operations on my MongoDB collection.

[Back to top](#Index)

<a class="anchor" id="Repositories"></a>
### 2.2 Repositories

* Flask Project Repository:
This repository holds the code to create the web application interface, the timer to collect data every amount of time that we specify, the connection to the MBTA API, and the creation and storage of the MySQL database.

* DebeziumCDC Repository:
This repository holds the connections and configurations necessary for Debezium to connect to the MySQL database, collect the data in real-time, and then connect and store it in a MongoDB database.

* Java-Quick-Start Repository:
The Java-Quick-Start Repository sets a Java project with Maven and executes a MongoDB command to query the data stored in the MongoDB collection.

[Back to top](#Index)

<a class="anchor" id="Files"></a>
### 2.3 Files

* Flask Project Repository:
    * Templates Folder:
        * index.html (parent template for main interface of the web app)
    * server.py (file that works as a server to start the web app in a localhost port)
    * timer.py (works as a timer to collect a sample every amount of time that I decide, in this case every 10 seconds)
    * mysqldb.py (creates table sets fields in the MySQL database)
    * client.py (gets real-time location of buses from the localhost port in my machine)
    * MBTAApiClient.py (inserts data from MBTA API in the MySQL database)
 
* DebeziumCDC Repository:
    * mvnw (Maven Start Up Batch script)
    * pom.xml (project object model file, contains information about the project and configuration details used by Maven to build the project)
    * mvnw.cmd (allows you to run the Maven project without having Maven installed and present on the path)
    * Dockerfile (creates container image for Debezium)
    * LICENSE (MIT License, Copyright (c) 2021 kogsio)
    * Configuration Folder:
        * DebeziumConnectorConfig.java (customer database connector configuration)
    * Listener Folder:
        * DebeziumListener.java (inserts records in MongoDB)
        * MongoDB.java (MongoDB connection configuration)

* Java-Quick-Start Repository:
    * pom.xml (project object model file)
    * LICENSE (Apache License, Version 2.0, January 2004)
    * java/com/mongodb/quickstart repository:
        * ReadCDC.java (reads data from the MongoDB collection and specifies an output format. If more operations want to be performed, I would create other files that do so. For now, I just read the data to prove connectivity)


[Back to top](#Index)

<a class="anchor" id="Code"></a>
## 3. Code

<a class="anchor" id="Flask"></a>
### 3.1 Flask Project

---
#### * index.html:

##### DOCTYPE Declaration
```html
<!DOCTYPE html>
```

##### HTML tag
```html
<html>
```

##### Head Section
```html
<head>
<meta charset="utf-8" />
<title>Real-Time Bus Tracker</title>
<script src="https://api.mapbox.com/mapbox-gl-js/v1.11.0/mapbox-gl.js"></script>
<link href="https://api.mapbox.com/mapbox-gl-js/v1.11.0/mapbox-gl.css" rel="stylesheet" />
<style>
  body { margin: 0; padding: 0; }
  #map { position: absolute; top: 0; bottom: 0; width: 100%; }
</style>
</head>
```

##### Body Section
```html
<body>
  
<div id="map"></div>
 
<script>
```

###### Map Initialization
```html
mapboxgl.accessToken = 'XXXX';

let map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [-71.091542, 42.358862],
    zoom: 12
});
```

###### Dynamic Marker Management
```html
let markers = {};

// Initialize map and start updating markers
async function init() {
    await updateMarkers();
    setInterval(updateMarkers, 15000); // Update every 15 seconds
}

// Fetch bus data and update markers
async function updateMarkers() {
    try {
        const busLocations = await getBusLocations();

        // Update or add markers based on new data
        busLocations.forEach(bus => {
            if (markers[bus.id]) {
                moveMarker(markers[bus.id], bus);
            } else {
                addMarker(bus);
            }
        });

        // Remove markers for buses no longer in the data
        const busIds = busLocations.map(bus => bus.id);
        for (let id in markers) {
            if (!busIds.includes(id)) {
                markers[id].remove();
                delete markers[id];
            }
        }

        console.log(`Updated at ${new Date()}`);
    } catch (error) {
        console.error("Error fetching bus locations:", error);
    }
}
```

###### Server Communication 
```html
// Fetch bus locations from server
async function getBusLocations() {
    const url = '/location'; 
    const response = await fetch(url);

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
}
```

###### Marker Creation and Updates
```html
// Add a new marker for a bus
function addMarker(bus) {
    const color = getColor(bus);
    const marker = new mapboxgl.Marker({ color })
        .setLngLat([bus.longitude, bus.latitude])
        .addTo(map);

    markers[bus.id] = marker; // Store marker by bus ID
}

// Update an existing marker's position and color
function moveMarker(marker, bus) {
    const newColor = getColor(bus);

    if (marker._color !== newColor) {
        const markerElement = marker.getElement();
        markerElement.querySelector('svg').setAttribute("fill", newColor);
        marker._color = newColor;
    }

    marker.setLngLat([bus.longitude, bus.latitude]);
}
```

###### Marker Color Logic
```html
function getColor(bus) {
    return bus.direction > 0 ? 'black' : 'red';
}
```

###### Script Initialization
```html
window.onload = init;

</script>
</body>
</html>

```

This script renders a real-time map of bus locations using Mapbox GL JS. It dynamically fetches bus data from a server, updates bus markers, and removes markers for buses no longer in service. The CSS and Mapbox integration ensure the map looks polished and functional, with color-coded markers indicating bus directions.


[Back to top](#Index)

---
#### * server.py:

##### Import Statements
```python
from threading import Timer
from flask import Flask, render_template
import time
import json
import MBTAApiClient
```

##### Initialization of Bus Data
```python
# Initialize buses list by doing an API call to the MBTA database below
buses = MBTAApiClient.callMBTAApi()
```

##### Update and Helper Functions
```python
def update_data():
    buses = MBTAApiClient.callMBTAApi()

def status():
    for bus in buses:
        print(bus)

def timeloop():
    print(f'--- ' + time.ctime() + ' ---')
    # status()
    update_data()
    Timer(10, timeloop).start()
timeloop()
```

##### Web Server Initialization
```python
# create application instance
app = Flask(__name__)

# root route - landing page
@app.route('/')
def root():
    return render_template('index.html')

# root route - landing page
@app.route('/location')
def location():
    return (json.dumps(buses))
```

##### Starting the Server
```python
# start server - note the port is 3000
if __name__ == '__main__':
    app.run(port=3000)
```

This script is responsible for continuously updating bus location data and serving it to a front-end map application for real-time visualization.


[Back to top](#Index)

---
#### * timer.py:

##### Import Statements
```python
from threading import Timer
import time
```

##### Timer Setup
```python
# sample 10 second timer
def timeloop():
    print(f'--- ' + time.ctime() + ' ---')
    Timer(10, timeloop).start()
timeloop()
```

---
#### * mysqldb.py

##### Importing Required Modules
```python
import mysql.connector
```

##### Function Definition
```python
def insertMBTARecord(mbtaList):
    mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="PASSWORD",
    database="MBTAdb"
    )

    mycursor = mydb.cursor()
```

###### SQL query for Inserting Data
```python
    sql = """
    insert into mbta_buses (route_number, id, latitude, longitude, bearing, current_status,
                            current_stop_sequence, direction_id, occupancy_status, updated_at) 
                            values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
```

###### Iterating Through the Data
```python
    for mbtaDict in mbtaList:
        val = (mbtaDict['route_number'], mbtaDict['id'], mbtaDict['latitude'], mbtaDict['longitude'], mbtaDict['bearing'], 
               mbtaDict['current_status'], mbtaDict['current_stop_sequence'], mbtaDict['direction_id'], mbtaDict['occupancy_status'], mbtaDict['updated_at'])
        mycursor.execute(sql, val)

    mydb.commit()
```
This script connects to a MySQL database and inserts records into the mbta_buses table. The key components include: Database Connection, Insert Query, Data Insertion Loop, and Commit.

[Back to top](#Index)

---
#### * client.py:

##### Import Statements
```python
from threading import Timer
import urllib.request
import time
import json
```

##### Location Function Definiton
```python
def locations():
    url = "http://localhost:3000/location"
    response = urllib.request.urlopen(url).read()
    data = json.loads(response)
    for bus in data:
        print(bus)
```

##### Timeloop Function Definition
```python
def timeloop():
    print(f'--- ' + time.ctime() + ' ---')
    locations()
    Timer(10, timeloop).start()
timeloop()
```
This script acts as a client application that fetches real-time data, prints bus details, and automates fetching with a timeloop.


---
#### * MBTAApiClient.py:

##### Import Statements
```python
import urllib.request, json
import mysqldb
```

##### Call MBTA Api Function
```python 
def callMBTAApi():
    mbtaDictList = []
    mbtaUrl = 'https://api-v3.mbta.com/vehicles?filter[route]=1&include=trip'
    with urllib.request.urlopen(mbtaUrl) as url:
        data = json.loads(url.read().decode())
        for bus in data['data']:
            busDict = dict()
            # complete the fields below based on the entries of your SQL table
            busDict['route_number'] = 1
            busDict['id'] = bus['id']
            busDict['latitude'] = bus['attributes']['latitude']
            busDict['longitude'] = bus['attributes']['longitude']
            busDict['bearing'] = bus['attributes']['bearing']
            busDict['current_status'] = bus['attributes']['current_status']
            busDict['current_stop_sequence'] = bus['attributes']['current_stop_sequence']
            busDict['direction_id'] = bus['attributes']['direction_id']
            busDict['occupancy_status'] = bus['attributes']['occupancy_status']
            busDict['updated_at'] = bus['attributes']['updated_at']
            mbtaDictList.append(busDict)
    mysqldb.insertMBTARecord(mbtaDictList) 

    return mbtaDictList  
```
This script defines a function, callMBTAApi, to:
* Fetch Bus Data: Sends a GET request to the MBTA API for bus locations on route 1.
* Process Data: Converts the API response into a structured list of dictionaries, each representing a bus.
* Store in Database: Saves the processed bus data into a MySQL database using the mysqldb.insertMBTARecord function.
* Return Processed Data: Outputs the list of dictionaries for potential further use.


[Back to top](#Index)


<a class="anchor" id="Debezium"></a>
### 3.2 DebeziumCDC 

---
#### * DebeziumConnectorConfig.java:

##### Package Declaration
```java
package mit.edu.tv.config;
```

##### Import Statements
```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.io.IOException;
```

##### Package Declaration
```java
@Configuration
public class DebeziumConnectorConfig {
```

##### Method Declaration
```java
    /**
     * Customer Database Connector Configuration
     */
    @Bean
    public io.debezium.config.Configuration customerConnector() throws IOException {

        System.out.println("------------------------------------------------------");
        String absolutePath = System.getProperty("user.dir");
        File f = new File(absolutePath);
        String parent = f.getParent();
        String offsetFile = parent + "/student-offset.dat";
        String historyFile = parent + "/student-history.dat";
        System.out.println(offsetFile);
        System.out.println(historyFile);        
        System.out.println("------------------------------------------------------");         


        return io.debezium.config.Configuration.create()
            .with("name", "customer-mysql-connector")
            .with("connector.class", "io.debezium.connector.mysql.MySqlConnector")
            .with("offset.storage", "org.apache.kafka.connect.storage.FileOffsetBackingStore")
            .with("offset.storage.file.filename", offsetFile)
            .with("offset.flush.interval.ms", "60000")
            .with("database.hostname", "mysqlserver")
            .with("database.port", 3306)
            .with("database.user", "root")
            .with("database.password", "PASSWORD")
            .with("database.dbname", "MBTAdb")
            .with("database.include.list", "MBTAdb")
            .with("include.schema.changes", "false")
            .with("database.allowPublicKeyRetrieval", "true")
            .with("database.server.id", "10181")
            .with("database.server.name", "localhost_MBTAdb")
            .with("database.history", "io.debezium.relational.history.FileDatabaseHistory")
            .with("database.history.file.filename", historyFile)
            .build();
    }
}
```
This script configures a Debezium MySQL connector for change data capture (CDC). The major sections include:
* Package and Imports: Sets up the necessary libraries and organizes the configuration into the config package.
* Class Declaration: Defines the DebeziumConnectorConfig class as a Spring configuration class.
* Logging and File Path Setup: Constructs file paths for offset and history files, ensuring the connector can track its state.
* Debezium Connector Configuration: Specifies key settings for the connector, such as database connection details, storage options, and monitoring preferences.
* Spring Bean Creation: Returns the connector configuration as a Spring bean, allowing it to be injected and managed by the Spring framework.

[Back to top](#Index)

---
#### * DebeziumListener.java:

##### Package Declaration
```java
package mit.edu.tv.listener;
```

##### Import Statements
```java
import io.debezium.config.Configuration;
import io.debezium.embedded.Connect;
import io.debezium.engine.DebeziumEngine;
import io.debezium.engine.RecordChangeEvent;
import io.debezium.engine.format.ChangeEventFormat;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.connect.source.SourceRecord;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.io.IOException;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;
```

##### Class Declarations
```java
@Slf4j
@Component
public class DebeziumListener {
```

##### Field Declarations
```java
    private final Executor executor = Executors.newSingleThreadExecutor();
    private final DebeziumEngine<RecordChangeEvent<SourceRecord>> debeziumEngine;
```

##### Constructor
```java
    public DebeziumListener(Configuration customerConnectorConfiguration) {

        this.debeziumEngine = DebeziumEngine.create(ChangeEventFormat.of(Connect.class))
            .using(customerConnectorConfiguration.asProperties())
            .notifying(this::handleChangeEvent)
            .build();

        // this.customerService = customerService;
    }
```

##### Handle Change Event Method
```java
    private void handleChangeEvent(RecordChangeEvent<SourceRecord> sourceRecordRecordChangeEvent) {
        SourceRecord sourceRecord = sourceRecordRecordChangeEvent.record();


        MongoDB mongoDB = new MongoDB();
        mongoDB.testConnection();
        mongoDB.insertRecord(sourceRecord.value().toString());
        

        System.out.println("Key = '" + sourceRecord.key() + "' value = '" + sourceRecord.value() + "'");
    }
```


##### Lifecycle Management
```java
    @PostConstruct
    private void start() {
        this.executor.execute(debeziumEngine);
    }

    @PreDestroy
    private void stop() throws IOException {
        if (this.debeziumEngine != null) {
            this.debeziumEngine.close();
        }
    }

}

```
The DebeziumListener class is a Spring-managed component that listens for real-time database change events using the Debezium engine. It performs the following key actions:
* Initialization:
    * Sets up the Debezium engine using configuration and registers the event handler (handleChangeEvent).
    * Runs the engine on a separate thread.
* Change Event Handling:
    * Processes each database change event, extracts its data, and stores it in MongoDB.
* Lifecycle Management:
    * Automatically starts the Debezium engine when the application initializes.
    * Cleans up and stops the engine gracefully during application shutdown.
 






[Back to top](#Index)

<a class="anchor" id="Conclusion"></a>
## 5. Conclusion
