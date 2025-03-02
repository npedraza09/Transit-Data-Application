CREATE DATABASE IF NOT EXISTS MBTAdb;

USE MBTAdb;

DROP TABLE IF EXISTS mbta_buses;

CREATE TABLE mbta_buses (
    record_num int AUTO_INCREMENT PRIMARY KEY,
    route_number int default 1,
    id varchar(255) not null,
    latitude decimal(11,8) not null,
    longitude decimal(11,8) not null,
    bearing int not null,
    current_status varchar(255) default null,
    current_stop_sequence int null,
    direction_id int not null,
    occupancy_status varchar(255) default null,
    updated_at datetime not null
);

