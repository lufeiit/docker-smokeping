FROM lsiobase/alpine:3.10

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SMOKEPING_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ironicbadger,sparklyballs"

# copy tcpping script
COPY tcpping /defaults/

RUN \
 echo @edge http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
 echo "**** install packages ****" && \
 apk add --no-cache \
	apache2 \
	apache2-ctl \
	apache2-utils \
	bc \
	bind-tools \
	curl \
	openssh-client \
	smokeping \
	ssmtp \
	sudo \
	tcptraceroute \
	wqy-zenhei --update-cache --repository http://nl.alpinelinux.org/alpine/edge/testing --allow-untrusted \
	ttf-dejavu && \
 echo "**** give setuid access to traceroute & tcptraceroute ****" && \
 chmod a+s /usr/bin/traceroute && \
 chmod a+s /usr/bin/tcptraceroute && \
 echo "**** fix path to cropper.js ****" && \
 sed -i 's#src="/cropper/#/src="cropper/#' /etc/smokeping/basepage.html && \
 echo "**** install tcping script ****" && \
 install -m755 -D /defaults/tcpping /usr/bin/ && \
 echo "**** remove default apache conf ****" && \
 rm -f /etc/apache2/httpd.conf

# add local files
COPY root/ /
COPY ./entrypoint.sh /entrypoint.sh

# ports and volumes
EXPOSE 80
VOLUME /config /data

ENTRYPOINT [ "/bin/sh","/entrypoint.sh" ]
