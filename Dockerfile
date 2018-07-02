FROM resin/armv7hf-debian

WORKDIR /usr/src/app

COPY . .

RUN [ "cross-build-start" ]

RUN apt-get update  
RUN apt-get install python python-pip python-dev build-essential
RUN pip install -r requirements.txt

RUN [ "cross-build-end" ]

CMD [ "bash", "python ./script.py config.cfg" ]