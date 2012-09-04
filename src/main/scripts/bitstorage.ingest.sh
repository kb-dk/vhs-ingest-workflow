#!/bin/bash


cd $(dirname $(readlink -f $0))

ENTITY=$1
LOCALFILE=$2

NAME=`basename $0 .sh`

source env.sh

CMD="$VHSINGEST_COMPONENTS/${bitstorage.ingest}/bin/${bitstorage.ingest}.sh $LOCALFILE $CONFIGFILE"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"




