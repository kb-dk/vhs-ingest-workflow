#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running setup"
source setenv.sh
pushd . > /dev/null
cd $YOUSEE_CONFIG
git pull
popd > /dev/null

$YOUSEE_BIN/setupTaverna.sh
echo "Setup done"
