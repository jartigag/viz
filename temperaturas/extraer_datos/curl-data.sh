#!/bin/sh

# - required: sudo apt install jq
#
# - if this error:
#   "curl: (35) error:141A318A:SSL routines:tls_process_ske_dhe:dh key too small"
#   comment this line: "CipherString = DEFAULT@SECLEVEL=2"
#   on /etc/ssl/openssl.cnf

while read line; do

capital=`echo $line | awk -F"," '{print $1}'`
estacion=`echo $line | awk -F"," '{print $2}'`

url=`curl -sXGET --header 'Accept: application/json' \
    --header 'api_key: eyJhbGciOiJIUzI1...jPxYtwQMtDM' \
    https://opendata.aemet.es/opendata/api/valores/climatologicos/valoresextremos/parametro/T/estacion/$estacion | jq .datos`

curl -sXGET --header 'Accept: application/json' \
    --header 'api_key: eyJhbGciOiJIUzI1...jPxYtwQMtDM' \
    `echo $url | tr -d '"'` > aemet-valoresclimatologicos-extremosregistrados/$capital.json

done < capital-estacion.csv
