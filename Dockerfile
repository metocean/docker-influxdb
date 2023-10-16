FROM influxdb:2.7
MAINTAINER Rafael Soutelino <r.soutelino@metocean.co.nz>

RUN apt-get update && apt-get install -y unzip wget

# Install consul
ENV CONSUL_VERSION=1.12.0

RUN echo "-----------------Install Consul-----------------" &&\
    cd /tmp &&\
    mkdir -p /consul &&\
    wget -q https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip &&\
    unzip consul_${CONSUL_VERSION}_linux_amd64.zip &&\
    mv consul /usr/bin &&\
    rm -r consul_${CONSUL_VERSION}_linux_amd64.zip

# Install consul
RUN echo "-----------------Install Chronograf-----------------" &&\
	cd /tmp &&\
	wget https://dl.influxdata.com/chronograf/nightlies/chronograf_nightly_amd64.deb &&\
	dpkg -i chronograf_nightly_amd64.deb


COPY entrypoint.sh /.entrypoint.sh
RUN chmod +x /.entrypoint.sh
ENTRYPOINT ["/.entrypoint.sh"]
CMD ["influxd"]
