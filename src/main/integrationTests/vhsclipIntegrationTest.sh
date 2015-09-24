#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the vhs clip integration test."
echo "This tests just ensures that at least one file makes it through the workflow"
export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"


cd ..
./bin/ingestVHSClip.sh "-inputvalue" "inputfile" "/home/tvtape/testfiles/localhost/Klip_18_2_2005_15_56.mpeg" \
"-inputvalue" "programPid" "uuid:4b48d89f-741a-498e-92f1-0b39ea2eef4b" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass" 

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi


#"-inputvalue" "programPid" "uuid:ee69215e-57f9-4fc8-b1f0-913a6d4844eb" \

