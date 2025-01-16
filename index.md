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
    - [3.1 Web App and API](#App)
    - [3.2 DebeziumCDC](#DebeziumCDC)
    - [3.3 MongoDB Server](#MongoDB)
    - [3.4 JavaMaven Server](#JavaMaven)
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

<a class="anchor" id="App"></a>
### 3.1 Web App and API









[Back to top](#Index)

<a class="anchor" id="Conclusion"></a>
## 5. Conclusion
