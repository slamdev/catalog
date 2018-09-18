#!/bin/sh

set -euo pipefail

terraform init -backend-config=backend.tfvars
terraform plan -out=tfplan
terraform apply tfplan
