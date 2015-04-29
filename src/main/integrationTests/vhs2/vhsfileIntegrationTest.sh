#!/bin/bash

cd $(dirname $(readlink -f $0))

source vhsfileintegrationTestSetEnv.sh

echo "Running the vhs file integration test."
echo "This tests just ensures that at least one file makes it through the workflow"

source "/opt/ffmpeg26/enable"
which ffmpeg

cd ../..
./bin/ingestVHS2File.sh "-inputvalue" "vhsfile" "/home/tvtape/testfiles/localhost/vhs2/localhost/dr1_digivid_1301643600-2011-04-01-09.40.00_1427911200-2015-04-01-20.00.00.ts" \
"-inputvalue" "jsonfile" "/home/tvtape/testfiles/localhost/vhs2/localhost/dr1_digivid_1301643600-2011-04-01-09.40.00_1427911200-2015-04-01-20.00.00.ts.comments" \
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
