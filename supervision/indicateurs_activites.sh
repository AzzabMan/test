#!/bin/bash

. /DB_CONF.profile

sqlplus -s /nolog >/dev/null << FIN
connect ${gUtilBD}/${gMdpBD}@${gConnBD}
spool indicateurs;
SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED;
SET HEADING OFF
SET FEEDBACK OFF
SET VERIFY OFF
set timing off

select count(*) from table where emetteur = 'test';

spool off;
exit sql.sqlcode
FIN

DATE=`date "+%Y-%m-%d"`
sed '/^$/d' indicateurs.lst > indicateurs_nobr
rm indicateurs.lst
sed -e "s/^ *//g" indicateurs_nobr > indicateurs_$DATE
rm indicateurs_nobr