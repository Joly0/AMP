FROM debian:10-slim
LABEL maintainer="Joly0"

EXPOSE 8080

ENV UID=1000
ENV GID=100
ENV USERNAME=admin
ENV PASSWORD=changeme123
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY start.sh /opt/start.sh

RUN mkdir /usr/share/man/man1 && \
	mkdir -p /opt/cubecoders/amp && \
	chmod +x /opt/start.sh && \
	apt-get update && \
	apt-get install -y --no-install-recommends --no-install-suggests \
		apt-utils \
		tmux \
		socat \
		unzip \
		git \
		wget \
		locales \
		lib32gcc1 \
		libcurl4 \
		lib32stdc++6 \
		lib32tinfo6 \
		coreutils \
		procps \
		software-properties-common \
		dirmngr \
		apt-transport-https \
		ca-certificates \
		dnsutils \
		tini \
		gnupg2 && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8 && \
	useradd -d /home/amp -m amp -s /bin/bash && \
	apt-key adv --fetch-keys https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public && \
	add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
	apt-get update && \
	apt-get install -y --no-install-recommends --no-install-suggests adoptopenjdk-8-openj9 && \
	wget -P /opt/cubecoders/amp http://cubecoders.com/Downloads/ampinstmgr.zip && \
	unzip /opt/cubecoders/amp/ampinstmgr.zip -d /opt/cubecoders/amp && \
	rm -rf /opt/cubecoders/amp/ampinstmgr.zip && \
	ln -s /opt/cubecoders/amp/ampinstmgr /usr/local/bin/ampinstmgr && \
	apt-get -y clean && \
	apt-get -y autoremove --purge && \
	rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

VOLUME ["/home/amp"]

ENTRYPOINT [ "/usr/bin/tini", "--", "/opt/start.sh" ]