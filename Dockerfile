FROM resin/raspberrypi3-python

RUN [ "cross-build-start" ]

# update apt
RUN apt-get update

# install required modules
RUN apt-get install -y python
RUN apt-get install -y python-ow
RUN apt-get install -y python-mosquitto 
RUN apt-get install -y python-setproctitle

# set working directory
WORKDIR /usr/src/app

# install git and clone repository
RUN apt-get install -y git
RUN git clone https://github.com/dcbo/onewire-to-mqtt.git /usr/src/app

# cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN [ "cross-build-end" ]

CMD [ "python", "onewire-to-mqtt.py config.cfg", "tail -f /var/log/onewire-to-mqtt.log" ]