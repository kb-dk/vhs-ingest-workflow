#!/bin/bash

cd $(dirname $(readlink -f $0))

echo "Running the suite of integration tests"

for test in vhsfileIntegrationTest.sh; do
    echo ""
    ./setup.sh
    ./$test
    RETURNCODE="$?"
    ./teardown.sh
    if [ "$RETURNCODE" -ne "0" ]; then
        exit "$RETURNCODE"
    fi
    echo ""
done

echo "Tests complete, none failed"

