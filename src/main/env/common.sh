#!/bin/bash


STATE_FAILED="Failed"
STATE_COMPLETED="Completed"
STATE_STARTED="Started"
STATE_DONE="Done"
STATE_STOPPED="Stopped"
STATE_RESTARTED="Restarted"
STATE_QUEUED="Queued"


function reportWorkflowCompleted(){
    local ENTITY="$1"
    shift
    local MESSAGE="$*"

    if [ -n "$MESSAGE" ]; then
        MESSAGE="${MESSAGE:0:254}"/
        MESSAGE=`echo -e "<message><![CDATA[""$MESSAGE""]]></message>"`
    else
        MESSAGE=""
    fi

    local STATE="<stateName>$STATE_DONE</stateName>"
    local COMPONENT="<component>${workflow.name}</component>"
    local STATEBLOB="<state>$COMPONENT$STATE$MESSAGE</state>"

    local RESULT
    local RETURNCODE

    RESULT=`echo "$STATEBLOB" \
       | curl -s -i -H 'Content-Type: text/xml' -H 'Accept: application/json' -d@- \
          "$STATEMONTITORSERVER/states/$ENTITY"`
    RETURNCODE="$?"
    if [ "$RETURNCODE" -ne 0 ]; then
        error "$ENTITY" "Failed to communicate with state monitor" "$RESULT"
        exit $RETURNCODE
    fi

    return 0

}

#Mainly because when we start, we should overwrite restarted states.
function reportWorkflowStarted(){
    local ENTITY="$1"

    local STATEBLOB="<state><component>${workflow.name}</component><stateName>$STATE_STARTED</stateName></state>"

    local RESULT
    local RETURNCODE

    RESULT=`echo "$STATEBLOB" \
       | curl -s -i -H 'Content-Type: text/xml' -H 'Accept: application/json' -d@- \
          "$STATEMONTITORSERVER/states/$ENTITY"`
    RETURNCODE="$?"
    if [ "$RETURNCODE" -ne 0 ]; then
        error "$ENTITY" "Failed to communicate with state monitor" "$RESULT"
        exit $RETURNCODE
    fi

    return 0
}


function report(){
    local COMPONENT="$1"
    shift
    local STATE="$1"
    shift
    local ENTITY="$1"
    shift
    local MESSAGE="$*"

    if [ -n "$MESSAGE" ]; then
        MESSAGE="${MESSAGE:0:254}"/
        MESSAGE=`echo -e "<message><![CDATA[""$MESSAGE""]]></message>"`
    else
        MESSAGE=""
    fi
    local STATE="<stateName>$STATE</stateName>"
    local COMPONENT="<component>$COMPONENT</component>"
    local STATEBLOB="<state>$COMPONENT$STATE$MESSAGE</state>"

    local RESULT
    local RETURNCODE

    local PRESERVEDSTATES="preservedStates=$STATE_STOPPED&preservedStates=$STATE_RESTARTED&preservedStates=$STATE_FAILED"


    if [ -n "$STATEMONTITORSERVER" ]; then
        local RESULT=`echo "$STATEBLOB" \
               | curl -s -i -H 'Content-Type: text/xml' -H 'Accept: application/json' -d@- \
                  "$STATEMONTITORSERVER/states/$ENTITY?$PRESERVEDSTATES"`
#        debug "$ENTITY" "$RESULT"
        RETURNCODE="$?"
        echo "$RESULT" | grep '"stateName":"\(Stopped\|Restarted\)"'
        if [ "$RETURNCODE" -ne 0 ]; then
            error "$ENTITY" "Failed to communicate with state monitor" "$RESULT"
            exit $RETURNCODE
        fi
        echo "$RESULT" | grep "\"stateName\":\"\($STATE_STOPPED\|$STATE_RESTARTED\|$STATE_FAILED\)\""
        RETURNCODE="$?"
        if [ "$RETURNCODE" -eq 0 ]; then
            warn "$ENTITY" "Stopped processing due to file having been marked as $STATE_STOPPED, $STATE_RESTARTED or $STATE_FAILED"
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
    chmod +r "$tempfile"
    local OUTPUT
    local RETURNCODE
    #local TIMEBEFORE=$(date +%s)
    OUTPUT=$($CMD 2> "$tempfile")
    RETURNCODE="$?"
    #local TIMEAFTER=$(date +%s)

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
