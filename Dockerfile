FROM debian:10-slim

EXPOSE 8080

ENV UID=1000
ENV GID=100
ENV USERNAME=admin
ENV PASSWORD=changeme123

COPY entrypoint.sh /opt/entrypoint.sh

RUN	export LANG=en_US.UTF-8 && \
	export LANGUAGE=en_US:en && \
	export LC_ALL=en_US.UTF-8 && \
	export DEBIAN FRONTEND=noninteractive && \
	mkdir /usr/share/man/man1 && \
	mkdir -p /opt/cubecoders/amp && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
	apt-utils \
	tmux \
	socat \
	unzip \
	git \
	wget \
	locales \
	lib32gcc1 \
	coreutils \
	iputils-ping \
	procps \
	software-properties-common \
	dirmngr \
	apt-transport-https \
	ca-certificates \
	dnsutils \
	gnupg2 && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8 && \
	useradd -d /home/amp -m amp -s /bin/bash && \
	apt-key adv --fetch-keys https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public && \
	add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
	apt-get update && \
	apt-get install -y --no-install-recommends adoptopenjdk-8-openj9 && \
	wget -P /opt/cubecoders/amp http://cubecoders.com/Downloads/ampinstmgr.zip && \
	unzip /opt/cubecoders/amp/ampinstmgr.zip && \
	rm -rf /opt/cubecoders/amp/ampinstmgr.zip && \
	ln -s /opt/cubecoders/amp/ampinstmgr /usr/local/bin/ampinstmgr && \
	chmod +x /opt/entrypoint.sh && \
	apt-get -y clean && \
	apt-get -y autoremove --purge && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

VOLUME ["/home/amp"]

ENTRYPOINT ["/opt/entrypoint.sh"]
