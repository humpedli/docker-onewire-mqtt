# OneWire MQTT with Docker 

Publish onewire temperature sensor values with MQTT

Original author is [dcbo](https://github.com/dcbo) and his repository is here: https://github.com/dcbo/onewire-to-mqtt
**This is only a rewrite for docker container with changed dependencies (which can be installed with pip)**

This script is intended to run as a service, it connects to [owserver](http://owfs.org/index.php?page=owserver) (from [owfs](http://owfs.org) and reads the temperature values from **DS18x20** onewire sensors.
The temperatures which have been aquired using owserver will be published using a mqtt-broker.

A running [owserver](http://owfs.org/index.php?page=owserver) and a mqtt-broker (e.g: [mosquitto](https://mosquitto.org)) are required to use this deamon.

**This container is designed for Raspberry Pi 3 (armv7hf)**


## Run with docker

Don't forget to create configuration file first (there is a sample in the repository), then attach the file as a volume like examples below.

```
docker run --name=onewire-mqtt \
  --restart=always \
  --network=host \
  -v <path_to_config>/config.cfg:/usr/src/app/config.cfg \
  -v /etc/localtime:/etc/localtime:ro \
  -d humpedli/docker-onewire-mqtt
```


## Run with docker-compose

```
version: '3'
services:
  onewire-mqtt:
    container_name: "onewire-mqtt"
    image: "humpedli/docker-onewire-mqtt"
    volumes:
      - "<path_to_config>/config.cfg:/usr/src/app/config.cfg"
      - "/etc/localtime:/etc/localtime:ro"
    network_mode: host
    restart: "always"
```


## Configuration file

a self explaining sample configuration file is included 

```
# sample configuration 
 
# MQTT broker  related config
[mqtt]
host = 127.0.0.1
port = 1883

# polling interval for sensors
pollinterval = 30

# topic for status messages
statustopic = onewire-to-mqtt/status

# Onewire related config 
[onewire]
host= localhost
port = 4304      

[log]
#verbose = false
verbose = true
logfile = /var/log/onewire-to-mqtt.log

# list of sensors to be polled and according mqtt topics 
[sensors]
28.100000000000 = home/floor1/room1
10.200000000000 = home/floor1/room2             
28.300000000000 = home/floor1/room3
10.400000000000 = home/floor2/room1
28.500000000000 = home/floor2/room2
28.600000000000 = home/floor2/room3
28.700000000000 = home/floor3/room1 
10.800000000000 = home/floor3/room2 
10.900000000000 = home/floor3/room3 
10.010000000000 = home/floor3/room4 
28.020000000000 = home/floor3/room5 
28.030000000000 = home/floor3/room6 
10.040000000000 = home/floor3/room7  
10.050000000000 = home/floor3/room8 
10.060000000000 = home/floor3/room9
```