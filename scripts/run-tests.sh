#!/bin/bash

set -e

#how often tests are run (default once a day)
TEST_INTERVAL=${TEST_INTERVAL:-1}
#Substract one day, because first wait hours are computed before each run
TEST_INTERVAL_SECONDS=$((($TEST_INTERVAL - 1)*24*3600))
#start tests at this time (GMT):
TEST_TIME=${TEST_TIME:-23:00:00}

#URL files into bash array
FILES=($FILE_NAMES)

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

    for FILE in "${FILES[@]}"
    do
        if [ -v SLACK_WEBHOOK_URL ]; then
            # By default, uses 10 concurrent users every second for 60 seconds
            siege -c${CONCURRENT_USERS:10} -d1 -t${SIEGE_TIME:60s} -f $FILE 2>&1 | \
                jq -R -s '{channel: "siege-test", text: .}' | \
                curl -X POST -H 'Content-type: application/json'  -d@- \
                $SLACK_WEBHOOK_URL
        fi
    done


    if [[ "$BUILD_INTERVAL" -le 0 ]]; then
        #run only once
        exit 0
    fi
done
