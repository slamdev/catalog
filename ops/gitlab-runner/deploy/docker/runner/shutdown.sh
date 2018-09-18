#!/usr/bin/env bash

set -e

URL=${CI_SERVER_URL}/api/v4

RUNNER_TOKEN=`grep token /etc/gitlab-runner/config.toml | cut -d '"' -f 2`

echo "Runner token is ${RUNNER_TOKEN}"

EXISTING_RUNNERS=`curl --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/runners/all" | \
    jq ".[] | select(.description == \"${RUNNER_NAME}\") | .id"`

echo "Existing runners are ${EXISTING_RUNNERS}"

RUNNER_ID=""
for runner in ${EXISTING_RUNNERS}; do
    current_token=`curl --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/runners/${runner}" | \
    jq -re ".token"`
    if [ "${current_token}" = "${RUNNER_TOKEN}" ]
    then
        RUNNER_ID=${runner}
        break
    fi
done

echo "Runner with token ${RUNNER_TOKEN} has ${RUNNER_ID} id"

if [ "${RUNNER_ID}" != "" ]
then
    while [ "`curl --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/runners/${RUNNER_ID}/jobs?status=running" | jq -re '.[].id'`" != "" ]
    do
        echo "Some jobs are still in progress"
        sleep 1
    done
fi

echo "No jobs are running at the moment. Shutting down the runner"
