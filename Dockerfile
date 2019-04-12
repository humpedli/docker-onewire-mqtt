FROM balenalib/armv7hf-debian

# copy files
COPY . /app

# set workdir
WORKDIR /app

RUN [ "cross-build-start" ]

# install dependencies
RUN apt-get update  
RUN apt-get install python python-pip python-dev build-essential
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

# cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN [ "cross-build-end" ]

# entry point
CMD python script.py /usr/src/app/config.cfg
