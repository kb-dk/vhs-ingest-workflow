#!/bin/bash

cd $(dirname $(readlink -f $0))


ENTITY=$1
LOCALFILE=$2

NAME=`basename $0 .sh`

source env.sh

APPDIR="$YOUSEE_COMPONENTS/${crosscheck.characteriser}"

#CMD="$APPDIR/bin/crosscheckCharacterise.sh $LOCALFILE $CONFIGFILE"
CMD="cat $YOUSEE_HOME/examples/crossCheck_output.xml"
OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"

RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

