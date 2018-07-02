FROM resin/armv7hf-debian

WORKDIR /usr/src/app

COPY . .

RUN [ "cross-build-start" ]

RUN apt-get update  
RUN apt-get install python
RUN pip install --no-cache-dir -r requirements.txt

RUN [ "cross-build-end" ]

CMD [ "python", "./script.py config.cfg" ]