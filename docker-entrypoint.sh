#!/usr/bin/env bash

echo "LDAP_MATCH_GROUP="$LDAP_MATCH_GROUP
echo "DOGRES_SSH_PORT="$DOGRES_SSH_PORT

if [ -z "$LDAP_MATCH_GROUP" ] || [ -z "$DOGRES_SSH_PORT" ]
then
  echo "Please set all required environment variables."
  exit 1
fi

envsubst < /etc/ssh/sshd_config.template > /etc/ssh/sshd_config

echo "alias sudo='fortune && true'" >> /etc/bash.bashrc

# echo "export PATH=$PATH:/spark/bin" >> /etc/bash.bashrc

_term() {
  echo "Terminating!"
  kill -TERM "$child" 2>/dev/null
}

_kill() {
  echo "Killing!"
  kill -KILL "$child" 2>/dev/null
}

trap _term SIGINT
trap _term SIGTERM

/usr/sbin/sshd -D -e &

child=$!
wait "$child"
