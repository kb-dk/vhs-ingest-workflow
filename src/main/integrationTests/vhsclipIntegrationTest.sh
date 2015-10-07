#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the vhs clip integration test for mpeg files."
echo "This tests just ensures that at least one mpeg file makes it through the workflow"
export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"


cd ..
./bin/ingestVHSClip.sh "-inputvalue" "inputfile" "/home/tvtape/testfiles/localhost/dr1_1995-02-18_18.50-18.51.mpg" \
"-inputvalue" "programPid" "uuid:a3d19569-07c9-480f-8561-6dbf5e11d144" \
"-inputvalue" "domsUser" "fedoraAdmin" \
"-inputvalue" "domsPass" "fedoraAdminPass" 

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi


#"-inputvalue" "programPid" "uuid:ee69215e-57f9-4fc8-b1f0-913a6d4844eb" \
#"-inputvalue" "programPid" "uuid:4b48d89f-741a-498e-92f1-0b39ea2eef4b" \

