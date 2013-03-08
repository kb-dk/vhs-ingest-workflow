#!/bin/bash

cd $(dirname $(readlink -f $0))

source vhsclipintegrationTestSetEnv.sh

echo "Running the vhs clip integration test."
echo "This tests just ensures that at least one file makes it through the workflow"

cd ..
./bin/ingestVHSClip.sh "-inputvalue" "mpgfile" "/home/yousee/scratch/vhstestfiles/Klip_17_2_2005_15_56.mpeg" \
"-inputvalue" "programPid" "uuid:ee69215e-57f9-4fc8-b1f0-913a6d4844eb" \
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
