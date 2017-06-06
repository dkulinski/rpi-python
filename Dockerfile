FROM dkulinski75/rpi-python:2

LABEL maintainer "daniel@kulinski.net"

ADD alpine.patch /

RUN apk update && \
apk upgrade && \
apk add py-pip && \
apk add gcc musl-dev linux-headers && \
apk add git perl sudo make swig python-dev && \
git clone --recursive https://github.com/WiringPi/WiringPi-Python.git /WiringPi-Python && \
cd /WiringPi-Python/WiringPi && git checkout master && \
cd /WiringPi-Python && patch -p1 << /alpine.patch && \
cd /WiringPi-Python && swig -python wiringpi.i && \
python setup.py install && \
apk del gcc musl-dev linux-headers git perl sudo make swig python-dev && \
rm -rf /var/cache/apk/* && rm -rf /WiringPi-Python /alpine.patch

CMD ["/bin/bash"]
