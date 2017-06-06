FROM dkulinski75/rpi-python:3

LABEL maintainer "daniel@kulinski.net"

ADD alpine.patch /

RUN apk update && \
apk upgrade && \
apk add py-pip gcc musl-dev linux-headers \ 
git perl sudo make swig python3-dev && \
git clone --recursive https://github.com/WiringPi/WiringPi-Python.git /WiringPi-Python && \
cd /WiringPi-Python/WiringPi && git checkout master && \
patch -p1 << /alpine.patch && \
cd /WiringPi-Python && swig -python wiringpi.i && \
cd /WiringPi-Python && sed -i "20i\ \ \ \ zip_safe=False," setup.py  && \
cd /WiringPi-Python && python3 setup.py install && \
apk del gcc musl-dev linux-headers \ 
git perl sudo make swig python-dev && \
rm -rf /var/cache/apk/* && rm -rf /WiringPi-Python /alpine.patch

CMD ["/bin/bash"]
