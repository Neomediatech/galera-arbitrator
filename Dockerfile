FROM neomediatech/ubuntu-base:20.04

ENV VERSION=25.3.29-1 \
    SERVICE=galera-arbitrator

LABEL maintainer="docker-dario@neomediatech.it" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/$SERVICE \
      org.label-schema.maintainer=Neomediatech

RUN apt-get update && apt-get -y dist-upgrade ; \
    apt-get -y install --no-install-recommends galera-arbitrator-3 ; \
    rm -rf /var/lib/apt/lists/*

EXPOSE 4567

ENTRYPOINT ["/usr/bin/garbd","-c","/data/garb.cfg"]
