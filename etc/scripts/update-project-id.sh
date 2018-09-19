#!/bin/sh

##
## Update entries of project id to the new one in all project files
## mainly to update gcr registry url
##

set -euox pipefail

PROJECT_DIR="../../"
TF_DIR="../cluster-configuration"
CURRENT_PROJECT_ID=`(cd ${TF_DIR} && terraform output -module=project project_id)`
LEGACY_PROJECT_ID=`(cd ${PROJECT_DIR} && cat .gitlab-ci.yml | yq r - -j | jq -re '[.. | .image? | select(type != "null")][0]' | tr "/" "\n" | sed -n 2p)`

grep -rl --exclude-dir="*.git" --exclude-dir="*.idea" --exclude-dir="*.gradle" ${LEGACY_PROJECT_ID} . | \
    xargs sed -i '' -e s^${LEGACY_PROJECT_ID}^${CURRENT_PROJECT_ID}^g
