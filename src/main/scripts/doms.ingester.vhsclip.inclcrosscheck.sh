#!/bin/bash

WD=$(pwd)
cd $(dirname $(readlink -f $0))

ENTITY="$1"
REMOTEURL="$2"
CHECKSUM="$3"
FFPROBEPROFILE_LOCATION="$4"
FFPROBEERROR_LOCATION="$5"
METADATA_LOCATION="$6"
CROSSCHECKPROFILE_LOCATION="$7"
USERNAME="$8"
PASSWORD="$9"
PID="$10"

NAME=$(basename $0 .sh)

source "env.sh"

cd $WD
APPDIR="$VHSINGEST_COMPONENTS/${doms.ingester.project}"

#CMD="echo {\"domsPid\": \"uuid:9dabe130-f1d9-11e1-aff1-0800200c9a66\"}"
CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/*:$(dirname $CONFIGFILE) \
 dk.statsbiblioteket.doms.radiotv.RadioTVIngesterCLI \
 -filename $ENTITY \
 -url $REMOTEURL \
 -ffprobe $FFPROBEPROFILE_LOCATION \
 -ffprobeErrorLog $FFPROBEERROR_LOCATION \
 -crosscheck=$CROSSCHECKPROFILE_LOCATION \
 -metadata $METADATA_LOCATION \
 -config $CONFIGFILE \
 -user $USERNAME \
 -pass $PASSWORD \
 -programpid $PID"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

