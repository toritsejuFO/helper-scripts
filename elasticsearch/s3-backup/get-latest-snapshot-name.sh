#!/bin/bash

help () {
  echo "This script returns the name of the last snapshot taken, this may be the snapshot currently running under the repo you provided"
  echo "localhost and 9200 is used by default for host and port except otherwise specified"
  echo "You must however provide an existing repo name"
  echo
  echo "Usage: $0 -r repo [-h host] [-p port]"
  echo
  echo  -h --host   host
  echo  -p --port   port
  echo  -r --repo   repo
}

if [ "$1" == '--help' ]; then
  help; exit 1;
fi

while [[ "$#" > 0 ]]; do
  case "$1" in
    -h | --host) HOST="$2"; shift 2 ;;
    -p | --port) PORT="$2"; shift 2 ;;
    -r | --repo) REPO="$2"; shift 2 ;;
    *) echo "Invalid parameter passed: $1"; help; exit 1;
  esac
done

HOST=${HOST:-'localhost'}
PORT=${PORT:-'9200'}

if [ "$REPO" ]; then
  curl $HOST:$PORT/_snapshot/$REPO/_all?pretty | grep snapshot | tail -n 1 | awk '{print $3}' | sed 's/[",]//g'
else
  echo "You must provide an existing repo name"
  echo
  echo "Usage: $0 -r repo [-h host] [-p port]"
fi

