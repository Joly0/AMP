FROM bitnami/minideb:stretch

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8

RUN useradd -d /home/AMP -m AMP -s /bin/bash
RUN chown AMP:AMP -R /home

RUN touch /etc/inittab
RUN mkdir -p /usr/share/man/man1
RUN apt-get -qq --no-install-recommends update && apt-get -qq --no-install-recommends install coreutils tmux socat unzip git wget libsqlite3-0 ca-certificates lib32gcc1 lib32stdc++6 software-properties-common dirmngr apt-transport-https openjdk-8-jre-headless python3.5 gnupg2 dos2unix && rm -rf /var/lib/apt/lists/*
RUN apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key
RUN apt-add-repository "deb http://repo.cubecoders.com/ debian/"
RUN apt-get -qq --no-install-recommends update && apt-get -qq --no-install-recommends install ampinstmgr && rm -rf /var/lib/apt/lists/*



COPY my_init /sbin/my_init

RUN mkdir /etc/service
RUN mkdir /etc/service/AMP
COPY start.sh /etc/service/AMP/run
RUN chmod +x /etc/service/AMP/run

COPY chown.sh /home/chown.sh
RUN chmod +x /home/chown.sh
COPY update.sh /home/update.sh
RUN chmod +x /home/update.sh


RUN dos2unix /home/start.sh && dos2unix /home/chown.sh && dos2unix /home/update.sh
RUN apt-get -qq remove dos2unix gnupg2
RUN apt-get -qq autoremove
RUN apt-get -qq autoclean



RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*



VOLUME /home /etc/service/AMP

EXPOSE 8080

CMD ["/sbin/my_init"]
