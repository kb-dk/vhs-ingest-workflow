#!/bin/bash


cd $(dirname $(readlink -f $0))

ENTITY="$1"
LOCALFILEURL="$2"

LOCALFILE=$(echo "$LOCALFILEURL" | sed -e 's/file:\/\///g')
REMOTEFILEID=$(echo "$LOCALFILEURL" | sed -e 's/file:\/\///g' | xargs basename)
CHECKSUM=$(md5sum "$LOCALFILE" | cut -d' ' -f1)
FILESIZE=$(stat -c%s "$LOCALFILE")

NAME=$(basename $0 .sh)

source env.sh

APPDIR="$VHSINGEST_COMPONENTS/${bitrepository.ingester}"

# dk.statsbiblioteket.medieplatform.bitrepository.ingester.Ingester \
CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/* \
dk.statsbiblioteket.medieplatform.bitrepository.ingester.TheMockClient \
$CONFIGFILE $LOCALFILEURL $REMOTEFILEID $CHECKSUM $FILESIZE"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"




