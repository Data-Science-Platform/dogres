# Dogres

- travis-ci.org [![Build Status](https://travis-ci.org/Data-Science-Platform/dogres.svg?branch=master)](https://travis-ci.org/Data-Science-Platform/dogres)
- travis-ci.com [![Build Status](https://travis-ci.com/Data-Science-Platform/dogres.svg?branch=master)](https://travis-ci.com/Data-Science-Platform/dogres)
- docker hub [![Docker Pulls](https://img.shields.io/docker/pulls/datascienceplatform/dogresd.svg?maxAge=2592000)](https://hub.docker.com/r/datascienceplatform/dogresd/)

Docker image with ssh including postgres tools

- clusterdb
- createdb
- createlang
- createuser
- dropdb
- droplang
- dropuser
- pg_basebackup
- pg_dump
- pg_dumpall
- pg_isready
- pg_receivexlog
- pg_restore
- psql
- reindexdb
- vacuumdb

# Usage

Providing an SSH with PostgreSQL tools
```
POSTGRES_VERSION=9.3; \
DOGRES_HOST_PORT=8022; \
DOGRES_CONTAINER_PORT=22; \
sudo docker run -d -p ${DOGRES_HOST_PORT}:${DOGRES_CONTAINER_PORT} \
  -v $(pwd)/ssh-keys:/ssh-keys \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/pam.d/common-session:/etc/pam.d/common-session:ro \
  -v /etc/nsswitch.conf:/etc/nsswitch.conf:ro \
  -v /etc/ldap.conf:/etc/ldap.conf:ro \
  -v /etc/ssl/certs/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt:ro \
  -e LDAP_MATCH_GROUP=postgres \
  -e DOGRES_SSH_PORT=${DOGRES_CONTAINER_PORT} \
  datascienceplatform/dogresd:latest-${POSTGRES_VERSION}
```