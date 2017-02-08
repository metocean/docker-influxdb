FROM influxdb:1.1.1
MAINTAINER Rafael Soutelino <r.soutelino@metocean.co.nz>

RUN apt-get update && apt-get install unzip

# Install consul
RUN echo "-----------------Install Consul-----------------" &&\
	cd /tmp &&\
	mkdir /consul &&\
	wget https://releases.hashicorp.com/consul/0.5.2/consul_0.5.2_linux_amd64.zip &&\
	wget https://releases.hashicorp.com/consul/0.5.2/consul_0.5.2_web_ui.zip &&\
	unzip consul_0.5.2_linux_amd64.zip &&\
	unzip consul_0.5.2_web_ui.zip &&\
	mv consul /usr/bin &&\
	mkdir -p /var/www/consul &&\
	mv dist/* /var/www/consul/ &&\
	rm -r dist consul_0.5.2_linux_amd64.zip consul_0.5.2_web_ui.zip


# Install consul
RUN echo "-----------------Install Chronograf-----------------" &&\
	cd /tmp &&\
	wget https://dl.influxdata.com/chronograf/nightlies/chronograf_nightly_amd64.deb &&\
	dpkg -i chronograf_nightly_amd64.deb

COPY config.toml /opt/chronograf/config.toml

COPY entrypoint.sh /.entrypoint.sh
RUN chmod +x /.entrypoint.sh
ENTRYPOINT ["/.entrypoint.sh"]
CMD ["influxd"]
