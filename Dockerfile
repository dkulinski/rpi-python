FROM dkulinski75/rpi-alpine-base:06-17

LABEL maintainer "daniel@kulinski.net"

RUN apk update && \
apk upgrade && \
apk add python3 && \
rm -rf /var/cache/apk/*

CMD ["/bin/bash"]

