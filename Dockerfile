FROM resin/armv7hf-debian


RUN [ "cross-build-start" ]

# update apt
RUN apt-get update

# install git and clone repository
RUN apt-get install -y git
RUN mkdir /app
RUN git clone https://github.com/dcbo/onewire-to-mqtt.git /app
WORKDIR /app

# install required modules
RUN apt-get install -y python
RUN apt-get install -y python-ow
RUN apt-get install -y python-mosquitto 
RUN apt-get install -y python-setproctitle

# cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN [ "cross-build-end" ]

CMD [ "python", "./onewire-to-mqtt.py config.cfg", "tail -f /var/log/onewire-to-mqtt.log" ]