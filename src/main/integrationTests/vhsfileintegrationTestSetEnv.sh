#!/usr/bin/env bash
source "$(dirname $(readlink -f $BASH_SOURCE[0]))/commonEnv.sh"
export VHSINGEST_WORKFLOW_CONFIG="${vhsfile.workflow.config}"
