FROM bitnami/minideb:stretch

ENV DEBIAN_FRONTEND=noninteractive

# Installing everything needed an Cleanup after it
RUN mkdir /usr/share/man/man1 && \
    useradd -d /home/AMP -m AMP -s /bin/bash && \
    chown AMP:AMP -R /home && \
    apt-get -qq update && \
    apt-get -qq --no-install-recommends install \
    dumb-init \
    coreutils \
    locales \
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
    procps \
    gnupg2 \
    dos2unix && \
    apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key && \
    apt-add-repository "deb http://repo.cubecoders.com/ debian/" && \
    apt-get update && \
    apt-get -qq install ampinstmgr --no-install-recommends --install-suggests && \
    apt-get -qq clean 

# Solves the Tmux locale problem
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen  && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# Copy the scripts and make them executable
COPY start.sh /home/
RUN  chmod +x /home/start.sh

# Convert the scripts to Unix format, remove dos2unix and gnupg after that and full cleanup of everything
RUN dos2unix /home/start.sh && \
    apt-get -qq remove --purge dos2unix gnupg2 && \
    apt-get -qq clean && \
    su -c "rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* "

# Volume to access the scripts and edit them or to Copy files into the Instances
VOLUME ["/home"]

# Not needed, but expose some Ports

EXPOSE 8080-8180
EXPOSE 5678-5688
EXPOSE 7777-7877
EXPOSE 21025-21125
EXPOSE 25565-25665
EXPOSE 27015-27115
EXPOSE 28015-28115
EXPOSE 34197-34297

# Set Entrypoint to Dumb-init and run the start script
ENTRYPOINT ["/usr/bin/dumb-init", "--"] 
CMD ["/home/start.sh"]
