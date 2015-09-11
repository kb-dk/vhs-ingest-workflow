#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the suite of integration tests"

for test in ./vhs2clipIntegrationTest.sh; do
    ./$test
    RETURNCODE="$?"
    if [ "$RETURNCODE" -ne "0" ]; then
        exit "$RETURNCODE"
    fi
    echo ""
done

echo "Tests complete, none failed"

# ./vhs2fileIntegrationTest.sh ./vhsfileIntegrationTest.sh ./vhsclipIntegrationTest.sh