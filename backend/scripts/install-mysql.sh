#!/usr/bin/env bash

if [ $1 ] ; then
  export DEST_DIR=$1
else
  export DEST_DIR=$(pwd)
fi

if [ -e $DEST_DIR/.env ]; then
    export $(grep -v '^#' $DEST_DIR/.env | grep -v '^$' | xargs)
fi
if [ -e $DEST_DIR/.env.local ]; then
    export $(grep -v '^#' $DEST_DIR/.env.local | grep -v '^$' | xargs)
fi

export DB_URL="mysql://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"
export DB_URL_REDACTED="mysql://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"
./$(dirname $0)/install.sh
