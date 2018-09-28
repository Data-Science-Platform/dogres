FROM ubuntu:16.04

ARG POSTGRES_VERSION

RUN echo "POSTGRES_VERSION="${POSTGRES_VERSION}

RUN \
  apt-get -qq update && \
  apt-get -qq install --yes \
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
      libnss-ldap ldap-utils \
      openssh-server && \
  apt-get clean all

RUN echo "POSTGRES_VERSION="${POSTGRES_VERSION}

RUN \
  export CODENAME=$(cat /etc/lsb-release| grep '^DISTRIB_CODENAME=' | awk -F= '{print $2}') && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ ${CODENAME}-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  apt-get install --yes \
    postgresql-client-${POSTGRES_VERSION} && \
  apt-get clean all

RUN mkdir /var/run/sshd

COPY sshd_config.template /etc/ssh/sshd_config.template

RUN mkdir /ssh-keys

RUN mkdir /workdir

COPY docker-entrypoint.sh .

RUN chmod u+x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
