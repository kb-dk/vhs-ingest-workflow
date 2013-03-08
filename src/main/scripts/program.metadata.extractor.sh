#!/bin/bash

PID="$1"
DATASTREAM="PROGRAM_BROADCAST"
DOMSUSER="$2"
DOMSPASS="$3"

#Get the doms ingesters properties
source "$VHSINGEST_WORKFLOW_CONFIG/combinedProperties.sh"

CONFIGNAME="${doms.ingester.vhsclip}"
CONFIGNAME="${CONFIGNAME//[\- _]/}"
CONFIGNAME=$(echo $CONFIGNAME | tr '[A-Z]' '[a-z]')
CONFIGNAME="${CONFIGNAME}Config"
DOMS_CONFIG="${!CONFIGNAME}"

# it is assumed that fedorawebserviceurl is of the form:
# http://localhost:7880/centralWebservice-service/central/?wsdl
DOMSURL=$(cat "$DOMS_CONFIG" | grep "dk.statsbiblioteket.doms.fedorawebserviceurl"  | cut -d'=' -f2 | cut -d'/' -f1,2,3,4)
DOMSURL="${DOMSURL}/rest/objects/${PID}/datastreams/${DATASTREAM}"

curl --user "$DOMSUSER:$DOMSPASS" "$DOMSURL"
