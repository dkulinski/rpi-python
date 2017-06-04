FROM dkulinski75/rpi-alpine-base

LABEL maintainer "daniel@kulinski.net"

RUN apk update && \
apk upgrade && \
apk add python && \
rm -rf /var/cache/apk/*

CMD ["/bin/bash"]

