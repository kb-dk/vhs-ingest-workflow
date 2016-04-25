#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the vhs 2 clip integration test; that is the one for ts files. $0"
echo "This tests just ensures that at least one ts file makes it through the workflow"
export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"
export JAVA8_HOME=/usr/java/java-1.8.0-oracle-1.8.0.65.x86_64/jre/

cd ..
./bin/ingestVHSClip.sh "-inputvalue" "mpgfile" "/home/tvtape/testfiles/localhost/dr2_digivid_1263157200-2010-01-10-22.00.00_1263157320-2010-01-10-22.02.00.ts" \
"-inputvalue" "programPid" "uuid:0e7ef9a9-eeb1-4584-aee5-458fb12d55dc" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass"

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi


