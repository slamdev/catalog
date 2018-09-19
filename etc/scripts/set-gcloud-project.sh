#!/bin/sh

##
## Set current project in gcloud cli
##

set -euo pipefail

TF_DIR="../cluster-configuration"
CURRENT_PROJECT_ID=`(cd ${TF_DIR} && terraform output -module=project project_id)`

gcloud config set project ${CURRENT_PROJECT_ID}
