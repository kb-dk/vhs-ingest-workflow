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

source $SCRIPT_PATH/setIngestVHSFileEnv.sh
CONF=$VHSINGEST_CONFIG/startVHS2Workflow.conf
[ -f "$CONF" ] && "Did not find config file with DOMS credentials $CONF" && exit 3
source $CONF

$SCRIPT_PATH/ingestVHS2File.sh "-inputvalue" "vhsfile" "$VHSFILE" \
"-inputvalue" "jsonfile" "$JSONFILE" \
"-inputvalue" "domsUser" "$DOMSUSER" \
"-inputvalue" "domsPass" "$DOMSPASS"
