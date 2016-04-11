FROM metocean/aroha:v1.0.0
MAINTAINER Thomas Coats <thomas@metocean.co.nz>

ENV INFLUXDB_VERSION=0.12.1

ADD . /install/
RUN /install/install.sh
CMD ["/sbin/initsh"]