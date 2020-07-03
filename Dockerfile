FROM debian:10-slim

EXPOSE 8080

ENV UID=1000
ENV GID=100
ENV USERNAME=admin
ENV PASSWORD=changeme123

<<<<<<< HEAD
=======
COPY ./program.sh ./program.sh
>>>>>>> 96d605719a22c3d199711de870b2608319561045

RUN export LANG=en_US.UTF-8 && \
    export LANGUAGE=en_US:en && \
    export LC_ALL=en_US.UTF-8 && \
	export DEBIAN FRONTEND=noninteractive && \
	mkdir /usr/share/man/man1 && \
	mkdir -p /opt/cubecoders/amp
	
<<<<<<< HEAD
	
=======
>>>>>>> 96d605719a22c3d199711de870b2608319561045
RUN	apt-key adv --fetch-keys https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public && \
	add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
	sudo \
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
	adoptopenjdk-8-openj9 && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8 && \
	useradd -d /home/amp -m amp -s /bin/bash && \
	
	
WORKDIR /opt/cubecoders/amp
RUN wget http://cubecoders.com/Downloads/ampinstmgr.zip && \
	unzip ampinstmgr.zip && \
	rm -rf ampinstmgr.zip && \
	ln -s /opt/cubecoders/amp/ampinstmgr /usr/local/bin/ampinstmgr
WORKDIR /

<<<<<<< HEAD

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh


=======
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

>>>>>>> 96d605719a22c3d199711de870b2608319561045
RUN	apt-get -y clean && \
	apt-get -y autoremove --purge && \
	su -c "rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* "


VOLUME ["/home/amp"]

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD [su -l amp -c "ampinstmgr quick '${USERNAME}' '${PASSWORD}'"]
