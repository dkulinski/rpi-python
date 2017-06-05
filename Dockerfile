FROM dkulinski75/rpi-alpine-base

LABEL maintainer "daniel@kulinski.net"

ADD alpine.patch /

RUN apk update && \
apk upgrade && \
apk add python && \
apk add py-pip && \
apk add gcc musl-dev linux-headers && \
apk add git perl sudo make swig python-dev

RUN ln -s /usr/bin/swig /usr/bin/swig2.0

RUN git clone --recursive https://github.com/WiringPi/WiringPi-Python.git /WiringPi-Python

RUN cd /WiringPi-Python/WiringPi && git checkout master

RUN cd /WiringPi-Python && patch -p1 << /alpine.patch

RUN cd /WiringPi-Python && swig -python wiringpi.i && \
python setup.py install

RUN apk del gcc musl-dev linux-headers git perl sudo make swig python-dev

RUN rm -rf /var/cache/apk/*

RUN rm -rf /WiringPi-Python /alpine.patch

CMD ["/bin/bash"]
