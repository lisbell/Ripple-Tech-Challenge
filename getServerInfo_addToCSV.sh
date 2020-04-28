# Notes:
# We can send the equivalent of a JSON-RPC request to the XRP node using cURL, 
# whilst at the same time capturing the output from server_info and writing to a JSON file. 
# Incorporating JQ commands into the script we can date and timestamp each server_info response 
# and filter for the desired content from within the JSON file, capturing and outputting this 
# data to a CSV file.


#!/bin/bash

# Rippled Service Node
service_url="http://s1.ripple.com:51234"

cd /root/ripple

# Date and Timestamp
dt=$(date "+%Y%m%d%H%M")

# JSON-RPC request using cURL - capturing output to a file
curl -o server_info.json -s \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"method":"server_info","params":[{}]}' \
  $service_url

#Append timestamp to file 
jq .  server_info.json >  server_info_$dt.json

# Filter JSON outputs
resp_seq=$(jq .result.info.validated_ledger.seq server_info.json)
resp_time=$(jq .result.info.time server_info.json)

# Write outputs to CSV file
echo "$resp_time;$resp_seq" >> server_info_hist.csv
