FROM dkulinski75/rpi-python:3

LABEL maintainer "daniel@kulinski.net"

ADD alpine.patch /

RUN apk update && \
apk upgrade && \
apk add py-pip gcc musl-dev linux-headers \ 
git perl sudo make swig python3-dev zip && \
git clone --recursive https://github.com/WiringPi/WiringPi-Python.git /WiringPi-Python && \
cd /WiringPi-Python/WiringPi && git checkout master && \
patch -p1 << /alpine.patch && \
cd /WiringPi-Python && swig -python wiringpi.i 

RUN cd /WiringPi-Python && sed -ie '32i\ \ \ \ zip_safe=False' setup.py

RUN python3 setup.py install && \
apk del python3 py-pip3 gcc musl-dev linux-headers \ 
git perl sudo make swig python-dev zip && \
rm -rf /var/cache/apk/* && rm -rf /WiringPi-Python /alpine.patch

CMD ["/bin/bash"]
