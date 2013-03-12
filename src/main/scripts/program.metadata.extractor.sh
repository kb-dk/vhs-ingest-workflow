#!/bin/bash

FILENAME="$1"
PID="$2"
DATASTREAM="PROGRAM_BROADCAST"
DOMSUSER="$3"
DOMSPASS="$4"

SCRIPT_PATH=$(dirname $(readlink -f $0))

NAME="${doms.ingester.vhsclip}"
source "$SCRIPT_PATH/env.sh"

# it is assumed that fedorawebserviceurl is of the form:
# http://localhost:7880/centralWebservice-service/central/?wsdl
DOMSURL=$(cat "$CONFIGFILE" | grep "dk.statsbiblioteket.doms.fedorawebserviceurl"  | cut -d'=' -f2 | cut -d'/' -f1,2,3,4)
DOMSURL="${DOMSURL}/rest/objects/${PID}/datastreams/${DATASTREAM}"

NAME=$(basename $0 .sh)

CMD="curl --user $DOMSUSER:$DOMSPASS $DOMSURL"
OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$FILENAME"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

