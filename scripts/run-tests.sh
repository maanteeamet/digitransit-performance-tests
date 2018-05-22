#!/bin/bash

set -e

#how often tests are run (default once a day)
TEST_INTERVAL=${TEST_INTERVAL:-1}
#Substract one day, because first wait hours are computed before each run
TEST_INTERVAL_SECONDS=$((($TEST_INTERVAL - 1)*24*3600))
#start tests at this time (GMT):
TEST_TIME=${TEST_TIME:-04:00:00}
#Parse URL file names and headers into bash array
IFS=',' read -r -a FILES_AND_HEADERS <<< $FILES_AND_HEADERS
#How many concurrent users siege mimics
CONCURRENT_USERS=${CONCURRENT_USERS:-10}
#How long siege run lasts
SIEGE_TIME=${SIEGE_TIME:-60s}

#Set working directory to be directory of the test files
cd "$(dirname "$0")"/../test_files

set +e

# run test loop forever, unless test interval is set to zero
while true; do
    if [[ "$TEST_INTERVAL" -gt 0 ]]; then
        SLEEP=$(($(date -u -d $TEST_TIME +%s) - $(date -u +%s) + 1))
        if [[ "$SLEEP" -le 0 ]]; then
            #today's test time is gone, start counting from tomorrow
            SLEEP=$(($SLEEP + 24*3600))
        fi
        SLEEP=$(($SLEEP + $TEST_INTERVAL_SECONDS))

        echo "Sleeping $SLEEP seconds until the test run ..."
        sleep $SLEEP
    fi

    for FILE_AND_HEADERS in "${FILES_AND_HEADERS[@]}"
    do
        FILE=`echo $FILE_AND_HEADERS | head -n1 | awk '{print $1;}'`
        if [ -v SLACK_WEBHOOK_URL ]; then
            curl -X POST -d \
                "{\"channel\": \"performance-tests\", \"text\": \"Testing file: $FILE \n\"""}" \
                $SLACK_WEBHOOK_URL
            # By default, uses 10 concurrent users every second for 60 seconds
            siege -c$CONCURRENT_USERS -d1 -t$SIEGE_TIME -i -f \
                `echo "$FILE_AND_HEADERS" | sed "s/'//g"` 2>&1 | \
                jq -R -s '{channel: "performance-tests", text: .}' | \
                curl -X POST -H 'Content-type: application/json'  -d@- \
                $SLACK_WEBHOOK_URL
        fi
    done


    if [[ "$TEST_INTERVAL" -le 0 ]]; then
        #run only once
        exit 0
    fi
done
