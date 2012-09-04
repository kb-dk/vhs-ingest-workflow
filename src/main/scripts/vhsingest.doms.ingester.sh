#!/bin/bash

cd $(dirname $(readlink -f $0))

ENTITY=$1
REMOTEURL=$2
CHECKSUM=$3
FFPROBEPROFILE_LOCATION=$4
CROSSCHECKPROFILE_LOCATION=$5
YOUSEEMETADATA_LOCATION=$6

NAME=`basename $0 .sh`

source env.sh

APPDIR="$VHSINGEST_COMPONENTS/${vhsingest.doms.ingester}"

CMD="echo {\"domsPid\": \"uuid:9dabe130-f1d9-11e1-aff1-0800200c9a66\"}"
#CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/*:`dirname $CONFIGFILE` \
# dk.statsbiblioteket.doms.vhsingest.YouseeIngesterCLI \
# -filename $ENTITY \
# -url $REMOTEURL \
# -ffprobe $FFPROBEPROFILE_LOCATION \
# -crosscheck $CROSSCHECKPROFILE_LOCATION \
# -metadata $YOUSEEMETADATA_LOCATION \
# -config $CONFIGFILE "

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"
