#!/bin/sh
# File              : nginx/run.sh
# Author            : N3TC4T <netcat.av@gmail.com>
# Date              : 11.07.2018
# Last Modified Date: 11.07.2018
# Last Modified By  : N3TC4T <netcat.av@gmail.com>

set -e

if [ -z $BASIC_AUTH_USERNAME ]; then
  echo >&2 "BASIC_AUTH_USERNAME must be set"
  exit 1
fi

if [ -z $BASIC_AUTH_PASSWORD ]; then
  echo >&2 "BASIC_AUTH_PASSWORD must be set"
  exit 1
fi


htpasswd -bBc /etc/nginx/.htpasswd $BASIC_AUTH_USERNAME $BASIC_AUTH_PASSWORD
sed \
  -e "s/##PORT##/$PORT/g" \
  nginx.conf.tmpl > /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
