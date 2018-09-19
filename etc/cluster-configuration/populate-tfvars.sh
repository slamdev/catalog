#!/bin/sh

if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "K8S credentials should be specified!\n"
    exit 1
fi

GENERATED_CREDENTIALS="credentials.json"

# Allow CI to pass gcloud key file
if [ "${TF_KEY}" ]; then
    echo ${TF_KEY} > ${GENERATED_CREDENTIALS}
    gcloud auth activate-service-account --key-file ${GENERATED_CREDENTIALS}
fi

set -euo pipefail

K8S_USERNAME=${1}
K8S_PASSWORD=${2}

TERRAFORM_BACKEND_PROJECT="catalog-tf-backend"
REGION="australia-southeast1"
GKE_PROJECT="catalog"
DNS_NAME="catalog.slamdev.net."
GENERATED_CREDENTIALS="credentials.json"

ORGANIZATION_ID=`gcloud organizations list --format="get(name)" | grep -oE "[^/]+$"`
BILLING_ACCOUNT_ID=`gcloud beta billing accounts list --format="get(name)" | grep -oE "[^/]+$"`
TERRAFORM_BACKEND_PROJECT_ID=`gcloud projects list --filter="name=${TERRAFORM_BACKEND_PROJECT}" --format="get(project_id)"`

if [ ! -f "${GENERATED_CREDENTIALS}" ]; then
    gcloud iam service-accounts keys create ${GENERATED_CREDENTIALS} \
        --iam-account terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com
fi

# backend.tfvars
cat > backend.tfvars <<EOF
credentials = "${GENERATED_CREDENTIALS}"
bucket = "${TERRAFORM_BACKEND_PROJECT_ID}"
prefix = "${GKE_PROJECT}"
EOF

# terraform.tfvars
cat > terraform.tfvars <<EOF
gce_credentials = "${GENERATED_CREDENTIALS}"
project_name = "${GKE_PROJECT}"
region = "${REGION}"
billing_account = "${BILLING_ACCOUNT_ID}"
organization_id = "${ORGANIZATION_ID}"
dns_name = "${DNS_NAME}"
k8s_username = "${K8S_USERNAME}"
k8s_password = "${K8S_PASSWORD}"
EOF
