#!/bin/bash


cd $(dirname $(readlink -f $0))

ENTITY="$1"

NAME=$(basename $0 .sh)

source env.sh


OUTPUT="`reportWorkflowCompleted "$ENTITY" "Workflow completed successfully"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"




