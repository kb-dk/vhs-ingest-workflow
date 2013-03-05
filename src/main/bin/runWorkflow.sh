#!/bin/bash

WD=$(pwd)
cd $(dirname $(readlink -f $0))

if [ -r setenv.sh ]; then
    source setenv.sh
fi

INPUT=""

for var in "$@"
do
      INPUT="  $INPUT -inputvalue ${var/=/ } "
done



if [ -z "$VHSINGEST_HOME" ]; then
   echo "VHSINGEST_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi


if [ -z "$TAVERNA_HOME" ]; then
   echo "TAVERNA_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi

if [ -z "$JAVA_HOME" ]; then
   echo "JAVA_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi

if [ -z "$VHSINGEST_WORKFLOW_CONFIG" ]; then
   echo "VHSINGEST_WORKFLOW_CONFIG is not set. Must be set before execution. Exiting"
   exit 1
fi




cd $WD
mkdir -p $VHSINGEST_LOGS
mkdir -p $VHSINGEST_LOCKS
echo $JAVA_HOME
echo $INPUT
$TAVERNA_HOME/executeworkflow.sh \
-inmemory \
$INPUT \
"$VHSINGEST_WORKFLOWS/vhsfileingest.t2flow"


exit 0

