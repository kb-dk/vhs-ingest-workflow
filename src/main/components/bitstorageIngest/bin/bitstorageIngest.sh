
#!/bin/bash

BASEURL="http://bitfinder.statsbiblioteket.dk/bart/"

cd $(dirname $(readlink -f $0))

if [ -z "$1" ]; then
        echo "No file to ingest supplied"
        exit 1
fi

FILE=$(echo "$1" | sed -e 's/file:\/\///g' | xargs basename)
echo "{\"UrlToFile\":\"$BASEURL$FILE\"}"
