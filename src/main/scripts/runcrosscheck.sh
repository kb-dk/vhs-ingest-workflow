#!/bin/bash

cd $(dirname $(readlink -f $0))

if [ -z "$1" ]; then
        echo "No file to check supplied"
        exit 1
fi

cat ../testdata/crosscheckdata
