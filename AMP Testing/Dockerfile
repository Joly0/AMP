FROM openjdk:8u181-jdk-slim

ARG DEBIAN_FRONTEND=noninteractive



RUN echo "deb http://ftp.de.debian.org/debian stretch main" >> /etc/apt/sources.list



RUN useradd -d /home/AMP -m AMP -s /bin/bash
RUN usermod --password test AMP
RUN chown AMP:AMP -R /home





RUN apt-get -qq --no-install-recommends install software-properties-common dirmngr apt-transport-https gnupg2 locales-all procps
RUN apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key
RUN apt-add-repository "deb http://repo.cubecoders.com/ debian/"
RUN apt-get -qq --no-install-recommends install ampinstmgr



COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh


COPY chown.sh /home/chown.sh
RUN chmod +x /home/chown.sh



RUN apt-get -qq --no-install-recommends install dos2unix
RUN dos2unix /home/start.sh && dos2unix /home/chown.sh
RUN apt-get -qq --purge remove dos2unix
RUN apt-get --purge autoremove 



RUN apt-get -qq clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


VOLUME ["/home"]

EXPOSE 8080

ENTRYPOINT ["/home/start.sh"]
