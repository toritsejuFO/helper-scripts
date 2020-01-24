#!/bin/bash

help () {
  echo "localhost and 9200 is used by default for host and port except otherwise specified"
  echo "You must however provide the elasticsearch repo name and the snapshot name"
  echo
  echo "Usage: $0 -s snapshot -r repo [-h host] [-p port]"
  echo
  echo  -h --host   host
  echo  -p --port   port
  echo  -s --snapshot snapshot
  echo  -r --repo   repo
  echo  --help to see this help page
}

if [ "$1" == '--help' ]; then
  help; exit 1;
fi

while [[ "$#" > 0 ]]; do
  case "$1" in
    -h | --host) HOST="$2"; shift 2 ;;
    -p | --port) PORT="$2"; shift 2 ;;
    -r | --repo) REPO="$2"; shift 2 ;;
    -s | --snapshot) SNAPSHOT="$2"; shift 2 ;;
    *) echo "Invalid parameter passed: $1"; help; exit 1;
  esac
done

HOST=${HOST:-'localhost'}
PORT=${PORT:-'9200'}

if [ $REPO ] && [ $SNAPSHOT ]; then
  curl -X DELETE "$HOST:$PORT/_snapshot/$REPO/$SNAPSHOT?pretty"
else
  echo "You must provide the elasticsearch repo name and snapshot name"
  echo
  echo "Usage: $0 -s snapshot -r repo [-h host] [-p port]"
fi

