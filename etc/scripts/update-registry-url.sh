#!/bin/sh

##
## Get gcr service account credentials and use it for docker login
##

set -euo pipefail

TF_DIR="../cluster-configuration"
PK=`(cd ${TF_DIR} && terraform output -module=gcr_service_account private_key)`
echo ${PK} | docker login -u _json_key --password-stdin https://asia.gcr.io
