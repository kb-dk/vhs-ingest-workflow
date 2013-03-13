#!/bin/bash


cd $(dirname $(readlink -f $0))

ENTITY="$1"
MESSAGE="$2"

NAME=$(basename $0 .sh)

source env.sh


OUTPUT="`reportWorkflowCompleted "$ENTITY" "$MESSAGE"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"




