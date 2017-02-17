FROM ubuntu:xenial

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

# Stay up-to-date
RUN apt-get update && \
	apt-get install -y \
	octave \
	inkscape \
	pdftk \
	git && \
	apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

LABEL software.version="0.1.18"
LABEL version="0.2"
LABEL software="metabomatching-pre"
ENV TOOL_VERSION=0.1.18
ENV CONTAINER_VERSION=0.2.1.6

# Install metabomatching
RUN git clone -b release/${TOOL_VERSION} https://github.com/rrueedi/metabomatching-pre.git /mm-tp/
RUN cp -r /mm-tp/fos /usr/share/fonts/truetype/
RUN fc-cache -f -v

ENV PATH=$PATH:/mm-tp

# Uncomment the entrypoint in order to use the tool with Galaxy
ENTRYPOINT ["metabomatching.sh"]
