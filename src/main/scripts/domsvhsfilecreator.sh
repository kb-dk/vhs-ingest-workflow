#!/bin/bash

cd $(dirname $(readlink -f $0))

if [ -z "$1" ]; then
        echo "Crosscheck input not supplied"
        exit 1
fi

if [ -z "$2" ]; then
        echo "ffprobe input not supplied"
        exit 1
fi

if [ -z "$3" ]; then
        echo "No file url supplied"
        exit 1
fi



echo "uuid:9dabe130-f1d9-11e1-aff1-0800200c9a66"
