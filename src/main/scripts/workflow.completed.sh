#!/bin/bash


cd $(dirname $(readlink -f $0))

ENTITY="$1"
FILE="$2"
MESSAGE="$3"

NAME=$(basename $0 .sh)

source env.sh

rm "$FILE"

OUTPUT="`reportWorkflowCompleted "$ENTITY" "$MESSAGE"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"




