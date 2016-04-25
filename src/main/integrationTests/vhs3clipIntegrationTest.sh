#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the vhs 3 clip integration test. $0"
echo "This tests ensures that a ts file with profile NOT 'Baseline' or 'Main' does NOT make it through the workflow"
export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"
export JAVA8_HOME=/usr/java/java-1.8.0-oracle-1.8.0.65.x86_64/jre/

cd ..
./bin/ingestVHSClip.sh "-inputvalue" "mpgfile" "/home/tvtape/testfiles/localhost/dk4.ts" \
"-inputvalue" "programPid" "uuid:0e7ef9a9-eeb1-4584-aee5-458fb12d55dc" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass"

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi


