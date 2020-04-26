#!/bin/bash

service_url="http://s1.ripple.com:51234"

cd /root/ripple

dt=$(date "+%Y%m%d%H%M")

curl -o server_info.json -s \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"method":"server_info","params":[{}]}' \
  $service_url

jq .  server_info.json >  server_info_$dt.json

resp_seq=$(jq .result.info.validated_ledger.seq server_info.json)
resp_time=$(jq .result.info.time server_info.json)

echo "$resp_time;$resp_seq" >> server_info_hist.csv
