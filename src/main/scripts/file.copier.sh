#!/bin/bash

cd $(dirname $(readlink -f $0))

NAME=$(basename $0 .sh)

source env.sh

source $CONFIGFILE

if [ -z $1 ]; then
	exit 1
fi

FILEURLINPUT="$1"

FILEID="$(basename $FILEURLINPUT)"
REMOTEHOST="$(basename $(dirname $FILEURLINPUT))"

DESTINATION="$WORKDIR/$FILEID"

CMD="scp $REMOTEHOST:$REMOTEDIR/$FILEID $DESTINATION"

execute "$PWD" "$CMD" "$NAME" "$FILEID"
RETURNCODE=$?
echo $DESTINATION

exit $RETURNCODE

