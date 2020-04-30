#!/bin/bash

# Rippled Service Node

service_url="http://s1.ripple.com:51234"

runtime="5 minute"
endtime=$(date -ud "$runtime" +%s)

while [[  $(date -u +%s) -le $endtime ]]
do

echo "Time Now: `date +%H:%M:%S`"


# Change to working directory

cd /home/ripple/ripple_TechC/getServerinfo_addToCSV

# Time Stamp

#dt=$(date "+%Y%m%d%H%M")

# JSON-RPC request using cURL - Rippled server_info API

curl -o server_info.json -s \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"method":"server_info","params":[{}]}' \
  $service_url

# Filter JSON outputs

#jq .  server_info.json >  server_info_$dt.json

resp_seq=$(jq .result.info.validated_ledger.seq server_info.json)
resp_time=$(jq .result.info.time server_info.json)

# Write to CSV file

echo "$resp_time;$resp_seq" >> server_info_list.csv

echo " Pause for 10 seconds"

sleep 10

done

