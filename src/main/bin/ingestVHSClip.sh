#!/bin/bash
#
# This is the entry point for ingestion of clips representing a single broadcast. It is triggered from DOMS
# itself which calls a script vhsclip.sh which directly calls this script via ssh.
#

WD=$(pwd)
cd $(dirname $(readlink -f $0))

source setup.infrastructure.sh
source setup.env.sh
export VHSINGEST_WORKFLOW_CONFIG="$VHSINGEST_CONFIG/vhsclipingestworkflow/"
VERSION=`head -1 $TAVERNA_HOME/release-notes.txt | sed 's/.$//' | cut -d' ' -f4`
LIB="$HOME/.taverna-$VERSION/lib/"
mkdir -p $LIB



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

if [ -z "$JAVA8_HOME" ]; then
   echo "JAVA8_HOME is not set. Must be set before execution. Exiting"
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

cd "$VHSINGEST_LOGS"
flock $VHSINGEST_LOCKS/vhsclip.lock $TAVERNA_HOME/executeworkflow.sh -inmemory "$@" "$VHSINGEST_WORKFLOWS/vhs2clipingest.t2flow"

exit 0

