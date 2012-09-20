#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the first integration test."
echo "This tests just ensures that at least one file makes it through the workflow"


cd ..
./bin/runWorkflow.sh "/home/yousee/scratch/vhstestfiles/Deadline_18_2_2005_18_1.mpeg" \
"foobarbaz" "2006-06-29T22:05:56" "2006-06-30T03:49:45" "dr2" "6" "jukebox1"
RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi

COUNT=`ls -1 Workflow1_output/ | grep -v \.error | wc -l`
echo $COUNT;
if [ "$COUNT" -gt "0" ]; then
    exit 0
else
    exit 1;
fi
