#!/bin/sh

##
## Get gcr service account credentials and use it for docker login
##

set -euox pipefail

PROJECT_DIR="../../"
TF_DIR="../cluster-configuration"
PROJECT_ID=`(cd ${TF_DIR} && terraform output -module=project project_id)`

asia.gcr.io/catalog-8c920686/catalog-dind


grep -rl --exclude-dir="*.git" --exclude-dir="*.idea" --exclude-dir="*.gradle" registry.adnz.co/playground . | xargs sed -i '' -e s^registry.adnz.co/playground^slamdev^g
