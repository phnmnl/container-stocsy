FROM ubuntu:xenial

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

# Stay up-to-date
RUN apt-get update && \
	apt-get install -y \
	octave \
	git && \
	apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

LABEL software.version="0.1.0"
LABEL version="0.1.0"
LABEL software="stocsy"
ENV TOOL_VERSION=0.1.0
ENV CONTAINER_VERSION=0.1.0
ENV TRIGGER_JENKINS=1

# Install metabomatching
RUN git clone -b develop https://github.com/rrueedi/stocsy.git /mm-tp/

ENV PATH=$PATH:/mm-tp
WORKDIR /mm-tp

ADD runTest1.sh /usr/local/bin/runTest1.sh

# Uncomment the entrypoint in order to use the tool with Galaxy
ENTRYPOINT ["octave-cli", "/mm-tp/stocsy.m"]
