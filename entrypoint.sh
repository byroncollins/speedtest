#!/usr/bin/bash

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${MULE_HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi


exec /usr/bin/speedtest --progress=no