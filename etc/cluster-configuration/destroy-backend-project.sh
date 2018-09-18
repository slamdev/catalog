#!/bin/sh

set -euo pipefail

TERRAFORM_BACKEND_PROJECT="catalog-tf-backend"
ORGANIZATION_ID=`gcloud organizations list --format="get(name)" | grep -oE "[^/]+$"`
TERRAFORM_BACKEND_PROJECT_ID=`gcloud projects list --filter="name=${TERRAFORM_BACKEND_PROJECT}" --format="get(project_id)"`

gcloud organizations remove-iam-policy-binding ${ORGANIZATION_ID} \
  --member serviceAccount:terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/billing.user

gcloud organizations remove-iam-policy-binding ${ORGANIZATION_ID} \
  --member serviceAccount:terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/resourcemanager.projectCreator

gcloud -q iam service-accounts delete terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com

gcloud -q projects delete ${TERRAFORM_BACKEND_PROJECT_ID}
