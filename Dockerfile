FROM debian:10-slim

EXPOSE 8080

ENV UID=1000
ENV GID=100

ENV USERNAME=admin
ENV PASSWORD=changeme123

COPY ./program.sh ./program.sh

RUN export LANG=en_US.UTF-8 && \
	export LANGUAGE=en_US:en && \
	export LC_ALL=en_US.UTF-8 && \
	export DEBIAN FRONTEND=noninteractive && \
	export ANSWER_SYSPASSWORD=$(cat /proc/sys/kernel/random/uuid) && \
	export USE_ANSWERS=1 && \
	export SKIP_INSTALL=1 && \
	export ANSWER_INSTALLJAVA=1 && \
	mkdir /usr/share/man/man1 && \
	apt-get update && \
	apt-get install -y --no-install-suggests wget locales procps apt-utils && \
	locale-gen en_US.UTF-8 && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8 && \
	bash <(wget -qO- getamp.sh) && \
	chmod +x ./program.sh && \
	apt-get -y clean && \
	apt-get -y autoremove --purge && \
	su -c "rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* "
	
VOLUME ["/home/amp"]

ENTRYPOINT ["/sbin/init"]

CMD [(su -l amp -c "ampinstmgr quick '${USERNAME}' '${PASSWORD}'") || "./program.sh"]
	

