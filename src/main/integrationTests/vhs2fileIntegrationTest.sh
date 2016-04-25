#!/bin/bash

cd $(dirname $(readlink -f $0))

##source vhsfileintegrationTestSetEnv.sh

export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"
export JAVA8_HOME=/usr/java/java-1.8.0-oracle-1.8.0.65.x86_64/jre/

echo "Running the vhs2 file integration test."
echo "This tests just ensures that at least one ts file makes it through the workflow"

source "/opt/ffmpeg26/enable"

cd ..

./bin/startVHS2Workflow.sh --vhsfile /scratch-tvtape-test/dr1_digivid_1451890800-2016-01-04-08.00.00_1451890920-2016-01-04-08.02.00.ts \
--jsonfile /scratch-tvtape-test/dr1_digivid_1451890800-2016-01-04-08.00.00_1451890920-2016-01-04-08.02.00.ts.comments

RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi
