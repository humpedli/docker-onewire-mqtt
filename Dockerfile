FROM ubuntu:18.04

# install required modules
RUN apt-get install -y python-ow
RUN apt-get install -y python-mosquitto 
RUN apt-get install -y python-setproctitle

# copy all files into workdir
WORKDIR /usr/src/app
COPY . .

# cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

CMD [ "python", "./onewire-to-mqtt.py config.cfg", "tail -f /var/log/onewire-to-mqtt.log" ]