#!/bin/sh

##
## Get gcr service account credentials and use it for docker login
##

PERSONAL_ACCESS_TOKEN=${PERSONAL_ACCESS_TOKEN}
REGISTRATION_TOKEN=${REGISTRATION_TOKEN}

if [ -z "${PERSONAL_ACCESS_TOKEN}" ] || [ -z "${REGISTRATION_TOKEN}" ]; then
    echo "Gitlab keys should be specified!\n"
    exit 1
fi

set -euo pipefail

CI_SERVER_URL="https://gitlab.com"
URL=${CI_SERVER_URL}/api/v4
TF_DIR="../cluster-configuration"

PROJECT_ID=`curl -s --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/projects?owned=true&search=catalog" | \
    jq ".[] | .id"`

update_variable () {
    KEY="${1}"
    echo "Updating ${KEY}"
    VALUE="${2}"
    curl -s -X "DELETE" --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/projects/${PROJECT_ID}/variables/${KEY}"
    curl -s --output /dev/null --header "PRIVATE-TOKEN: ${PERSONAL_ACCESS_TOKEN}" "${URL}/projects/${PROJECT_ID}/variables" \
        --form "key=${KEY}" --form "value=${VALUE}"
}

update_variable "PERSONAL_ACCESS_TOKEN" ${PERSONAL_ACCESS_TOKEN}
update_variable "REGISTRATION_TOKEN" ${REGISTRATION_TOKEN}
update_variable "TF_KEY" "`(cd ${TF_DIR} && cat credentials.json)`"
update_variable "GCR_KEY" "`(cd ${TF_DIR} && terraform output -module=gcr_service_account private_key)`"
update_variable "K8S_USERNAME" "`(cd ${TF_DIR} && terraform output -module=gke k8s_username)`"
update_variable "K8S_PASSWORD" "`(cd ${TF_DIR} && terraform output -module=gke k8s_password)`"
