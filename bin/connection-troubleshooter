#!/bin/bash
set -e

HOST="${1:-www.google.com.br}"
echo "Diangosing connection using $HOST"

echo "Detecting your connection ..."
_FILE=/tmp/ipinfo.io.json
curl -s ipinfo.io > $_FILE
IP="$(      jq -r .ip $_FILE )"
COUNTRY="$( jq -r .country $_FILE )"
ISP="$(     jq -r .org $_FILE )"
echo "Testing from $IP ($COUNTRY), provided by $ISP"
echo

S=0
F=0
C=0
CHECKED=""

results() { echo -e "\n\n$C attempts, $S succeeded, $F failed.\n\n" ; }
trap results EXIT 

while true ; do
	let C=C+1
	DST="$(dig @8.8.8.8 +short www.google.com.br | grep -v ';')"
	echo -n "- Trying '$DST'... "

	if ! curl -s -o /dev/null --max-time 30 -w "%{http_code} " $DST ; then
		echo "Fail"
		let F=F+1
	else
		echo "Success"
		let S=S+1
	fi
	
	sleep 1.3
	if [ $C -gt 10 ] ; then
		exit 0
	fi
done

