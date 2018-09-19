#!/bin/sh

set -euo pipefail

TERRAFORM_BACKEND_PROJECT="catalog-tf-backend"
REGION="australia-southeast1"

ORGANIZATION_ID=`gcloud organizations list --format="get(name)" | grep -oE "[^/]+$"`
BILLING_ACCOUNT_ID=`gcloud beta billing accounts list --format="get(name)" | grep -oE "[^/]+$"`
RANDOM_ID=`openssl rand -hex 3`
TERRAFORM_BACKEND_PROJECT_ID="${TERRAFORM_BACKEND_PROJECT}-`openssl rand -hex 4`"

##
## Setup Google Cloud Project
##

ORIGINAL_PROJECT=`gcloud config get-value project`

# Create admin project
gcloud projects create ${TERRAFORM_BACKEND_PROJECT_ID} --set-as-default \
  --name=${TERRAFORM_BACKEND_PROJECT} --organization=${ORGANIZATION_ID}
# Enable project billing
gcloud beta billing projects link ${TERRAFORM_BACKEND_PROJECT_ID} --billing-account ${BILLING_ACCOUNT_ID}
# Create service account for terraform
gcloud iam service-accounts create terraform --display-name "Terraform admin account"
# Allow service account to view project
gcloud projects add-iam-policy-binding ${TERRAFORM_BACKEND_PROJECT_ID} \
  --member serviceAccount:terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/viewer
# Allow service account to manage Google Storage
gcloud projects add-iam-policy-binding ${TERRAFORM_BACKEND_PROJECT_ID} \
  --member serviceAccount:terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/storage.admin
# Enable required services
gcloud services enable cloudresourcemanager.googleapis.com \
  && gcloud services enable cloudbilling.googleapis.com \
  && gcloud services enable iam.googleapis.com \
  && gcloud services enable compute.googleapis.com \
  && gcloud services enable sqladmin.googleapis.com \
  && gcloud services enable container.googleapis.com
# Allow service account to create projects
gcloud organizations add-iam-policy-binding ${ORGANIZATION_ID} \
  --member serviceAccount:terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/resourcemanager.projectCreator
# Allow service account to enable billing for projects
gcloud organizations add-iam-policy-binding ${ORGANIZATION_ID} \
  --member serviceAccount:terraform@${TERRAFORM_BACKEND_PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/billing.user
# Create Google Storage bucket to save terraform state
gsutil mb -p ${TERRAFORM_BACKEND_PROJECT_ID} -l ${REGION} gs://${TERRAFORM_BACKEND_PROJECT_ID}
# Enable versioning for Google Storage bucket
gsutil versioning set on gs://${TERRAFORM_BACKEND_PROJECT_ID}
# Restore original project
gcloud config set project ${ORIGINAL_PROJECT}
