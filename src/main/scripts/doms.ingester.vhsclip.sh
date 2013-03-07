#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

ENTITY=$1
REMOTEURL=$2
CHECKSUM=$3
FFPROBEPROFILE_LOCATION=$4
FFPROBEERROR_LOCATION=$5
METADATA_LOCATION=$5
USERNAME=$6
PASSWORD=$7
PID=$8

NAME=$(basename $0 .sh)

source "$SCRIPT_PATH/env.sh"

APPDIR="$VHSINGEST_COMPONENTS/${doms.ingester.vhsclip}"

#CMD="echo {\"domsPid\": \"uuid:9dabe130-f1d9-11e1-aff1-0800200c9a66\"}"
CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/*:$(dirname $CONFIGFILE) \
 dk.statsbiblioteket.doms.radiotv.RadioTVIngesterCLI \
 -filename $ENTITY \
 -url $REMOTEURL \
 -ffprobe $FFPROBEPROFILE_LOCATION \
 -ffprobeErrorLog $FFPROBEERROR_LOCATION \
 -metadata $METADATA_LOCATION \
 -config $CONFIGFILE \
 -user $USERNAME \
 -pass $PASSWORD \
 -programpid $PID"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

