#!/usr/bin/env bash
#
# This file should not normally require modification
#

export VHSINGEST_LOGS="$VHSINGEST_HOME/logs"
export VHSINGEST_LOCKS="$VHSINGEST_HOME/locks"
export VHSINGEST_COMPONENTS="$VHSINGEST_HOME/components"
export VHSINGEST_SCRIPTS="$VHSINGEST_HOME/scripts"
export VHSINGEST_WORKFLOWS="$VHSINGEST_HOME/taverna"
export VHSINGEST_DEPENDENCIES="$VHSINGEST_HOME/workflowDependencies"
export VHSINGEST_BIN="$VHSINGEST_HOME/bin"
export CONF=$VHSINGEST_CONFIG/startVHS2Workflow.conf
if [ ! -f "$CONF" ]
then
  echo "Did not find config file with DOMS credentials $CONF"
  exit 3
fi
source $CONF
