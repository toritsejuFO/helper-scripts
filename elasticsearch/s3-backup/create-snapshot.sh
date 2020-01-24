#!/bin/bash

help () {
  echo "localhost and 9200 is used by default for host and port except otherwise specified"
  echo "You must however provide an existing repo name, name you want to call the snapshot and the index name"
  echo
  echo "Usage: $0 -r repo -s snapshot -i index [-h host] [-p port]"
  echo
  echo  -h --host   host
  echo  -p --port   port
  echo  -r --repo   repo
  echo  -s --snapshot   snapshot
  echo  -i --index index
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
    -i | --index) INDEX="$2"; shift 2 ;;
    *) echo "Invalid parameter passed: $1"; help; exit 1;
  esac
done

HOST=${HOST:-'localhost'}
PORT=${PORT:-'9200'}

if [ "$SNAPSHOT" ]; then
  curl -XPUT "$HOST:$PORT/_snapshot/$REPO/$SNAPSHOT?pretty" -H "Content-Type: application/json" -d '
  {
    "indices": "'"$INDEX"'",
    "ignore_unavailable": true,
    "include_global_state": false
  }
  '
else
  echo "You must provide an existing repo name, name you want to call the snapshot and the index name"
  echo
  echo "Usage: $0 -r repo -s snapshot -i index [-h host] [-p port]"
fi

