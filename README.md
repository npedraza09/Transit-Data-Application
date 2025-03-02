<a href="https://npedraza09.github.io">Back to My Portfolio</a>

# Transit Data Application

This project demonstrates a real-time bus tracking and data analysis system designed to monitor and analyze the performance of bus route 1 of the Massachusetts Bay Transportation Authority (MBTA). Using a web application integrated with a variety of servers and tools, the system collects, stores, and processes real-time bus location data. The architecture incorporates multiple technologies such as Flask, MySQL, Debezium, MongoDB, and Java, orchestrated in a Docker-based network called MBTANetwork. By continuously pulling data from the MBTA API, this project not only visualizes real-time bus movements but also provides insightful analysis such as route completion times, average stop durations, and estimated bus speeds.


## Steps to run this project
1. Either fork or download all folders in this repository and open them in your code editor
2. Install all necesssary dependencies
3. Create a Docker network called "MBTANetwork"
5. In your Terminal, navigate to "mysqlDocker" and using the `docker-run` command create and run the: mysql container, and the Mongo container
6. From your code editor Terminal window, open the "TransitDataApp" folder and run "server.py"
7. From your web browser navigate to localhost:3000 to check out the web app
8. In your Terminal, navigate to "DebeziumCDC" and using the `docker build` command to create and run the Debezium container
9. From the Debezium shell prompt, run the Maven SpringBoot application using the following command: `mvn spring-boot:run`
10. In your Terminal, navigate to "java-quick-start" and using the `docker-run` create and run the javamaven container
11. In the bash command prompt from the javamaven container, make sure you are in the /java-quick-start folder and run:
`mvn compile exec:java -
Dexec.mainClass="com.mongodb.quickstart.ReadCDC" -
Dmongodb.uri="mongodb://some-mongo:27017"`
12. Leave the server.py running for a couple hourse and then do live analysis on the data
13. Check out the "index.md" file in this repository to see the live data I did on the MBTA API route 1 data
    
## Features
- Live data collection of MBTA API
- Web App with visualization of real-time bus location data in a map
- Real-time data capture in MongoDB, and javamaven of route 1 bus data
- Live data analysis of bus route 1
  
  ## Future Features
- More features in Web App
- More user-friendly interface web app
- Predictions on bus data


## Tools:
* Python
* SQL
* Java
* HTML
* JSON
* Databases: MySQL, and MongoDB
* Debezium
* Libraries: Mapbox, flask, numpy, pandas, haversine, urllib, matplotlib, and threading

## What the project looks like

<img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/0a2fd865-0e2f-40a9-8839-7abf03e44b96" />

<img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/09769eb4-93b7-4bc2-94f3-7dfafcf4a5a1" />

<img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/f66c7897-f793-4111-92a1-bf0d9dbbfc53" />







