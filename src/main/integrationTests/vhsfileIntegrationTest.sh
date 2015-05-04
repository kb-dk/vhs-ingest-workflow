#!/bin/bash

cd $(dirname $(readlink -f $0))

source vhsfileintegrationTestSetEnv.sh

echo "Running the vhs file integration test."
echo "This tests just ensures that at least one file makes it through the workflow"

source "/opt/ffmpeg26/enable"
which ffmpeg

cd ..
./bin/ingestVHS2File.sh "-inputvalue" "vhsfile" "/home/tvtape/testfiles/localhost/vhs2/localhost/dr1_digivid_1301643600-2011-04-01-09.40.00_1427911200-2015-04-01-20.00.00.ts" \
"-inputvalue" "jsonfile" "/home/tvtape/testfiles/localhost/vhs2/localhost/dr1_digivid_1301643600-2011-04-01-09.40.00_1427911200-2015-04-01-20.00.00.ts.comments" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass"
#./bin/ingestVHSFile.sh "-inputvalue" "vhsfile" "/home/tvtape/testfiles/localhost/Colossus_20140923_1039.ts" \
#"-inputvalue" "vhslabel" "foobarbaz" \
#"-inputvalue" "vhsfilechecksum" "da974cfff522451ecb578f75efa9c5dc" \
#"-inputvalue" "starttime" "2006-06-29T22:05:56" \
#"-inputvalue" "stoptime" "2006-06-30T03:49:45" \
#"-inputvalue" "quality" "6" \
#"-inputvalue" "domsUser" "fedoraAdmin" \
#"-inputvalue" "domsPass" "fedoraAdminPass"

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi

COUNT=`ls -1 logs/VHS_2_File_Ingest_Wo_output/ | grep -v \.error | wc -l`
echo $COUNT;
if [ "$COUNT" -gt "0" ]; then
    exit 0
else
    exit 1;
fi
