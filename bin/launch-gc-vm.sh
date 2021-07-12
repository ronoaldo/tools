#!/bin/bash

# Script setup
set -e
if [ "$DEBUG" ] ; then set -x ; fi

# Globals
export PROJ="$1" ZONE="$2" VM="$3"
export YAML=$(mktemp /tmp/launch-gc-vm-XXXXXX.yaml)

# Tear down
trap "rm $YAML" KILL EXIT

# Helpers
log() { echo "[launch-gc-vm] $@" ; }
die() { log "$@" ; exit 1 ; }
gcloud="gcloud --project=$PROJ"


#
# Main
#
log "Launching instance $PROJ/$ZONE/$VM ..."

export status="$($gcloud compute instances describe --zone=$ZONE --format="value(status)" $VM)"
log "$PROJ/$ZONE/$VM: $status"

if [ "$status" != "RUNNING" ]; then
    log "Instance not running yet, starting ..."
    $gcloud compute instances start --zone=$ZONE $VM || true
fi

log "Checking if startup finished..."
count=0
next=0
$gcloud compute instances get-serial-port-output --zone=$ZONE $VM --format=yaml > $YAML
while true ; do
	if grep "Startup finished in.*" $YAML ; then
		log "Startup completion detected"
		break
	fi
	next="$(grep next $YAML | cut -f 2 -d"'")"
	$gcloud compute instances get-serial-port-output --start=$next --zone=$ZONE $VM --format=yaml > $YAML

	count=$(( count + 1 ))
	if [ $count -gt 30 ] ; then
		die "Timed out after $count attempts"
	fi
	log "Waiting for instance boot sequence to complete... (Reading from $next)"
	sleep 1
done
log "Instance startup finished"
