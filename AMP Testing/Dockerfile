FROM bitnami/minideb:stretch

ENV AMPUSER=admin
ENV AMPPASSWORD=changeme123
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive


RUN useradd -d /home/AMP -m AMP -s /bin/bash
RUN chown AMP:AMP -R /home


RUN touch /etc/inittab
RUN mkdir -p /usr/share/man/man1
RUN install_packages dumb-init locales cron lib32gcc1 coreutils inetutils-ping tmux socat unzip wget git procps lib32gcc1 lib32stdc++6 software-properties-common dirmngr apt-transport-https software-properties-common dirmngr apt-transport-https gnupg apt-utils vim

RUN export EDITOR=vim

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN update-locale LANG=en_US.UTF-8


RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
RUN apt-add-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
RUN install_packages adoptopenjdk-8-openj9-jre


RUN apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key
RUN apt-add-repository "deb http://repo.cubecoders.com/ debian/"
RUN install_packages ampinstmgr


RUN apt -q autoremove --purge
RUN apt -q autoclean


RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN su -l AMP -c '(crontab -l ; echo "@reboot ampinstmgr -b")| crontab -'
RUN mkdir -p /data
RUN touch /data/empty
RUN chown AMP:AMP /data
RUN ln -s /data /home/AMP/.ampdata

RUN echo 'if [ -d "/home/AMP/.ampdata/ADS01" ]; then su - AMP -c "ampinstmgr startinstance ADS01 & disown"; exec /bin/bash; else su - AMP -c "ampinstmgr quickstart $AMPUSER $AMPPASSWORD & disown"; exec /bin/bash; fi;' > /home/start.sh
RUN chmod +x /home/start.sh

EXPOSE 8080

VOLUME ["/data"]


ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/home/start.sh"]
