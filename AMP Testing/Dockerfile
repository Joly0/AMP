FROM bitnami/minideb:stretch

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8

RUN useradd -d /home/AMP -m AMP -s /bin/bash
RUN usermod --password test AMP
RUN chown AMP:AMP -R /home


RUN mkdir -p /usr/share/man/man1
RUN apt-get -qq --no-install-recommends update && apt-get -qq --no-install-recommends install software-properties-common dirmngr apt-transport-https openjdk-8-jre-headless gnupg2 dos2unix && rm -rf /var/lib/apt/lists/*
RUN apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key
RUN apt-add-repository "deb http://repo.cubecoders.com/ debian/"
RUN apt-get -qq --no-install-recommends update && apt-get -qq --no-install-recommends install ampinstmgr && rm -rf /var/lib/apt/lists/*



COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh


COPY chown.sh /home/chown.sh
RUN chmod +x /home/chown.sh


RUN dos2unix /home/start.sh && dos2unix /home/chown.sh
RUN apt-get -qq --purge remove dos2unix gnupg2
RUN apt-get -qq --purge autoremove 



RUN apt-get -qq clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


VOLUME ["/home"]

EXPOSE 8080

ENTRYPOINT ["/home/start.sh"]
