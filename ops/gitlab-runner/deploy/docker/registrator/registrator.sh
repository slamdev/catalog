#!/usr/bin/env bash

set -e

CI_SERVER_URL="https://gitlab.com"

URL=${CI_SERVER_URL}/api/v4

EXISTING_RUNNERS=`curl --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/runners" | \
    jq ".[] | select(.description == \"${RUNNER_NAME}\") | .id"`

for runner in ${EXISTING_RUNNERS}; do
    while [ "`curl --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/runners/${runner}/jobs?status=running" | \
        jq -re '.[].id'`" != "" ]
    do
        echo "Some jobs are still in progress"
        sleep 1
    done
    echo "Deleting existing runner: ${runner}"
    curl --request DELETE --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/runners/${runner}"
done

RUNNER_TOKEN=`curl --request POST "${URL}/runners" \
    --form "token=${REGISTRATION_TOKEN}" \
    --form "description=${RUNNER_NAME}" \
    --form "locked=true" \
    --form "run_untagged=false" \
    --form "tag_list=${RUNNER_TAG_LIST}" | \
    jq -r '.token'`

echo "Runner is registered with token: ${RUNNER_TOKEN}"

cp ${GITLAB_CONFIG_FILE} /etc/gitlab-ranner-patched-config/config.toml

sed -i -e "s/_TOKEN_/${RUNNER_TOKEN}/g" /etc/gitlab-ranner-patched-config/config.toml
