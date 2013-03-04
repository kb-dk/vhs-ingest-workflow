#!/bin/bash

cd $(dirname $(readlink -f $0))

source $VHSINGEST_WORKFLOW_CONFIG/combinedProperties.sh
source $VHSINGEST_WORKFLOW_CONFIG/statemonitorClientConfig.sh
source $VHSINGEST_WORKFLOW_CONFIG/componentLoggingConfig.sh

source loggingEntity.sh
source common.sh

mkdir -p $LOGDIR

CONFIGNAME="$NAME"
CONFIGNAME="${CONFIGNAME//[\- _]/}"
CONFIGNAME=`echo $CONFIGNAME | tr '[A-Z]' '[a-z]'`
CONFIGNAME="${CONFIGNAME}Config"
CONFIGFILE="${!CONFIGNAME}"

