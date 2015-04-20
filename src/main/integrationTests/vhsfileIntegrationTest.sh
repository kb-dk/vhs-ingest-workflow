#!/bin/bash

cd $(dirname $(readlink -f $0))

source vhsfileintegrationTestSetEnv.sh

echo "Running the vhs file integration test."
echo "This tests just ensures that at least one file makes it through the workflow"

source "/opt/ffmpeg26/enable"
which ffmpeg

cd ..
./bin/ingestVHSFile.sh "-inputvalue" "vhsfile" "/home/tvtape/testfiles/localhost/Colossus_20140923_1039.ts" \
"-inputvalue" "vhslabel" "foobarbaz" \
"-inputvalue" "vhsfilechecksum" "da974cfff522451ecb578f75efa9c5dc" \
"-inputvalue" "starttime" "2006-06-29T22:05:56" \
"-inputvalue" "stoptime" "2006-06-30T03:49:45" \
"-inputvalue" "quality" "6" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass" 

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi

COUNT=`ls -1 logs/Workflow1_output/ | grep -v \.error | wc -l`
echo $COUNT;
if [ "$COUNT" -gt "0" ]; then
    exit 0
else
    exit 1;
fi
