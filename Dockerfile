FROM ubuntu:16.04

ARG POSTGRES_VERSION

RUN echo "POSTGRES_VERSION="${POSTGRES_VERSION}

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  touch /etc/libnss-ldap.conf /etc/pam_ldap.conf && \
  apt-get -qq update && \
  DEBIAN_FRONTEND=noninteractive \
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
      openssh-server \
      locales && \
  apt-get clean all

RUN export LANGUAGE=en_US.UTF-8 && \
  export LANG=en_US.UTF-8 && \
  export LC_ALL=en_US.UTF-8 && \
  locale-gen en_US.UTF-8 && \
  DEBIAN_FRONTEND=noninteractive \
  dpkg-reconfigure locales && \
  echo 'export LC_ALL="en_US.UTF-8"'>> /etc/profile

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
COPY nsswitch.conf /etc/nsswitch.conf

RUN mkdir /ssh-keys

RUN mkdir /workdir

COPY docker-entrypoint.sh .

RUN chmod u+x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
