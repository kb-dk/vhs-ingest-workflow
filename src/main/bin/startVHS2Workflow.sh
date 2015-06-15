#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

print_usage()
{
echo "Usage: $(basename $0) --vhsfile <vhsfile> --jsonfile <jsonfile>"
echo
echo "--vhsfile relative or absolute path to the digitised VHS video file to be ingested"
echo "--jsonfile relative or absolute path to the JSON metadata file corresponding to the VHS video file to be ingested"
echo
}

ARGS=$(getopt -o "" -l "jsonfile:,vhsfile:" -- "$@" );

if [ $? -ne 0 ];
then
  print_usage
  exit 1
fi


eval set -- "$ARGS";

while true; do
  case "$1" in
    --vhsfile)
      shift;
      VHSFILE="$1"
      shift;
      ;;
    --jsonfile)
      shift;
      JSONFILE="$1"
      shift;
      ;;
      --)
      shift;
      shift;
      break;
      ;;
       *)
      echo "Unknown parameter $1" > /dev/stderr
      print_usage
      exit 1;
      ;;
  esac
done

# Check that we got the args we wanted
[ -z "$VHSFILE" ] && print_usage && exit 2
[ -z "$JSONFILE" ] && print_usage && exit 2

cd $SCRIPT_PATH
source setup.infrastructure.sh
source setup.env.sh
export VHSINGEST_WORKFLOW_CONFIG="$VHSINGEST_CONFIG/vhsfileingestworkflow/"


VERSION=`head -1 $TAVERNA_HOME/release-notes.txt | sed 's/.$//' | cut -d' ' -f4`
LIB="$HOME/.taverna-$VERSION/lib/"
mkdir -p $LIB
mkdir -p $VHSINGEST_LOGS
mkdir -p $VHSINGEST_LOCKS
echo $JAVA_HOME
cd "$VHSINGEST_LOGS"


flock $VHSINGEST_LOCKS/vhsfile.lock $TAVERNA_HOME/executeworkflow.sh -inmemory "-inputvalue" "vhsfile" "$VHSFILE" \
"-inputvalue" "jsonfile" "$JSONFILE" \
"-inputvalue" "domsUser" "$DOMSUSER" \
"-inputvalue" "domsPass" "$DOMSPASS" \
"$VHSINGEST_WORKFLOWS/vhs2fileingest.t2flow"

exit 0
