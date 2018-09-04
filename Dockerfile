FROM ubuntu:16.04

RUN \
  apt-get update && \
  apt-get install -y \
    curl \
    wget \
    grep \
    sed \
    git \
    bzip2 zip unzip \
    gettext \
    sudo \
    ca-certificates \
    fortune \
    openssh-server \
    postgresql-client && \
  apt-get clean all

RUN mkdir /var/run/sshd

COPY sshd_config.template /etc/ssh/sshd_config.template

RUN mkdir /ssh-keys

COPY docker-entrypoint.sh .

RUN chmod u+x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
