#!/bin/bash

HOST=$1
MESSAGE=$2

if [ -z "$HOST" ];
then
  HOST='localhost:8080'
fi

if [ -z "$MESSAGE" ];
then
  MESSAGE='{"message":"Hello Worlds"}'
fi

CREATE_OUTPUT=$(curl -s --location --request POST "http://$HOST/ga4gh/wes/v1/runs" \
    --form 'workflow_url="example.cwl"' \
    --form 'workflow_type=cwl' \
    --form 'workflow_type_version=v1.0' \
    --form workflow_params="$MESSAGE" \
    --form 'workflow_attachment=@"./example.cwl"')

RUN_ID=$(echo $CREATE_OUTPUT | jq '.run_id' -r)

if [ "$RUN_ID" == "null" ];
then
  echo; echo "ERROR: null ID returned, exiting"
  echo $CREATE_OUTPUT | jq .
  exit 1
fi

OUTPUT=$(curl -s "http://$HOST/ga4gh/wes/v1/runs/$RUN_ID")

END_TIME=$(echo $OUTPUT | jq '.run_log.end_time')

while [ $END_TIME == "null" ];
do
  sleep 1
  OUTPUT=$(curl -s "http://$HOST/ga4gh/wes/v1/runs/$RUN_ID")
  STATUS=$(echo $OUTPUT | jq '.state')
  echo "Status $(date +%Y.%m.%d-%H:%M.%s): $STATUS"
  END_TIME=$(echo $OUTPUT | jq '.run_log.end_time')
done

echo $OUTPUT | jq .
