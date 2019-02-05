
FROM debian:stretch-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /usr/share/man/man1 && \
    useradd -d /home/AMP -m AMP -s /bin/bash && \
    chown AMP:AMP -R /home && \
    apt-get -qq update && \
    apt-get -qq --no-install-recommends install \
    	coreutils \
	tmux \
	socat \
	unzip \
	git \
	wget \
	libsqlite3-0 \
	ca-certificates \
	lib32gcc1 \
	lib32stdc++6 \
      	software-properties-common \
      	dirmngr \
      	apt-transport-https \
      	openjdk-8-jre-headless \
      	gnupg2 \
      	dos2unix && \
    apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key && \
    apt-add-repository "deb http://repo.cubecoders.com/ debian/" && \
    apt-get update && \
    apt-get -qq install ampinstmgr --no-install-recommends && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/*


COPY start.sh /home/start.sh && \
     chown.sh /home/chown.sh
RUN  chmod +x /home/start.sh && \
     chmod +x /home/chown.sh


RUN apt-get -qq install dos2unix && \
    dos2unix /home/start.sh && \
    dos2unix /home/chown.sh && \
    apt-get -qq remove --purge dos2unix gnupg2 && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/*


RUN su -c "rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* "


VOLUME ["/home"]

EXPOSE 8080

ENTRYPOINT ["/home/start.sh"]
