#!/bin/sh

TOTO1_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO1 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
TOTO1_PORT=`cat ~/.lftp/bookmarks | grep TOTO1 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
TOTO1_PORT=${TOTO1_PORT%/}
TOTO2_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO2 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
TOTO2_PORT=`cat ~/.lftp/bookmarks | grep TOTO2 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
TOTO2_PORT=${TOTO2_PORT%/}
TOTO2_WS_HOSTNAME=`cat /etc/hosts | grep echg-part.TOTO5.local | awk -F " " '{ print $1 }'`
TOTO4_SFTP_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO4 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
TOTO4_SFTP_PORT=`cat ~/.lftp/bookmarks | grep TOTO4 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
TOTO4_SFTP_PORT=${TOTO4_SFTP_PORT%/}
TOTO4_WS_HOSTNAME=`cat /etc/hosts | grep tcs.TOTO6.etshtfe.com | awk -F " " '{ print $1 }'`
TOTO4_WS_PORT=443
TOTO3_SFTP_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO3 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
TOTO3_SFTP_PORT=`cat ~/.lftp/bookmarks | grep TOTO3 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
TOTO3_SFTP_PORT=${TOTO4_SFTP_PORT%/}
REQUEST_D2S=/appli/$USER/check_flux/reqD2S.txt
REQUEST_DVS=/appli/$USER/check_flux/reqDVS.txt
KO="\e[00;31mDOWN\e[00m"
OK="\e[00;32mUP\e[00m"

if [[ "$TAXE_ENVIR" == "int" ]]
then
	HOSTNAME="int.TITI.TOTO6.fr"
        TOTO1_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO1 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
        TOTO1_PORT=`cat ~/.lftp/bookmarks | grep TOTO1 | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
        TOTO1_PORT=${TOTO1_PORT%/}
        TOTO2_WS_HOSTNAME=`cat /etc/hosts | grep echg-part.int.TOTO5.local | awk -F " " '{ print $1 }'`
        TOTO4_WS_HOSTNAME=`cat /etc/hosts | grep SSL_proxy_TOTO6_psht | awk -F " " '{ print $1 }'`
elif [[ "$TAXE_ENVIR" == "rec" ]]
then
        HOSTNAME="rec.TITI.TOTO6.fr"
        TOTO1_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO1_ppd | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
        TOTO1_PORT=`cat ~/.lftp/bookmarks | grep TOTO1_ppd | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
        TOTO1_PORT=${TOTO1_PORT%/}
        TOTO2_WS_HOSTNAME=`cat /etc/hosts | grep echg-part.int.TOTO5.local | awk -F " " '{ print $1 }'`
        TOTO4_WS_HOSTNAME=`cat /etc/hosts | grep SSL_proxy_TOTO6_psht | awk -F " " '{ print $1 }'`
elif [[ "$TAXE_ENVIR" == "rec2" ]]
then
        HOSTNAME="rec2.TITI.TOTO6.fr"
        TOTO1_HOSTNAME=`cat ~/.lftp/bookmarks | grep TOTO1_ppd | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $1 }'`
        TOTO1_PORT=`cat ~/.lftp/bookmarks | grep TOTO1_ppd | awk -F "@" '{ print $2 }' | awk -F ":" '{ print $2 }'`
        TOTO1_PORT=${TOTO1_PORT%/}
        TOTO2_WS_HOSTNAME=`cat /etc/hosts | grep echg-part.int.TOTO5.local | awk -F " " '{ print $1 }'`
        TOTO4_WS_HOSTNAME=`cat /etc/hosts | grep SSL_proxy_TOTO6_psht | awk -F " " '{ print $1 }'`
        REQUEST_D2S=/appli/cft/$USER/check_flux/reqD2S.txt
        REQUEST_DVS=/appli/cft/$USER/check_flux/reqDVS.txt
elif [[ "$TAXE_ENVIR" == "ppr" ]]
then
        HOSTNAME="preprod.TITI.TOTO6.fr"
        TOTO2_WS_HOSTNAME=`cat /etc/hosts | grep echg-part.preprod.TOTO5.local | awk -F " " '{ print $1 }'`
        TOTO4_WS_HOSTNAME=`cat /etc/hosts | grep tcs.TOTO6.preprod.etshtfe.com | awk -F " " '{ print $1 }'`
elif [[ "$TAXE_ENVIR" == "prd" ]]
then
        HOSTNAME="apache-TITI-prd"
fi
echo "--------------------------------------------";
echo "-- Verification de l'etat de dispo du TITI --";
echo "--------------------------------------------";
echo "";

echo "o Verification de la disponibilite apache...";
RESULT_APACHE=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/"`
if [[ "$RESULT_APACHE" == *200* ]]
then
        STATUT_APACHE=$OK;
else
        STATUT_APACHE=$KO;
fi
echo -e "Statut apache HTTP : ....... $STATUT_APACHE";
echo "";

RESULT_APACHE=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "https://${HOSTNAME}/"`
if [[ "$RESULT_APACHE" == *200* ]]
then
        STATUT_APACHE=$OK;
else
        STATUT_APACHE=$KO;
fi
echo -e "Statut apache HTTPS : ....... $STATUT_APACHE";
echo "";

echo "o Verification de la disponibilite JBOSS...";
RESULT_JBOSS=`curl -o /dev/null --silent -k --write-out '%{http_code}\n' "https://${HOSTNAME}/taxe_TITI_OBUManagement_Callback/OBUManagementCallback?wsdl"`
if [[ "$RESULT_JBOSS" == *200* ]]
then
        STATUT_JBOSS=$OK;
else
        STATUT_JBOSS=$KO;
fi
echo -e "Statut JBOSS : ....... $STATUT_JBOSS";
echo "";




echo "--------------------------------------------";
echo "--  Verification des interconnexions TITI  --";
echo "--------------------------------------------";
echo "";

echo "o Verification Flux SFTP TOTO1 ...";

TELNET=`echo "quit" | telnet $TOTO1_HOSTNAME $TOTO1_PORT 2>/dev/null | grep "Escape character is"`
if [ "$?" -ne 0 ]
then
        STATUT_FLUX_SFTP_TOTO1=$KO;
else
        STATUT_FLUX_SFTP_TOTO1=$OK;
fi

echo -e "Statut Flux SFTP TOTO1 : ........ $STATUT_FLUX_SFTP_TOTO1";
echo "";
echo "o Verification SFTP TOTO1 ...";

RESULT_TOTO1=`lftp -c "set net:timeout 1;set net:max-retries 1;connect TOTO1; ls " 2>/dev/null`

if [[ "$RESULT_TOTO1" == *TITI* ]]
then
        STATUT_TOTO1=$OK;
else
        STATUT_TOTO1=$KO;
fi

echo -e "Statut SFTP TOTO1 : ........ $STATUT_TOTO1";
echo "";
echo "o Verification Flux SFTP TOTO2 ...";

TELNET=`echo "quit" | telnet $TOTO2_HOSTNAME $TOTO2_PORT 2>/dev/null | grep "Escape character is"`
if [ "$?" -ne 0 ]
then
        STATUT_FLUX_SFTP_TOTO2=$KO;
else
        STATUT_FLUX_SFTP_TOTO2=$OK;
fi

echo -e "Statut Flux SFTP TOTO2 : ........ $STATUT_FLUX_SFTP_TOTO2";
echo "";
echo "o Verification SFTP TOTO2 ...";

RESULT_TOTO2=`lftp -c "set net:timeout 1;set net:max-retries 1;connect TOTO2; ls " 2>/dev/null`

if [[ "$RESULT_TOTO2" == *SHT000010* ]]
then
        STATUT_TOTO2=$OK;
else
        STATUT_TOTO2=$KO;
fi

echo -e "Statut SFTP TOTO2 : ............. $STATUT_TOTO2";
echo "";
echo "o Verification Flux WS TOTO2 018_026 ...";

TELNET=`echo "quit" | telnet $TOTO2_WS_HOSTNAME 19500 2>/dev/null | grep "Escape character is"`

if [ "$?" -ne 0 ]
then
        STATUT_FLUX_WS_TOTO2_018_026=$KO;
else
        STATUT_FLUX_WS_TOTO2_018_026=$OK;
fi

echo -e "Statut Flux WS TOTO2 018_026 : ......... $STATUT_FLUX_WS_TOTO2_018_026";
echo "";
echo "o Verification WS TOTO2 018_026 ...";

RESULT_TOTO2_WS26=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/018_026/XIAxisAdapter/MessageServlet"`

if [[ "$RESULT_TOTO2_WS26" == *200* ]]
then
        STATUT_TOTO2_WS26=$OK;
else
        STATUT_TOTO2_WS26=$KO;
fi

echo -e "Statut WS TOTO2 018_026 : ....... $STATUT_TOTO2_WS26";
echo "";
echo "o Verification Flux WS TOTO2 018_028 ...";

TELNET=`echo "quit" | telnet $TOTO2_WS_HOSTNAME 19501 2>/dev/null | grep "Escape character is"`
if [ "$?" -ne 0 ]
then
        STATUT_FLUX_WS_TOTO2_018_028=$KO;
else
        STATUT_FLUX_WS_TOTO2_018_028=$OK;
fi

echo -e "Statut Flux WS TOTO2 018_028 : ......... $STATUT_FLUX_WS_TOTO2_018_028";
echo "";
echo "o Verification WS TOTO2 018_028 ...";

RESULT_TOTO2_WS28=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/018_028/XIAxisAdapter/MessageServlet"`

if [[ "$RESULT_TOTO2_WS28" == *200* ]]
then
        STATUT_TOTO2_WS28=$OK;
else
        STATUT_TOTO2_WS28=$KO;
fi

echo -e "Statut WS TOTO2 018_028 : ....... $STATUT_TOTO2_WS28";
echo "";
echo "o Verification Flux WS TOTO2 018_046 ...";

TELNET=`echo "quit" | telnet $TOTO2_WS_HOSTNAME 19502 2>/dev/null | grep "Escape character is"`

if [ "$?" -ne 0 ]
then
        STATUT_FLUX_WS_TOTO2_018_046=$KO;
else
        STATUT_FLUX_WS_TOTO2_018_046=$OK;
fi

echo -e "Statut Flux WS TOTO2 018_046 : ......... $STATUT_FLUX_WS_TOTO2_018_046";
echo "";
echo "o Verification WS TOTO2 018_046 ...";

RESULT_TOTO2_WS46=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/018_046/XIAxisAdapter/MessageServlet"`

if [[ "$RESULT_TOTO2_WS46" == *200* ]]
then
        STATUT_TOTO2_WS46=$OK;
else
        STATUT_TOTO2_WS46=$KO;
fi
echo -e "Statut WS TOTO2 018_046 : ....... $STATUT_TOTO2_WS46";
echo "";
echo "o Verification Flux WS TOTO2 018_048 ...";

TELNET=`echo "quit" | telnet $TOTO2_WS_HOSTNAME 19503 2>/dev/null | grep "Escape character is"`

if [ "$?" -ne 0 ]
then
        STATUT_FLUX_WS_TOTO2_018_048=$KO;
else
        STATUT_FLUX_WS_TOTO2_018_048=$OK;
fi

echo -e "Statut Flux WS TOTO2 018_048 : ......... $STATUT_FLUX_WS_TOTO2_018_048";
echo "";
echo "o Verification WS TOTO2 018_048 ...";

RESULT_TOTO2_WS48=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/018_048/XIAxisAdapter/MessageServlet"`

if [[ "$RESULT_TOTO2_WS48" == *200* ]]
then
        STATUT_TOTO2_WS48=$OK;
else
        STATUT_TOTO2_WS48=$KO;
fi

echo -e "Statut WS TOTO2 018_048 : ....... $STATUT_TOTO2_WS48";
echo "";
echo "o Verification Flux WS TOTO2 018_050 ...";

TELNET=`echo "quit" | telnet $TOTO2_WS_HOSTNAME 19504 2>/dev/null | grep "Escape character is"`

if [ "$?" -ne 0 ]
then
        STATUT_FLUX_WS_TOTO2_018_050=$KO;
else
        STATUT_FLUX_WS_TOTO2_018_050=$OK;
fi

echo -e "Statut Flux WS TOTO2 018_050 : ......... $STATUT_FLUX_WS_TOTO2_018_050";
echo "";
echo "o Verification WS TOTO2 018_050 ...";

RESULT_TOTO2_WS50=`curl -d "" -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/018_050/XIAxisAdapter/MessageServlet"`

if [[ "$RESULT_TOTO2_WS50" == *200* ]]
then
        STATUT_TOTO2_WS50=$OK;
else
        STATUT_TOTO2_WS50=$KO;
fi

echo -e "Statut WS TOTO2 018_050 : ....... $STATUT_TOTO2_WS50";
echo "";
echo "o Verification Flux SFTP Proxy ...";

TELNET=`echo "quit" | telnet $TOTO4_SFTP_HOSTNAME $TOTO4_SFTP_PORT 2>/dev/null | grep "Escape character is"`
if [ "$?" -ne 0 ]
then
        STATUT_FLUX_FTPS_PROXY=$KO;
else
        STATUT_FLUX_FTPS_PROXY=$OK;
fi

echo -e "Statut Flux SFTP Proxy : ........ $STATUT_FLUX_FTPS_PROXY";
echo "";
echo "o Verification SFTP Proxy ...";

RESULT_PROXY=`lftp -c "set net:timeout 1;set net:max-retries 1;connect TOTO4; ls " 2>/dev/null`

if [[ "$RESULT_PROXY" == *Note* ]]
then
        STATUT_PROXY=$OK;
else
        STATUT_PROXY=$KO;
fi

echo -e "Statut SFTP Proxy : .............. $STATUT_PROXY";
echo "";
echo "o Verification Flux WS Proxy ...";

TELNET=`echo "quit" | telnet $TOTO4_WS_HOSTNAME $TOTO4_WS_PORT 2>/dev/null | grep "Escape character is"`
if [ "$?" -ne 0 ]
then
        STATUT_FLUX_WS_PROXY=$KO;
else
        STATUT_FLUX_WS_PROXY=$OK;
fi

echo -e "Statut Flux WS Proxy : ........ $STATUT_FLUX_WS_PROXY";
echo "";
echo "o Verification WS Proxy ...";

RESULT_PROXY_WS=`curl -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/proxy/cissht_server/OBUManagement?wsdl"`

if [[ "$RESULT_PROXY_WS" == *200* ]]
then
        STATUT_PROXY_WS=$OK;
else
        STATUT_PROXY_WS=$KO;
fi

echo -e "Statut WS Proxy : ................ $STATUT_PROXY_WS";
echo "";
echo "o Verification Flux SFTP TOTO3 ...";

TELNET=`echo "quit" | telnet $TOTO3_SFTP_HOSTNAME $TOTO3_SFTP_PORT 2>/dev/null | grep "Escape character is"`
if [ "$?" -ne 0 ]
then
        STATUT_FLUX_FTPS_TOTO3=$KO;
else
        STATUT_FLUX_FTPS_TOTO3=$OK;
fi

echo -e "Statut Flux SFTP TOTO3 : ........ $STATUT_FLUX_FTPS_TOTO3";
echo "";
echo "o Verification SFTP TOTO3 ...";

RESULT_TOTO3=`lftp -c "set net:timeout 1;set net:max-retries 1;connect TOTO3; pwd " 2>/dev/null`

if [ "$?" -ne 0 ]
then
        STATUT_TOTO3=$KO;
else
        STATUT_TOTO3=$OK;
fi

echo -e "Statut SFTP TOTO3 : .............. $STATUT_TOTO3";
echo "";
#echo "o Verification WS Auth Secret TOTO7 ...";
#
#RESULT_TOTO7_AUTH_SECRET_WS=`curl -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/TOTO7/d3s-taxe-authority/secure/v2_1/SecretPort?wsdl"`
#
#if [[ "$RESULT_TOTO7_AUTH_SECRET_WS" == *200* ]]
#then
#        STATUT_TOTO7_AUTH_SECRET_WS=$OK;
#else
#        STATUT_TOTO7_AUTH_SECRET_WS=$KO;
#fi
#
#echo -e "Statut WS Auth Secret TOTO7 : .......... $STATUT_TOTO7_AUTH_SECRET_WS";
#echo "";
#echo "o Verification WS Auth Deposit TOTO7 ...";
#
#RESULT_TOTO7_AUTH_DEPOSIT_WS=`curl -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/TOTO7/d3s-taxe-authority/secure/v2_1/DepositPort?wsdl"`
#
#if [[ "$RESULT_TOTO7_AUTH_DEPOSIT_WS" == *200* ]]
#then
#        STATUT_TOTO7_AUTH_DEPOSIT_WS=$OK;
#else
#        STATUT_TOTO7_AUTH_DEPOSIT_WS=$KO;
#fi
#
#echo -e "Statut WS Auth Deposit TOTO7 : .......... $STATUT_TOTO7_AUTH_DEPOSIT_WS";
#echo "";
#echo "o Verification WS Storage TOTO7 ...";
#
#RESULT_TOTO7_STORAGE_WS=`curl -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/TOTO7/d3s-taxe-storage/v2_1/secret?wsdl"`
#
#if [[ "$RESULT_TOTO7_STORAGE_WS" == *200* ]]
#then
#        STATUT_TOTO7_STORAGE_WS=$OK;
#else
#        STATUT_TOTO7_STORAGE_WS=$KO;
#fi
#
#echo -e "Statut WS Storage TOTO7 : ....... $STATUT_TOTO7_STORAGE_WS";
#echo "";
#echo "o Verification WS DVS TOTO7 ...";
#
#RESULT_TOTO7_DVS_WS=`curl -d @${REQUEST_DVS} -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/DVS/DVSInterface/DVSInterfaceSoap.cgi"`
#
#if [[ "$RESULT_TOTO7_DVS_WS" == *200* ]]
#then
#        STATUT_TOTO7_DVS_WS=$OK;
#else
#        STATUT_TOTO7_DVS_WS=$KO;
#fi
#
#echo -e "Statut WS DVS TOTO7 : .......... $STATUT_TOTO7_DVS_WS";
#echo "";
#echo "o Verification WS D2S TOTO7 ...";
#
#RESULT_TOTO7_D2S_WS=`curl -d @${REQUEST_D2S} -o /dev/null --silent -k --write-out '%{http_code}\n' "http://${HOSTNAME}/D2S/D2SInterface/D2SInterfaceSoap.cgi"`
#
#if [[ "$RESULT_TOTO7_D2S_WS" == *200* ]]
#then
#        STATUT_TOTO7_D2S_WS=$OK;
#else
#        STATUT_TOTO7_D2S_WS=$KO;
#fi
#
#echo -e "Statut WS D2S TOTO7 : ....... $STATUT_TOTO7_D2S_WS";
#echo "";

