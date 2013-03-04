#!/bin/bash

function report(){
    local COMPONENT="$1"
    shift
    local STATE="$1"
    shift
    local ENTITY="$1"
    shift
    local MESSAGE="$*"

    if [ -n "$MESSAGE" ]; then
        MESSAGE=${MESSAGE:0:254}
        MESSAGE=`echo -e "<message><![CDATA[""$MESSAGE""]]></message>"`
    else
        MESSAGE=""
    fi
    local STATE="<stateName>$STATE</stateName>"
    local COMPONENT="<component>$COMPONENT</component>"
    local STATEBLOB="<state>$COMPONENT$STATE$MESSAGE</state>"
    if [ -n $STATEMONTITORSERVER ]; then
        local RESULT=`echo "$STATEBLOB" \
        | curl -s -i -H 'Content-Type: text/xml' -H 'Accept: application/json' -d@- \
          $STATEMONTITORSERVER/states/$ENTITY?preservedStates=Stopped&preservedStates=Restarted`
#        debug "$ENTITY" "$RESULT"
        local RETURNCODE
        echo "$RESULT" | grep '"stateName":"\(Stopped\|Restarted\)"'
        RETURNCODE="$?"
        if [ "$RETURNCODE" -eq 0 ]; then
            exit 127
        fi


    fi
    return 0
}



function execute() {
    local WORKINGDIR="$1"
    local CMD="$2"
    local NAME="$3"
    local ENTITY="$4"

    if [ -n "$ENTITY" ]; then
        report "$NAME" "Started" "$ENTITY" "$CMD"
        debug "$ENTITY" "$NAME started:  $CMD"
    fi
    pushd "$WORKINGDIR" > /dev/null

    local tempfile="`mktemp`"
    local OUTPUT
    local RETURNCODE
    OUTPUT="`$CMD 2> $tempfile`"
    RETURNCODE="$?"

    popd > /dev/null

    local MESSAGE=""
    MESSAGE="std out: \n '$OUTPUT' \n std err: \n '"`cat "$tempfile"`"'"
    rm "$tempfile"
    echo "$OUTPUT"

    if [ -n "$ENTITY" ]; then
        if [ "$RETURNCODE" -eq "0" ]; then
            debug "$ENTITY" "$NAME succeeded for $ENTITY: \n $MESSAGE"
            report "$NAME" "Completed" "$ENTITY" "`echo "$OUTPUT"| head -q -n10`"
        else
            error "$ENTITY" "$NAME failed for $ENTITY: \n $MESSAGE"
            report "$NAME" "Failed" "$ENTITY" "$OUTPUT" "$MESSAGE"
        fi
    fi
    return "$RETURNCODE"
}