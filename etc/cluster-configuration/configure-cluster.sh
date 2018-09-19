#!/bin/sh

set -euo pipefail

terraform init -backend-config=backend.tfvars
#terraform plan -out=tfplan
# explicitly specify all the modules except gke
# due to the https://github.com/terraform-providers/terraform-provider-google/issues/2022 issue
terraform plan -target=module.project -target=module.gcr_service_account -out=tfplan
terraform apply tfplan
