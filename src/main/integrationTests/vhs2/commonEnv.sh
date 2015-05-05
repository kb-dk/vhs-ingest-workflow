#!/bin/sh
export TAVERNA_HOME="$HOME/taverna/taverna-workbench-2.4.0"
export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"
export VHSINGEST_HOME="$HOME/vhs-ingest-workflow/services/workflow"
export VHSINGEST_CONFIG="${install.config.dir}"
export VHSINGEST_LOGS="${install.home.dir}/${install.logs.dir}"
export VHSINGEST_LOCKS="${install.home.dir}/${install.locks.dir}"
export VHSINGEST_COMPONENTS="${install.home.dir}/${install.components.dir}"
export VHSINGEST_SCRIPTS="${install.home.dir}/${install.script.dir}"
export VHSINGEST_WORKFLOWS="${install.home.dir}/${workflow.dir}"
export VHSINGEST_DEPENDENCIES="${install.home.dir}/${workflow.dependencies.dir}"
export VHSINGEST_BIN="${install.home.dir}/${install.bin.dir}"