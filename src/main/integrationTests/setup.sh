#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running setup"
source setupSetenv.sh
pushd . > /dev/null
cd $VHSINGEST_CONFIG
git pull
popd > /dev/null

$VHSINGEST_BIN/setupTaverna.sh
echo "Setup done"
