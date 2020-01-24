#!/bin/bash

help () {
  echo "localhost and 9200 is used by default for host and port except otherwise specified"
  echo "You must however provide the repo name and the s3 bucket name to link this repo to"
  echo
  echo "Usage: $0 -b s3-bucket-name -r repo [-h host] [-p port]"
  echo
  echo  -h --host   host
  echo  -p --port   port
  echo  -b --bucket s3-bucket-name
  echo  -r  --repo repo
}

# Run help function if it's the first argument
if [ "$1" == '--help' ]; then
  help; exit 1;
fi

# Loop through all arguments and assign them to variables appropriately
while [[ "$#" > 0 ]]; do
  case "$1" in
    -h | --host) HOST="$2"; shift 2 ;;
    -p | --port) PORT="$2"; shift 2 ;;
    -b | --bucket) BUCKET="$2"; shift 2 ;;
    -r | --repo) REPO="$2"; shift 2 ;;
    *) echo "Invalid parameter passed: $1"; help; exit 1;
  esac
done

# Set defaults for the host and port
HOST=${HOST:-'localhost'}
PORT=${PORT:-'9200'}

# Make request to elasticsearch
if [ $BUCKET ] && [ $REPO ]; then
  curl -X PUT "$HOST:$PORT/_snapshot/$REPO?pretty" -H "Content-Type: application/json" -d'
  {
    "type": "s3",
    "settings": {
      "bucket": "'"$BUCKET"'"
    }
  }'
else
  echo "You must provide the repo name and the s3 bucket name to link this repo to"
  echo
  echo "Usage: $0 -b s3-bucket-name -r repo [-h host] [-p port]"
fi

