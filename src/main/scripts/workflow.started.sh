#!/bin/bash


cd $(dirname $(readlink -f $0))

ENTITY="$1"

NAME=$(basename $0 .sh)

source env.sh



OUTPUT="`reportWorkflowStarted "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"


