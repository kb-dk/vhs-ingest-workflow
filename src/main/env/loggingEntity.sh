#!/bin/bash

# Version 0.1.1 of the SB shell script logging framework.
#Fixed if [ -z "${*:3}" ]; then
#
# It is supposed to be sourced into you code
# It expects these variables to be set
# logFile The file to log to
# verbosity=2 The loglevel
# LOCKFILE The file to ensure that different invocations do not race the log


silent_lvl=0
err_lvl=1
wrn_lvl=2
inf_lvl=3
dbg_lvl=4

notify() {
 local logfile="$1"
 shift
 local message="${@}"
 log "$logfile" $silent_lvl "NOTE: $message";
} # Always prints

error() {
  local logfile="$1"
 shift
 local message="${@}"
 log "$logfile" $err_lvl "ERROR: $message" ; }

warn() {
  local logfile="$1"
 shift
 local message="${@}"
 log "$logfile" $wrn_lvl "WARNING: $message"; }

inf() {
  local logfile="$1"
 shift
 local message="${@}"
 log "$logfile" $inf_lvl "INFO: $message"; } # "info" is already a command

debug() {
  local logfile="$1"
 shift
 local message="${@}"
 log "$logfile" $dbg_lvl "DEBUG: $message"; }

log() {
    local logfile="$1"
    shift
    local loglevel="$1"
    shift
    local message="$*"

	if [ -z "$logfile" ]; then
		return
	fi
	lockfile "$LOCKFILE"
        if [ $verbosity -ge $loglevel ]; then
            # Expand escaped characters
            echo -e "`date +'%b %d %H:%M:%S'`" "`hostname`" "`basename $0`[$$]" "$message" | sed '2~1s/^/  /' >> "$LOGDIR/$logfile.log"
        fi
	rm -f "$LOCKFILE"

}
