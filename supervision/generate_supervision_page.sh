#!/bin/sh

if [ -z "$1" ]
then
	echo "missing argument" >&2
	exit 1
fi
if [ ! -e "$1" ]
then
	echo "$1 does not exist" >&2
	exit 1
fi

SCRIPT_DIR=`dirname $0`
STATUS_INTERCO=`$SCRIPT_DIR/check_interconnection.sh | grep Statut | sed 's#.\[00m#</span><BR/>#g' | sed 's#.\[00;32m#<span style="color:green;">#g' | sed 's#.\[00;31m#<span style="color:red;">#g'`

echo "<html><head></head><body>" > $1
echo "Last check: `date '+%H:%M:%S %d/%m/%Y'`<br/>" >$1
echo -e "$STATUS_INTERCO" >> $1
echo "</body></html>" >> $1
