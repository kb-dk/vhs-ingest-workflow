#!/bin/bash

cd $(dirname $(readlink -f $0))

source vhsfileintegrationTestSetEnv.sh

echo "Running the vhs file integration test."
echo "This tests just ensures that at least one file makes it through the workflow"


cd ..
./bin/ingestVHSFile.sh "-inputvalue" "mpgfile" "/home/tvtape/testfiles/localhost/Deadline_18_2_2005_18_1.mpeg" \
"-inputvalue" "vhslabel" "foobarbaz" \
"-inputvalue" "starttime" "2006-06-29T22:05:56" \
"-inputvalue" "stoptime" "2006-06-30T03:49:45" \
"-inputvalue" "quality" "6" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass" 

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
