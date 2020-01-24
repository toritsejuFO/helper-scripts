#!/bin/bash

help () {
  echo "localhost and 9200 is used by default for host and port except otherwise specified"
  echo "You must however provide the elasticsearch repository name"
  echo
  echo "Usage: $0 -r repo [-h host] [-p port]"
  echo
  echo  -h --host   host
  echo  -p --port   port
  echo  -r --repo   repo
  echo  --help to see this help page
}

if [ "$1" == '--help' ]; then
  help
  exit
fi

while [[ "$#" > 0 ]]; do
  case "$1" in
    -h | --host) HOST="$2"; shift 2 ;;
    -p | --port) PORT="$2"; shift 2 ;;
    -r | --repo) REPO="$2"; shift 2 ;;
    *) echo "Invalid parameter passed: $1"; help; exit;
  esac
done

HOST=${HOST:-'localhost'}
PORT=${PORT:-'9200'}

if [ $REPO ]; then
  curl "$HOST:$PORT/_snapshot/$REPO?pretty"
else
  echo "You must provide the elasticsearch repository name"
  echo
  echo "Usage: $0 -r repo [-h host] [-p port]"
fi

