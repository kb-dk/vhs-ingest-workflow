#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the vhs 2 clip integration test; that is the one for ts files. $0"
echo "This tests just ensures that at least one ts file makes it through the workflow"
export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"

cd ..
./bin/ingestVHSClip.sh "-inputvalue" "inputfile" "/home/tvtape/testfiles/localhost/Colossus_20150624_1341.ts" \
"-inputvalue" "programPid" "uuid:0e7ef9a9-eeb1-4584-aee5-458fb12d55dc" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass"

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi



#"-inputvalue" "programPid" "uuid:ee69215e-57f9-4fc8-b1f0-913a6d4844eb" \
#"-inputvalue" "programPid" "uuid:4b48d89f-741a-498e-92f1-0b39ea2eef4b" \

