#!/bin/bash

cd $(dirname $(readlink -f $0))

##source vhsfileintegrationTestSetEnv.sh

export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"
export URL_PREFIX="http://canopus/cfutvdownload/"


echo "Running the vhs2 file integration test."
echo "This tests just ensures that at least one file makes it through the workflow"

source "/opt/ffmpeg26/enable"
which ffmpeg

cd ..

./bin/startVHS2Workflow.sh --vhsfile /home/tvtape/testfiles/Colossus_20140923_1039.ts --jsonfile /home/tvtape/testfiles/Colossus_20140923_1039.ts.comments

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi

COUNT=`ls -1 $VHSINGEST_LOGS | grep -v \.error | wc -l`
echo $COUNT;
if [ "$COUNT" -gt "0" ]; then
    exit 0
else
    exit 1;
fi
