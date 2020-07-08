FROM debian:10-slim AS amp-base-image

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    systemd \
    locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get -y clean && \
    apt-get -y autoremove --purge && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

FROM amp-base-image

EXPOSE 8080-8180
EXPOSE 5678-5688
EXPOSE 7777-7877
EXPOSE 21025-21125
EXPOSE 25565-25665
EXPOSE 27015-27115
EXPOSE 28015-28115
EXPOSE 34197-34297

ENV ANSWER_AMPUSER=admin
ENV ANSWER_AMPPASS=changeme123

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN export ANSWER_SYSPASSWORD=$(cat /proc/sys/kernel/random/uuid) && \
    export USE_ANSWERS=1 && \
    export SKIP_INSTALL=1 && \
    export ANSWER_INSTALLJAVA=1 && \
    mkdir /usr/share/man/man1 && \
    apt-get update && \
    apt-get install -y --no-install-suggests wget procps && \
    bash -c "bash <(wget -qO- getamp.sh )" && \
    apt-get clean && \
    apt-get -y autoremove --purge && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

VOLUME ["/home/amp"]

ENTRYPOINT [ "/sbin/init" ]
CMD [ (su -l amp -c "ampinstmgr quick '${ANSWER_AMPUSER}' '${ANSWER_AMPPASS}') || bash || tail -f /dev/null ]
