#!/bin/bash

curl -i -k -X POST -H "Content-Type: application/oracle-compute-v3+json" -d '{"user":"/Compute-a484905/sorin.miroiu@logika.ro","password":"ZXCasdqwe123"}' https://api-z41.compute.em3.oraclecloud.com/authenticate/ |grep ^Set-Cookie > setenv_{{ current_timestamp }}.sh
sed -i -e "s/Set-Cookie: /export AUTH_COOKIE='/g" setenv_{{ current_timestamp }}.sh
sed -i "s|$|' |" setenv_{{ current_timestamp }}.sh
chmod +x setenv_{{ current_timestamp }}.sh
. setenv_{{ current_timestamp }}.sh

curl -k -i -X POST -H "Cookie: $AUTH_COOKIE" -H "Content-Type: application/oracle-compute-v3+json" -H "Accept: application/oracle-compute-v3+json" -d "@orch_template_{{ current_timestamp }}.json" https://api-z41.compute.em3.oraclecloud.com/orchestration/Compute-a484905/ >> create_orch.log

#curl -k -i -X PUT -H "Cookie: $AUTH_COOKIE" -H "Content-Type: application/oracle-compute-v3+json" https://172.31.67.10/orchestration/OCM-Adm01P/public/{{ orch_name }}?action=START >> create_orch.log

rm -rf setenv_{{ current_timestamp }}.sh
