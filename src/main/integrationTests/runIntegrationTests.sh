#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the suite of integration tests"

VHSINGEST_LOGS=$HOME/services/vhs-ingest-workflow/logs/Workflow1_output
for test in vhsclipIntegrationTest.sh vhs2clipIntegrationTest.sh vhs2fileIntegrationTest.sh vhsfileIntegrationTest.sh; do
    rm -rf $VHSINGEST_LOGS
    ./$test
    RETURNCODE="$?"
    if [ "$RETURNCODE" -ne "0" ]; then
        exit "$RETURNCODE"
    fi
    COUNT=`ls -1 $VHSINGEST_LOGS | grep \.error | wc -l`
    echo $COUNT;
    if [[ $COUNT > 0 ]]; then
        exit 1
    fi
    echo "$test ran succesfully"
done

echo "Tests complete, none failed"

#