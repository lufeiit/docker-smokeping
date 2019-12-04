FROM linuxserver/docker-smokeping
RUN \
 echo @edge http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
 apk add --no-cache \
	wqy-zenhei --update-cache --repository http://nl.alpinelinux.org/alpine/edge/testing --allow-untrusted 

# add local files
COPY ./entrypoint.sh /entrypoint.sh
COPY ./start.sh /start.sh

ENTRYPOINT [ "/bin/sh","/entrypoint.sh" ]
CMD ["/bin/sh","/start.sh"]
