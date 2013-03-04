#!/bin/bash


pushd $(dirname $(readlink -f $0)) > /dev/null

ENTITY=$1
LOCALFILE=$2

NAME=`basename $0 .sh`

source env.sh

CMD="$VHSINGEST_COMPONENTS/${ffprobe.characteriser}/bin/ffprobeCharacterise.sh $LOCALFILE $CONFIGFILE"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"

popd > /dev/null
exit "$RETURNCODE"

